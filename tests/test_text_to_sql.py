import unittest

from nawa import (
    FewShotExample,
    GenerationStrategy,
    HybridRetriever,
    RetrievedItem,
    TextToSQL,
)


class FakeGenerator:
    def __init__(self, outputs):
        self.outputs = iter(outputs)
        self.calls = []

    def generate(self, prompt, strategy):
        self.calls.append((prompt, strategy))
        return next(self.outputs)


class FirstAttemptFails:
    def __init__(self):
        self.calls = 0

    def validate(self, sql):
        self.calls += 1
        return "unknown column" if self.calls == 1 else None


class TextToSQLTests(unittest.TestCase):
    def test_hybrid_retrieves_schema_documentation_and_examples(self):
        retriever = HybridRetriever(
            schemas=["orders(order_id, customer_id, total)"],
            documentation=["total is the order value before tax"],
            examples=[
                FewShotExample(
                    "Find order totals", "SELECT total FROM orders", identifier="totals"
                )
            ],
        )

        schema, docs, examples = retriever.retrieve("order total", top_k=2)

        self.assertEqual(schema[0].kind, "schema")
        self.assertEqual(docs[0].kind, "documentation")
        self.assertEqual(examples[0].kind, "example")
        self.assertEqual(examples[0].identifier, "totals")

    def test_embeddings_rank_items_even_when_identifiers_are_reused(self):
        vectors = {
            "orders(total)": [1.0, 0.0],
            "customers(name)": [0.0, 1.0],
            "order totals": [1.0, 0.0],
        }
        retriever = HybridRetriever(
            schemas=[
                # Identifiers may be supplied by separate catalog sources.
                RetrievedItem("shared", "orders(total)", "schema", 0.0),
                RetrievedItem("shared", "customers(name)", "schema", 0.0),
            ],
            embedder=lambda text: vectors[text],
        )

        schema, _, _ = retriever.retrieve("order totals", top_k=2)

        self.assertEqual(schema[0].content, "orders(total)")

    def test_router_selects_decomposed_few_shot_and_direct_modes(self):
        retriever = HybridRetriever(
            schemas=["sales(order_id, amount)"],
            examples=[FewShotExample("show sales", "SELECT * FROM sales")],
        )
        generator = FakeGenerator(["SELECT * FROM sales"] * 4)
        pipeline = TextToSQL(retriever, generator)

        decomposed = pipeline.run("Compare sales over time")
        few_shot = pipeline.run("Show sales")
        direct = TextToSQL(HybridRetriever(), generator).run("Show me something")
        beach = TextToSQL(HybridRetriever(), generator).run("Which beach has most customers?")

        self.assertEqual(decomposed.strategy, GenerationStrategy.DECOMPOSED)
        self.assertEqual(few_shot.strategy, GenerationStrategy.FEW_SHOT)
        self.assertEqual(direct.strategy, GenerationStrategy.DIRECT)
        self.assertEqual(beach.strategy, GenerationStrategy.DIRECT)
        self.assertFalse(direct.valid)

    def test_validator_feedback_triggers_one_self_correction(self):
        generator = FakeGenerator(["SELECT missing FROM orders", "SELECT total FROM orders"])
        validator = FirstAttemptFails()
        pipeline = TextToSQL(
            HybridRetriever(schemas=["orders(total)"]),
            generator,
            validator=validator,
            max_corrections=1,
        )

        result = pipeline.run("Show order total")

        self.assertTrue(result.valid)
        self.assertEqual(result.sql, "SELECT total FROM orders")
        self.assertEqual(result.attempts, 2)
        self.assertIn("unknown column", generator.calls[1][0])

    def test_failed_validation_is_returned_after_correction_limit(self):
        generator = FakeGenerator(["SELECT bad", "SELECT still_bad"])

        class AlwaysFails:
            def validate(self, sql):
                return "invalid SQL"

        result = TextToSQL(
            HybridRetriever(), generator, validator=AlwaysFails(), max_corrections=1
        ).run("Show records")

        self.assertFalse(result.valid)
        self.assertEqual(result.attempts, 2)
        self.assertEqual(result.validation_error, "invalid SQL")

    def test_rejects_empty_question_and_negative_limits(self):
        with self.assertRaises(ValueError):
            HybridRetriever().retrieve("test", top_k=-1)
        with self.assertRaises(ValueError):
            TextToSQL(HybridRetriever(), FakeGenerator([]), top_k=-1)
        with self.assertRaises(ValueError):
            TextToSQL(HybridRetriever(), FakeGenerator([]), max_corrections=-1)
        with self.assertRaises(ValueError):
            TextToSQL(HybridRetriever(), FakeGenerator([])).run("  ")


if __name__ == "__main__":
    unittest.main()
