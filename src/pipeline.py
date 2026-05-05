"""
pipeline.py — Main pipeline that wires all components together.

What this does:
  Takes a question + database path and returns a final answer
  by routing through the 3 agentic components in order:

    1. Router  → decide SQL / VECTOR / HYBRID
    2. Retriever → get few-shot examples (SQL path) or doc chunks (VECTOR path)
    3. Generator + Self-Correction → generate SQL, execute, fix if needed

  Also supports a "baseline" mode that skips all agentic features
  (no few-shot, no correction) for the comparison experiment.
"""

# import json
# import os
# import re
# import subprocess
import logging
import time
from typing import Any
from src.prompts import ANSWER_QUESTION_PROMPT
from src.router import route, ROUTE_SQL, ROUTE_VECTOR, ROUTE_HYBRID, MODE_AGENTIC, MODE_BASELINE, MODE_CLOUD
from src.few_shot_retriever import retrieve, format_examples_for_prompt
from src.self_correction import generate_and_correct, generate_sql_gpt4, _build_generation_prompt, _call_and_extract
from src.utils import correct_route, load_schema, execute_sql # , extract_sql
from src.llm import call_copilot, call_llm
from indexing.index_documents import query_documents

log = logging.getLogger(__name__)

def run(
    ex: dict,
    question: str,
    db_path: str,
    config: dict,
    mode: str = "agentic",
    dataset: str = "spider",
    evaluate: bool = False,
) -> dict:
    """
    Runs the full pipeline for one question.

    Args:
        question: natural language question
        db_path:  path to the SQLite database for this question
        config:   loaded config dict
        mode:     "agentic"  → full pipeline (router + few-shot + self-correction)
                  "baseline" → just the LLM, no agentic features
                  "cloud"    → call Copilot CLI model from config (no agentic loops)

    Returns a dict with:
        route:     SQL / VECTOR / HYBRID (or "SQL" for baseline)
        sql:       generated SQL query
        success:   whether the SQL executed without error
        result:    query result rows (or document answer text)
        attempts:  how many correction attempts were made
        mode:      which mode was used
    """
    MODE = mode.lower()
    schema = load_schema(db_path) if db_path else ""

    if MODE == MODE_BASELINE:
        return _run_base(ex,question, schema, db_path, config, dataset, evaluate=evaluate)
    elif MODE == MODE_CLOUD:
        return _run_gpt41(ex, question, schema, db_path, config, dataset, evaluate=evaluate)
    elif MODE == MODE_AGENTIC:
        return _run_agentic(ex,question, schema, db_path, config, dataset, evaluate=evaluate)
    else:
        raise ValueError(f"Unsupported mode: {mode}")


# ─────────────────────────────────────────────
# AGENTIC mode (full pipeline)
# ─────────────────────────────────────────────

def _run_agentic(
    ex: dict,
    question: str,
    schema: str,
    db_path: str,
    config: dict,
    dataset: str,
    evaluate: bool = False,
) -> dict:
    """Full agentic pipeline: route → retrieve → generate → self-correct."""
    latency = {}
    # Step 1: Route the question
    if dataset == "spider":
        route_label = "SQL"
        latency["routing"] = 0.0
    elif dataset == "nawa":
        start = time.perf_counter()
        route_label = route(question, config, MODE_AGENTIC)
        latency["routing"] = time.perf_counter() - start
    else:
        raise ValueError(f"Unknown dataset: {dataset}")

    # Step 2: Retrieve context based on route
    few_shot_prompt = ""
    doc_context     = ""
    retrieved_chunks = []
    
    start = time.perf_counter()
    if route_label in (ROUTE_SQL, ROUTE_HYBRID):
        examples        = retrieve(question, schema, config)
        few_shot_prompt = format_examples_for_prompt(examples)
        print(f"Retrieved {len(examples)} few-shot examples for prompt.")
        for ex in examples:
            print(f"Example question: {ex.get('question', 'N/A')}")
            print(f"Example SQL: {ex.get('sql', 'N/A')}")
            print("-"*30)
        
    if route_label in (ROUTE_VECTOR, ROUTE_HYBRID):
        retrieved_chunks = query_documents(question, config)
        doc_context = _format_doc_chunks(retrieved_chunks)
    latency["retrieval"] = time.perf_counter() - start
    
    # Step 3: For vector-only questions, generate a text answer
    start = time.perf_counter()
    if route_label == ROUTE_VECTOR:
        answer = _generate_text_answer(question, doc_context, config, mode=MODE_AGENTIC)
        latency["text_only_answer"] = time.perf_counter() - start
        latency["sql_generation"] = 0.0
        latency["full_answer"] = 0.0
        return {
            "route":    route_label,
            "sql":      None,
            "success":  True,
            "answer":   answer,
            "attempts": 1,
            "mode":     MODE_AGENTIC,
            "retrieved_chunks": retrieved_chunks,
            "context": doc_context,
            "latency": latency,  
        }
    else:
        latency["text_only_answer"] = 0.0

    # Step 4: For SQL or HYBRID, generate SQL with self-correction.
    start = time.perf_counter()
    result = generate_and_correct(
        question=question,
        schema=schema,
        db_path=db_path,
        few_shot_prompt=few_shot_prompt,
        config=config,
    )
    latency["sql_generation"] = time.perf_counter() - start
    
    start = time.perf_counter()
    if correct_route(ex, route_label):
        answer = _generate_answer(question, doc_context, result["result"], config=config, mode=MODE_AGENTIC)
        result["answer"] = answer.strip()
        latency["full_answer"] = time.perf_counter() - start
    else:
        result["answer"] = ""
        latency["full_answer"] = 0.0
        
    result["context"] = doc_context
    result["route"] = route_label
    result["mode"]  = MODE_AGENTIC
    result["retrieved_chunks"] = retrieved_chunks
    result["latency"] = latency
    return result

def _run_base(
    ex: dict,
    question: str,
    schema: str,
    db_path: str,
    config: dict,
    dataset: str,
    evaluate: bool = False,
) -> dict:
    """Full agentic pipeline: route → retrieve → generate → self-correct."""
    latency = {}
    # Step 1: Route the question
    if dataset == "spider":
        route_label = "SQL"
        latency["routing"] = 0.0
    elif dataset == "nawa":
        start = time.perf_counter()
        route_label = route(question, config, MODE_BASELINE)
        latency["routing"] = time.perf_counter() - start
    else:
        raise ValueError(f"Unknown dataset: {dataset}")

    # Step 2: Retrieve context based on route
    few_shot_prompt = ""
    doc_context     = ""
    retrieved_chunks = []
    
    start = time.perf_counter()
    if route_label in (ROUTE_VECTOR, ROUTE_HYBRID):
        retrieved_chunks = query_documents(question, config)
        doc_context = _format_doc_chunks(retrieved_chunks)
    latency["retrieval"] = time.perf_counter() - start
    
    # Step 3: For vector-only questions, generate a text answer
    start = time.perf_counter()
    if route_label == ROUTE_VECTOR:
        answer = _generate_text_answer(question, doc_context, config, mode=MODE_BASELINE)
        latency["text_only_answer"] = time.perf_counter() - start
        latency["sql_generation"] = 0.0
        latency["full_answer"] = 0.0
        return {
            "route":    route_label,
            "sql":      None,
            "success":  True,
            "answer":   answer,
            "attempts": 1,
            "mode":     MODE_BASELINE,
            "retrieved_chunks": retrieved_chunks,
            "context": doc_context,
            "latency": latency,  
        }
    else:
        latency["text_only_answer"] = 0.0

    # Step 4: For SQL or HYBRID, generate SQL with self-correction.
    start = time.perf_counter() 
    prompt  = _build_generation_prompt(question, schema, few_shot_prompt=few_shot_prompt, company_name=db_path)
    raw_sql = _call_and_extract(prompt, config["model"], config["ollama_base_url"])
    success, db_data = execute_sql(db_path, raw_sql)
    latency["sql_generation"] = time.perf_counter() - start
    
    start = time.perf_counter()
    print(f"Baseline SQL result: {db_data}")
    answer = _generate_answer(question, "", db_data, config=config, mode=MODE_BASELINE)
    latency["full_answer"] = time.perf_counter() - start
    latency["text_only_answer"] = 0.0
    print(db_data)
    result = {
        "result": db_data,
        "sql":      raw_sql,
        "success":  success,
        "attempts": 1,
    }
    
    start = time.perf_counter()
    if correct_route(ex, route_label):
        answer = _generate_answer(question, doc_context, db_data, config=config, mode=MODE_BASELINE)
        result["answer"] = answer.strip()
        latency["full_answer"] = time.perf_counter() - start
    else:
        result["answer"] = ""
        latency["full_answer"] = 0.0
    
    result["context"] = doc_context
    result["route"] = route_label
    result["mode"]  = MODE_BASELINE
    result["retrieved_chunks"] = retrieved_chunks
    result["latency"] = latency
    print(result)
    return result


# ─────────────────────────────────────────────
# BASELINE mode (no agentic features)
# ─────────────────────────────────────────────

# def _run_baseline_new(
#     ex: dict,
#     question: str,
#     schema: str,
#     db_path: str,
#     config: dict,
#     dataset: str,
#     evaluate: bool = False,
# ) -> dict:
#     """Full agentic pipeline: route → retrieve → generate → self-correct."""
#     latency = {}
#      # Step 2: Retrieve context based on route
#     few_shot_prompt = ""
#     doc_context     = ""
#     retrieved_chunks = []
#     route_label = ex.get("route", ROUTE_SQL)  # default to SQL if not specified

#     start = time.perf_counter()
#     examples = retrieve(question, schema, config)
#     few_shot_prompt = format_examples_for_prompt(examples)
#     retrieved_chunks = query_documents(question, config)
#     doc_context = _format_doc_chunks(retrieved_chunks)
#     latency["retrieval"] = time.perf_counter() - start
    
#     # Step 3: For vector-only questions, generate a text answer
#     start = time.perf_counter()
#     answer = _generate_text_answer(question, doc_context, config, mode=MODE_BASELINE)
#     latency["text_only_answer"] = time.perf_counter() - start


#     # Step 4: For SQL or HYBRID, generate SQL with self-correction.
#     start = time.perf_counter()
#     prompt  = _build_generation_prompt(question, schema, few_shot_prompt=few_shot_prompt, company_name=db_path)
#     raw_sql = _call_and_extract(prompt, config["model"], config["ollama_base_url"])
#     success, result = execute_sql(db_path, raw_sql)
#     latency["sql_generation"] = time.perf_counter() - start
    
#     start = time.perf_counter()
#     answer = _generate_answer(question, doc_context, result["result"], config=config, mode=MODE_BASELINE)
#     result["answer"] = answer.strip()
#     latency["full_answer"] = time.perf_counter() - start

#     result["success"] = success
#     result["context"] = doc_context
#     result["route"] = route_label
#     result["mode"]  = MODE_BASELINE
#     result["retrieved_chunks"] = retrieved_chunks
#     result["latency"] = latency
#     return result



def _run_baseline( question: str, schema: str, db_path: str, config: dict) -> dict:
    """
    Baseline: just the raw LLM, no router, no few-shot, no correction.
    This is what a plain SLM looks like without any augmentation.
    Used as the lower-bound comparison in the evaluation.
    """
    latency = {}
    few_shot_prompt = ""
    doc_context     = ""
    retrieved_chunks = []
    
    start = time.perf_counter()
    # examples = retrieve(question, schema, config)
    # few_shot_prompt = format_examples_for_prompt(examples)
    retrieved_chunks = query_documents(question, config)
    doc_context = _format_doc_chunks(retrieved_chunks)
    latency["retrieval"] = time.perf_counter() - start
    
    # vec_result =  _run_baseline_vector(question, retrieved_chunks, doc_context, config, latency)
    sql_result = _run_baseline_sql(question, schema, db_path, few_shot_prompt, config, latency)
    # hybrid_result = _run_baseline_hybrid(question, schema, db_path, few_shot_prompt, retrieved_chunks, doc_context, config, latency)
    return sql_result
    return {
        # "vector": vec_result,
        "sql": sql_result,
        # "hybrid": hybrid_result,
    }
      
def _run_baseline_sql(question: str, schema: str, db_path: str,few_shot_prompt: str, config: dict, latency: dict) -> dict:
    latency = {}
    start = time.perf_counter() 
    prompt  = _build_generation_prompt(question, schema, few_shot_prompt=few_shot_prompt, company_name=db_path)
    raw_sql = _call_and_extract(prompt, config["model"], config["ollama_base_url"])
    success, result = execute_sql(db_path, raw_sql)
    latency["sql_generation"] = time.perf_counter() - start
    
    start = time.perf_counter()
    print(f"Baseline SQL result: {result}")
    answer = ""# _generate_answer(question, "", result, config=config, mode=MODE_BASELINE)
    latency["full_answer"] = time.perf_counter() - start
    latency["text_only_answer"] = 0.0
        
    return {
        "route":    ROUTE_SQL,
        "sql":      raw_sql,
        "success":  success,
        "result":   result,
        "attempts": 1,
        "mode":     MODE_BASELINE,
        "context": "",
        "retrieved_chunks": None,
        "answer": answer.strip(),
        "latency":  latency
    }
    
# def _run_baseline_vector(question: str, retrieved_chunks: list, doc_context: str, config: dict, latency: dict) -> dict:
#     start = time.perf_counter()
#     answer = _generate_text_answer(question, doc_context, config, mode=MODE_BASELINE)
#     latency["text_only_answer"] = time.perf_counter() - start
#     latency["sql_generation"] = 0.0
#     latency["full_answer"] = 0.0
#     return {
#         "route":    ROUTE_VECTOR,
#         "sql":      None,
#         "success":  True,
#         "answer":   answer,
#         "attempts": 1,
#         "mode":     MODE_BASELINE,
#         "retrieved_chunks": retrieved_chunks,
#         "context": doc_context,
#         "latency": latency,  
#     }

# def _run_baseline_hybrid(question, schema, db_path, few_shot_prompt, retrieved_chunks, doc_context, config, latency ):
#     latency = {}
#     start = time.perf_counter() 
#     prompt  = _build_generation_prompt(question, schema, few_shot_prompt=few_shot_prompt, company_name=db_path)
#     raw_sql = _call_and_extract(prompt, config["model"], config["ollama_base_url"])
#     success, result = execute_sql(db_path, raw_sql)
#     latency["sql_generation"] = time.perf_counter() - start
#     print(f"Baseline SQL result: {result}")

#     start = time.perf_counter()
#     answer = _generate_answer(question, doc_context, result, config=config, mode=MODE_BASELINE)
#     latency["full_answer"] = time.perf_counter() - start
#     latency["text_only_answer"] = 0.0
        
#     return {
#         "route":    ROUTE_HYBRID,
#         "sql":      raw_sql,
#         "success":  success,
#         "result":   result,
#         "attempts": 1,
#         "mode":     MODE_BASELINE,
#         "context": doc_context,
#         "retrieved_chunks": retrieved_chunks,
#         "answer": answer.strip(),
#         "latency":  latency
#     }
    

# ─────────────────────────────────────────────
# Openrouter mode 
# ─────────────────────────────────────────────
# def _run_openrouter(ex: dict, question: str, schema: str, db_path: str, config: dict) -> None:
#     import requests
#     url = "https://openrouter.ai/api/v1/chat/completions"
#     headers = {
#     "Authorization": f"Bearer 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",
#     "Content-Type": "application/json"
#     }

#     documents_dir = os.path.abspath(config.get("documents_dir", "data/documents"))
#     db_path_abs = os.path.abspath(db_path) if db_path else ""

#     if not os.path.isdir(documents_dir):
#         raise FileNotFoundError(f"documents_dir not found: {documents_dir}")

#     system_prompt = """You are a query router and retrieval assistant for a database + document system.
#         You will receive the following inputs:
#         1. A question from the dataset
#         2. Database schema
#         3. Path to the database file
#         4. Path to the folder with all PDF documents

#         Your task is to first decide what route to take based on the question, and then return the appropriate JSON response.

#         ### Routing Rules
#         Classify the user question into exactly one of three routes:

#         - **SQL**: The question asks for structured data that lives in a database: counts, totals, filtering records, rankings, averages, finding specific entries, listing items. ANY question that can be answered by querying a table belongs here.
#         Examples: "How many X", "Which X has the highest Y", "List all X where Y", "What is the total X", "Find the X with Y", "How old is X", "What is the name of X"

#         - **VECTOR**: ONLY use this when the question EXPLICITLY asks for explanations, reasons, summaries or context from written documents or reports.
#         Examples: "According to the report...", "What does the policy say about...", "Summarize the document about...", "What is the reason described in..."

#         - **HYBRID**: ONLY use this when the question EXPLICITLY needs BOTH a database query AND a document explanation in the same answer.
#         Example: "What were Q3 sales numbers AND why did they change according to the report?"

#         **Decision Constraints:**
#         - Decide ONLY one: SQL, VECTOR, or HYBRID
#         - DEFAULT to SQL when in any doubt — most questions are SQL questions
#         - Only choose VECTOR or HYBRID if the question clearly references documents or reports

#         ### Output Format
#         Based on the chosen route, you MUST output strictly valid JSON matching exactly the following structures. Do not include any other text, markdown formatting, or explanations outside the JSON.
#         For SQL route: query should be filled, relevant_documents should be an empty list.
#         For VECTOR route: query should be an empty string, relevant_documents should list the PDF files that are relevant.
#         For HYBRID route: query should be filled, relevant_documents should list the PDF files that are relevant.

#         {"route": "<SQL|VECTOR|HYBRID>", "query": "<generated_sql_query>", "relevant_documents": ["<path_to_folder>/<document_name>.pdf"]}

#         *Note: For SQL queries, use the provided database schema to write accurate SQLite query (important). For relevant documents, use the provided folder path and append the appropriate exact PDF file names that contain the answer to the question if any.*"""

#     user_prompt = f"""Question:
#         {question}

#         Database schema:
#         {schema or "(no schema provided)"}

#         Database file path:
#         {db_path_abs or "(no database file)"}

#         PDF documents folder path:
#         {documents_dir}
#         """
#     prompt = f"{system_prompt}\n\n{user_prompt}"
#     payload = {
#     "model": "qwen/qwen3-coder:free", # inclusionai/ling-2.6-1t:free
#     "messages": [{"role": "user", "content": prompt}],
#     "stream": True
#     }

#     buffer = ""
#     with requests.post(url, headers=headers, json=payload, stream=True) as r:
#         for line in r.iter_lines(decode_unicode=True):
#             if not line:
#                 continue

#             if line.startswith("data: "):
#                 data = line[6:]

#                 if data == "[DONE]":
#                     break

#                 try:
#                     data_obj = json.loads(data)
#                     delta = data_obj["choices"][0]["delta"]
#                     content = delta.get("content")

#                     if content:
#                         print(content, end="", flush=True)

#                 except Exception:
#                     continue
                    
#     print("\n[Openrouter stream ended]")


# ─────────────────────────────────────────────
# Copilot CLI mode (no agentic loop)
# ─────────────────────────────────────────────
def _run_gpt41(
    ex: dict,
    question: str,
    schema: str,
    db_path: str,
    config: dict,
    dataset: str,
    evaluate: bool = False,
) -> dict:
    latency = {}
     # Step 1: Route the question
    if dataset == "spider":
        route_label = "SQL"
        latency["routing"] = 0.0
    elif dataset == "nawa":
        start = time.perf_counter()
        route_label = route(question, config, MODE_CLOUD)
        latency["routing"] = time.perf_counter() - start
    else:
        raise ValueError(f"Unknown dataset: {dataset}")
    
    # Step 2: Retrieve context based on route
    doc_context     = ""
    retrieved_chunks = []
    
    start = time.perf_counter()
    if route_label in (ROUTE_VECTOR, ROUTE_HYBRID):
        retrieved_chunks = query_documents(question, config)
        doc_context = _format_doc_chunks(retrieved_chunks)
    latency["retrieval"] = time.perf_counter() - start
    
    start = time.perf_counter()
    if route_label == ROUTE_VECTOR:
        answer = _generate_text_answer(question, doc_context, config, mode=MODE_CLOUD)
        latency["text_only_answer"] = time.perf_counter() - start
        latency["sql_generation"] = 0.0
        latency["full_answer"] = 0.0
        return {
            "route":    ROUTE_VECTOR,
            "sql":      None,
            "success":  True,
            "answer":   answer,
            "attempts": 1,
            "mode":     MODE_CLOUD,
            "retrieved_chunks": retrieved_chunks,
            "context": doc_context,
            "latency": latency,
        }
    else:        
        latency["text_only_answer"] = 0.0
    
    start = time.perf_counter()
    result = generate_sql_gpt4(
        question=question,
        schema=schema,
        db_path=db_path,
    )
    latency["sql_generation"] = time.perf_counter() - start
    
    start = time.perf_counter()
    if correct_route(ex, route_label):
        answer = _generate_answer(question, doc_context, result["result"], config=config, mode=MODE_CLOUD)
        result["answer"] = answer.strip()
        latency["full_answer"] = time.perf_counter() - start  
    else:
        result["answer"] = ""
        latency["full_answer"] = 0.0
        
    result["context"] = doc_context
    result["route"] = route_label
    result["mode"]  = MODE_CLOUD
    result["retrieved_chunks"] = retrieved_chunks
    result["latency"] = latency
    return result

# ─────────────────────────────────────────────
# Helpers
# ─────────────────────────────────────────────

def _format_doc_chunks(chunks: list[dict]) -> str:
    if not chunks:
        return ""
    parts = []
    for i, chunk in enumerate(chunks, 1):
        parts.append(f"[Document chunk {i} from {chunk['source']}]\n{chunk['text']}")
    return "\n\n".join(parts)


def _generate_text_answer(question: str, doc_context: str, config: dict, mode: str) -> str:
    """Generates a natural language answer from document context."""
    prompt = f"""Use the following document context to answer the question.
Be concise and factual. Only use information from the context.

=== Context ===
{doc_context}

=== Question ===
{question}

Answer:"""
    if mode == MODE_AGENTIC or mode == MODE_BASELINE:
        return call_llm(
            prompt=prompt,
            model=config["model"],
            base_url=config["ollama_base_url"],
            stream=False,
            temperature=0.0,
        )
    elif mode == MODE_CLOUD:
        return call_copilot(
            prompt=prompt,
            model="gpt-4.1"
        )
    else:
        raise ValueError(f"Unsupported mode for text answer generation: {mode}")
    

def _generate_answer(question: str, doc_context:str, result: tuple[bool, Any], config: dict, mode:str) -> str:
    if mode == MODE_AGENTIC or mode == MODE_BASELINE:
        return call_llm(prompt=ANSWER_QUESTION_PROMPT(question, doc_context, result), 
                        model=config["model"], 
                        base_url=config["ollama_base_url"], 
                        stream=False, 
                        temperature=0.0)
    elif mode == MODE_CLOUD:
        return call_copilot(prompt=ANSWER_QUESTION_PROMPT(question, doc_context, result), 
                            model="gpt-4.1")
    else:
        raise ValueError(f"Unsupported mode for answer generation: {mode}")