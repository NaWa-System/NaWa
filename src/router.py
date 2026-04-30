"""
router.py — Component 1: Hybrid Router.

What this does:
  The router receives the user's question and classifies it into one of three routes:
    - SQL    → question needs structured data from a database (counts, filters, aggregations)
    - VECTOR → question needs text from PDF documents
    - HYBRID → question needs both

  The same local SLM is used for routing (no separate classifier).
  Routing is done purely through prompt engineering.
"""

import re
import logging
from src.llm import call_llm
from src.utils import load_config

log = logging.getLogger(__name__)

ROUTE_SQL    = "SQL"
ROUTE_VECTOR = "VECTOR"
ROUTE_HYBRID = "HYBRID"

ROUTER_SYSTEM_PROMPT = """You are a query router for a database + document system.
Your job is to classify a user question into exactly one of three routes:

SQL    - The question asks for structured data that lives in a database: counts, totals,
         filtering records, rankings, averages, finding specific entries, listing items.
         ANY question that can be answered by querying a table belongs here.
         Examples: "How many X", "Which X has the highest Y", "List all X where Y",
         "What is the total X", "Find the X with Y", "How old is X", "What is the name of X"

VECTOR - ONLY use this when the question EXPLICITLY asks for explanations, reasons,
         summaries or context from written documents or reports.
         Examples: "According to the report...", "What does the policy say about...",
         "Summarize the document about...", "What is the reason described in..."

HYBRID - ONLY use this when the question EXPLICITLY needs BOTH a database query
         AND a document explanation in the same answer.
         Example: "What were Q3 sales numbers AND why did they change according to the report?"

Rules:
- Reply with ONLY the single word: SQL, VECTOR, or HYBRID
- No explanation, no punctuation, just the one word
- DEFAULT to SQL when in any doubt — most questions are SQL questions
- Only choose VECTOR or HYBRID if the question clearly references documents or reports
"""


def route(question: str, config: dict) -> str:
    """
    Classifies the question into SQL, VECTOR, or HYBRID.

    Returns one of: "SQL", "VECTOR", "HYBRID"
    Falls back to "HYBRID" if the model gives an unclear response.
    """
    log.info(f"Routing question: {question[:80]}...")

    response = call_llm(
        prompt=f"Question: {question}",
        system=ROUTER_SYSTEM_PROMPT,
        model=config["model"],
        base_url=config["ollama_base_url"],
        stream=False,          # routing doesn't need to be streamed
        temperature=0.0,
    )

    response_clean = response.strip().upper()

    # Parse the route label from the response
    if ROUTE_SQL in response_clean and ROUTE_HYBRID not in response_clean:
        route_label = ROUTE_SQL
    elif ROUTE_VECTOR in response_clean and ROUTE_HYBRID not in response_clean:
        route_label = ROUTE_VECTOR
    elif ROUTE_HYBRID in response_clean:
        route_label = ROUTE_HYBRID
    else:
        # Fallback: try keyword heuristics on the question itself
        route_label = _heuristic_route(question)
        log.warning(f"Model gave unclear route '{response}', using heuristic: {route_label}")

    log.info(f"Route: {route_label}")
    return route_label


def _heuristic_route(question: str) -> str:
    """
    Simple keyword-based fallback when the LLM doesn't give a clean label.
    Used only as a safety net.
    """
    q = question.lower()

    vector_keywords = ["why", "explain", "describe", "what is the reason", "summarize",
                       "report", "policy", "strategy", "overview", "context"]
    sql_keywords    = ["how many", "count", "total", "average", "max", "min",
                       "list all", "which", "find all", "show me the", "top", "rank"]

    has_vector = any(kw in q for kw in vector_keywords)
    has_sql    = any(kw in q for kw in sql_keywords)

    if has_vector and has_sql:
        return ROUTE_HYBRID
    elif has_vector:
        return ROUTE_VECTOR
    else:
        return ROUTE_SQL  # default to SQL for benchmark questions