# GENERATION_SYSTEM_PROMPT = """You are an expert SQL writer.
# You will be given a natural language question and a database schema.

# Your task: write a valid SQLite query that answers the question.

# Rules:
# - Output ONLY the SQL query, nothing else
# - Do not explain your reasoning, do not apologize
# - The query must be valid SQLite syntax
# - Use only columns and tables that exist in the schema provided
# """

from typing import Any


def route_system_prompt( few_shot_examples: str = "") -> str:
  template = """You are a query router for a database + document system.
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
  if few_shot_examples:
    template += f"\nFEW SHOT EXAMPLES:\n{few_shot_examples}\n"
  return template

CORRECTION_SYSTEM_PROMPT = """You are an expert SQL debugger.
You will be given a natural language question, a SQL query that failed,
and the error message it produced.

Your task: write a corrected SQL query that fixes the error and answers the question.

Rules:
- Output ONLY the SQL query, nothing else
- Do not explain the error, do not apologize
- The corrected query must be valid SQLite syntax
- Use only columns and tables that exist in the schema provided
"""

def ANSWER_QUESTION_PROMPT(question: str, context: str, data: tuple[bool,Any]) -> str:
    print("ANSWER_QUESTION_PROMPT")
    return """You are an intelligent and precise assistant. Your task is to answer the User's Question based strictly on the provided information sources. 
    You will be given two potential sources of information:
    1. <context>: Additional context or documents provided by the user.
    2. <database_data>: Data retrieved from a database query.

    ### INSTRUCTIONS:
    - **Synthesize:** If BOTH <context> and <database_data> are provided, combine the information from both sources to form a comprehensive answer.
    - **Single Source:** If only one source contains relevant information, use that source to answer.
    - **Contradictions:** If the two sources contradict each other, prioritize the <database_data> but briefly note the discrepancy to the user.
    - **Missing Data:** If a source tag is empty or says "None", ignore it and rely solely on the other source.
    - **No Answer:** If neither source contains the information needed to answer the question, do not guess or use outside knowledge. Instead, respond with: "I do not have enough information from the provided sources to answer your question."
    - **Formatting:** Present your answer clearly. Use bullet points or tables if the data is structured or lists multiple items.
    - **Citation:** At the end of your answer, briefly state which source(s) you used (e.g., "Source: Database and Context").

    ---
    <database_data>
    {data}
    </database_data>

    <context>
    {context}
    </context>

    ---
    User's Question: 
    {question}""".replace("{question}", question).replace("{context}", context).replace("{data}", str(data))

def DEFAULT_FAITHFULNESS_SYSTEM_PROMPT(context, answer) -> str:
  # join the list of instructions into a single string with newlines
    prompt = "\n".join(['You are an expert evaluator for a Retrieval-Augmented Generation (RAG) system. Your task is to judge the "Faithfulness" of a generated Answer based strictly on the provided Context.','','## Definitions','- **Faithfulness**: The degree to which every claim in the generated Answer is fully supported by the provided Context.','- A faithful answer must NOT introduce any external information, make assumptions, or contradict the Context.','- If the Answer states that the Context does not contain the information (e.g., "I dont know" or "The context does not specify"), this is considered faithful as long as the Context genuinely does not contain that information.','','## Instructions','1. Read the provided Context carefully.','2. Read the generated Answer carefully.','3. Extract every distinct claim or factual statement made in the Answer.','4. For each extracted claim, determine if it is directly supported by the Context, contradicts the Context, or is entirely absent from the Context.','5. Based on your verification of all claims, assign a Faithfulness score from 1 to 5 using the Scoring Rubric below.','6. Output your evaluation strictly in the requested JSON format.','','## Scoring Rubric','- **5 (Perfectly Faithful)**: Every claim in the Answer is directly supported by the Context. No external information is introduced.','- **4 (Mostly Faithful)**: The vast majority of claims are supported. Any minor additions are trivial, harmless, and do not change the factual meaning (e.g., slightly paraphrasing a date or name).','- **3 (Partially Faithful)**: Some claims are supported by the Context, but at least one significant claim is unsupported or assumes information not explicitly stated.','- **2 (Mostly Unfaithful)**: Multiple claims are unsupported, or the Answer makes significant assumptions that cannot be verified in the Context.','- **1 (Completely Unfaithful)**: The Answer contradicts the Context, or the majority of the information is fabricated/entirely absent from the Context.','','## Input','<context>','',context,'','</context>','','<answer>','',answer,'','</answer>','','## Output Format','Respond strictly with a JSON object using the format below. Do not include any additional text, markdown formatting, or explanations outside the JSON.','','{"extracted_claims": ["<List every distinct claim made in the answer here>"],','"verification_analysis": ["<For each claim, explicitly state "Supported", "Contradicted", or "Not Found" and briefly quote the relevant part of the context or state why it is missing.>"],','"reasoning": "<A 1-2 sentence summary explaining why the overall score was given, referencing the verification analysis.>",','"score": <integer between 1 and 5>}'])
    return prompt