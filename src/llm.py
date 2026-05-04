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
from dataclasses import dataclass, field


log = logging.getLogger(__name__)

@dataclass
class LLMResponse:
    """
    Holds the full output from a call_llm() invocation.

    Attributes:
        content:  The final answer from the model (what you act on).
        thinking: The internal reasoning trace (visible when think=True,
                  empty string otherwise). Useful for debugging but should
                  NOT be parsed or relied on programmatically.
    """
    content: str = ""
    thinking: str = ""

    def __str__(self) -> str:
        """Lets legacy callers that do str(response) still get the answer."""
        return self.content

def call_llm(
    prompt: str,
    system: str = "",
    model: str = "qwen3.5:9b",
    base_url: str = "http://localhost:11434",
    stream: bool = True,
    temperature: float = 0.0,
    think: bool = False,
) -> str:
        """
        Sends a prompt to Ollama and returns an LLMResponse with both the
        final answer and (optionally) the internal reasoning trace.

        When think=True, Ollama sends chunks with either message.thinking
        (reasoning tokens) or message.content (answer tokens) — never both
        in the same chunk. We accumulate them separately and print them to
        stdout with clear section headers so you can watch both live.

        Args:
            prompt:      the user message
            system:      optional system prompt (sets the model's role/behaviour)
            model:       Ollama model name, e.g. "qwen3:5b"
            base_url:    Ollama API base URL
            stream:      whether to stream tokens to stdout
            temperature: 0.0 = deterministic, higher = more creative
            think:       True  → model reasons before answering (slower, better)
                        False → skip reasoning trace (faster, use for simple tasks)

        Returns:
            LLMResponse with .content (the answer) and .thinking (the trace).
            str(response) returns .content so existing callers keep working.
        """
        url = f"{base_url}/api/chat"

        messages = []
        if system:
            messages.append({"role": "system", "content": system})
        messages.append({"role": "user", "content": prompt})
        # print(f"Calling model '{model}' with prompt:\n{prompt}\n")

        payload = json.dumps({
            "model": model,
            "messages": messages,
            "stream": stream,
            "think": think,          # top-level field, NOT inside options.
                                    # Controls whether the model emits a reasoning
                                    # trace. Ollama routes thinking tokens to
                                    # message.thinking and answer tokens to
                                    # message.content — they never mix.
            "options": {
                "temperature": temperature,
                # "num_predict": 1024,
                "top_p": 0.95,
                "top_k": 10,
                "repeat_penalty": 1.25,
                "presence_penalty": 1.5
            },
        }).encode("utf-8")

        req = urllib.request.Request(
            url,
            data=payload,
            headers={"Content-Type": "application/json"},
            method="POST",
        )

        result = LLMResponse()
        in_thinking = False  # tracks whether we've printed the "Thinking:" header

        try:
            with urllib.request.urlopen(req, timeout=120) as response:
                if stream:
                    for line in response:
                        line = line.decode("utf-8").strip()
                        if not line:
                            continue
                        try:
                            chunk = json.loads(line)
                            msg = chunk.get("message", {})

                            thinking_token = msg.get("thinking", "")
                            content_token  = msg.get("content", "")

                            # --- thinking phase ---
                            if thinking_token:
                                if not in_thinking:
                                    in_thinking = True
                                    print("Thinking:\n========\n", flush=True)
                                print(thinking_token, end="", flush=True)
                                result.thinking += thinking_token

                            # --- answer phase ---
                            if content_token:
                                if in_thinking:
                                    # First content token after thinking: print header
                                    in_thinking = False
                                    # print("\n\nAnswer:\n=======\n", flush=True)
                                print(content_token, end="", flush=True)
                                result.content += content_token

                            if chunk.get("done", False):
                                print()  # final newline
                                break

                        except json.JSONDecodeError:
                            print(f"\n[Warning] Received non-JSON line: {line}\n")
                            continue

                else:
                    # Non-streaming: Ollama returns a single JSON object.
                    # thinking and content are separate fields on message.
                    data = json.loads(response.read().decode("utf-8"))
                    msg = data.get("message", {})
                    result.thinking = msg.get("thinking", "")
                    result.content  = msg.get("content", "")

                    if think and result.thinking:
                        print(f"Thinking:\n========\n\n{result.thinking}\n")
                    # print(f"Answer:\n=======\n\n{result.content}\n")

        except urllib.error.URLError as e:
            log.error(f"Ollama connection failed: {e}")
            log.error("Is Ollama running? Start it with: ollama serve")
            raise ConnectionError(
                f"Cannot reach Ollama at {base_url}. Run: ollama serve"
            ) from e

        result.content  = result.content.strip()
        result.thinking = result.thinking.strip()
        return result.content


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
    
def call_copilot(prompt: str, model: str = "gpt-4.1", params: list[str] | None = None) -> str:
    import subprocess
    """
    Calls Copilot CLI with the given prompt and returns the response.

    Args:
        prompt: The user message to send to the model.
        model: The Copilot model to use (default: "gpt-4.1").
        params: Optional list of additional parameters for the Copilot CLI.

    Returns:
        The response from the model as a string.
    """
    cmd = [
        "copilot",
        "--prompt",
        prompt,
        "--model",
        model,
        "--allow-all-tools",
    ]
    if params:
        cmd.extend(params)
    proc = subprocess.run(cmd, capture_output=True, text=True, check=False, timeout=180)
    if proc.returncode != 0:
        stderr = (proc.stderr or "").strip()
        raise RuntimeError(f"Copilot CLI failed with code {proc.returncode}: {stderr}")

    return (proc.stdout or "").strip()
    