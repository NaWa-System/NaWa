"""
judge.py — LLM-as-judge utilities.
"""

from __future__ import annotations

import json
import subprocess
from typing import Any

from src.prompts import DEFAULT_FAITHFULNESS_SYSTEM_PROMPT


def faithfulness_judge(
	context: str ,
	answer: str,
	model: str = "gpt-4.1",
	timeout: int = 180,
) -> dict[str, Any]:
		"""
		Calls Copilot CLI in JSON mode to score faithfulness.

		Expected output JSON:
		{
			"extracted_claims": ["..."],
			"verification_analysis": ["..."],
			"reasoning": "...",
			"score": 1
		}
		"""
		if not context.strip() or not answer.strip():
			raise ValueError("context and answer must be non-empty strings")
		
		prompt = DEFAULT_FAITHFULNESS_SYSTEM_PROMPT(context, answer)

		cmd = [
			"copilot",
			"--prompt",
			prompt,
			"--model",
			model,
			"--allow-all-tools",
		]
		proc = subprocess.run(cmd, capture_output=True, text=True, check=False, timeout=timeout, encoding="utf-8", errors="replace")
		if proc.returncode != 0:
			stderr = (proc.stderr or "").strip()
			raise RuntimeError(f"Copilot CLI failed with code {proc.returncode}: {stderr}")

		response_text = (proc.stdout or "").strip()
		if not response_text:
			raise ValueError("Copilot CLI returned empty output.")
		try:
			payload = _safe_json_load(response_text)
		except json.JSONDecodeError as exc:
			payload = response_text
			raise ValueError(f"Copilot output is not valid JSON: {exc}") from exc
		print("Raw Copilot Output:", response_text)
		_validate_faithfulness_payload(payload)
		return payload


def _validate_faithfulness_payload(payload: dict[str, Any]) -> None:
	if not isinstance(payload, dict):
		raise ValueError("Copilot response JSON must be an object.")

	claims = payload.get("extracted_claims")
	analysis = payload.get("verification_analysis")
	reasoning = payload.get("reasoning")
	score = payload.get("score")

	if not isinstance(claims, list) or any(not isinstance(c, str) for c in claims):
		raise ValueError("extracted_claims must be a list of strings.")
	if not isinstance(analysis, list) or any(not isinstance(a, str) for a in analysis):
		raise ValueError("verification_analysis must be a list of strings.")
	if not isinstance(reasoning, str):
		raise ValueError("reasoning must be a string.")
	if not isinstance(score, int) or not (1 <= score <= 5):
		raise ValueError("score must be an integer between 1 and 5.")


import json
import re

def _safe_json_load(text: str) -> dict:
    # Extract content between first { and last }
    match = re.search(r'\{.*\}', text, re.DOTALL)
    
    if not match:
        raise ValueError("No JSON object found in text")
    
    json_str = match.group()
    return json.loads(json_str)