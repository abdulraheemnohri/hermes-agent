# Termux Tensor Settings

## Core defaults
TENSOR_HOST=127.0.0.1
TENSOR_PORT=9379
TENSOR_THERMAL_MODE=balanced
TENSOR_LOG_LEVEL=INFO
ACTIVE_MODELS=1
LAN_EXPOSURE=false
BACKGROUND_INFERENCE=false

## Model compatibility
TENSOR_MIN_FREE_RAM_MB=1024
TENSOR_MODEL_RAM_FACTOR=1.5
TENSOR_MODEL_STORAGE_FACTOR=1.2

The RAM factor is a conservative heuristic, not an exact runtime-memory model. Actual memory depends on runtime, context, tokenizer, KV cache and backend.

## Runtime
LiteRT-LM direct mode uses the available native ARM64 CLI. llama.cpp server mode provides the persistent HTTP path.

## Network
Bind local inference to 127.0.0.1. LAN access is disabled by design.

## Benchmark
TENSOR_BENCHMARK_PREFILL_TOKENS=1024
TENSOR_BENCHMARK_DECODE_TOKENS=256

## Runtime profile
Use `tensor profile save <benchmark-id>` after a validated benchmark. `tensor profile recommend` reports a conservative thermal/context suggestion; it does not claim direct control of Android thermal governors.

## Benchmark history
Benchmark records are stored locally at `~/.hermes/tensor/runtime/benchmarks/history.tsv`. The history contains timestamp, device profile ID, model path, model size, thermal reading, available RAM and the recorded benchmark result summary.

Use `tensor benchmark status`, `tensor benchmark compare`, and `tensor benchmark regression` to inspect history. No cloud telemetry is used.
