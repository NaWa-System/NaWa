"""
llm.py — Ollama wrapper for the local SLM.

What this file does:
  - Sends prompts to Ollama (running locally on port 11434)
  - Supports streaming output (text appears token by token in terminal)
  - Same instance handles both routing and generation
  - Returns the full response string when done
"""

import json
import urllib.request
import urllib.error
import logging

log = logging.getLogger(__name__)


def call_llm(
    prompt: str,
    system: str = "",
    model: str = "qwen3.5:9b",
    base_url: str = "http://localhost:11434",
    stream: bool = True,
    temperature: float = 0.0,
) -> str:
    """
    Sends a prompt to Ollama and returns the full response.

    If stream=True, prints tokens as they arrive (you see the model thinking).
    temperature=0.0 makes the model deterministic — important for SQL generation
    so results are reproducible.

    Args:
        prompt:   the user message
        system:   optional system prompt (sets the model's role/behaviour)
        model:    Ollama model name, e.g. "qwen3.5:9b"
        base_url: Ollama API base URL
        stream:   whether to stream tokens to stdout
        temperature: 0.0 = deterministic, higher = more creative

    Returns:
        Full response string from the model.
    """
    url = f"{base_url}/api/chat"

    messages = []
    if system:
        messages.append({"role": "system", "content": system})
    messages.append({"role": "user", "content": prompt})

    payload = json.dumps({
        "model": model,
        "messages": messages,
        "stream": stream,
        "options": {
            "temperature": temperature,
            "num_predict": 1024,
        }
    }).encode("utf-8")
    print(payload)
    req = urllib.request.Request(
        url,
        data=payload,
        headers={"Content-Type": "application/json"},
        method="POST"
    )

    full_response = ""

    try:
        with urllib.request.urlopen(req, timeout=120) as response:
            if stream:
                for line in response:
                    line = line.decode("utf-8").strip()
                    if not line:
                        continue
                    try:
                        chunk = json.loads(line)
                        token = chunk.get("message", {}).get("content", "")
                        print(token, end="", flush=True)
                        full_response += token
                        if chunk.get("done", False):
                            print()  # newline after streaming finishes
                            break
                    except json.JSONDecodeError:
                        continue
            else:
                data = json.loads(response.read().decode("utf-8"))
                full_response = data.get("message", {}).get("content", "")

    except urllib.error.URLError as e:
        log.error(f"Ollama connection failed: {e}")
        log.error("Is Ollama running? Start it with: ollama serve")
        raise ConnectionError(f"Cannot reach Ollama at {base_url}. Run: ollama serve") from e

    return full_response.strip()


def check_ollama(base_url: str = "http://localhost:11434") -> bool:
    """
    Quick health check — returns True if Ollama is running.
    """
    try:
        req = urllib.request.Request(f"{base_url}/api/tags")
        with urllib.request.urlopen(req, timeout=5) as r:
            data = json.loads(r.read().decode("utf-8"))
            models = [m["name"] for m in data.get("models", [])]
            log.info(f"Ollama running. Available models: {models}")
            return True
    except Exception:
        return False


def list_models(base_url: str = "http://localhost:11434") -> list[str]:
    """
    Returns a list of model names currently pulled in Ollama.
    """
    try:
        req = urllib.request.Request(f"{base_url}/api/tags")
        with urllib.request.urlopen(req, timeout=5) as r:
            data = json.loads(r.read().decode("utf-8"))
            return [m["name"] for m in data.get("models", [])]
    except Exception:
        return []