# NaWa

NaWa is a small, pluggable hybrid RAG framework for Text-to-SQL. It retrieves
schema descriptions, documentation, and few-shot examples, routes requests to a
generation strategy, and can retry SQL generation using validator feedback.

## Quick start

```python
from nawa import FewShotExample, HybridRetriever, TextToSQL


class Generator:
    def generate(self, prompt, strategy):
        # Connect your preferred language model here.
        return "SELECT customer_id FROM orders"


class Validator:
    def validate(self, sql):
        # Return None for valid SQL or a diagnostic string for invalid SQL.
        return None


retriever = HybridRetriever(
    schemas=["orders(order_id, customer_id, total)"],
    documentation=["total is the order value before tax"],
    examples=[
        FewShotExample(
            question="List order totals",
            sql="SELECT total FROM orders",
        )
    ],
)
result = TextToSQL(retriever, Generator(), Validator()).run(
    "List customer IDs"
)
print(result.sql)
```

An optional `embedder` callable can be passed to `HybridRetriever` to combine
cosine similarity with lexical overlap. The generator and validator are
interfaces intended to be supplied by the application; NaWa does not execute
generated SQL or connect to a database. Use a validator configured for
read-only/safe validation before running generated statements in your system.
`TextToSQL.run` returns the selected strategy, retrieved context, number of
generation attempts, whether validation was performed, and any remaining
validation error. Results without a validator are not marked valid.

## Tests

Run the standard-library unit tests with:

```sh
python -m unittest discover -s tests
```