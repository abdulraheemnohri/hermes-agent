# Hermes Agent — Google Tensor / Termux Edition

Termux-only Google Tensor / Pixel profile for local ARM64 inference.

## V1 architecture
Android / Google Tensor → Termux (aarch64) → Hermes Agent → local inference.
- LiteRT-LM: `.litertlm` through `litert_lm_main` when a compatible ARM64 binary is available.
- llama.cpp: `.gguf` localhost server fallback.
- CPU is the Termux baseline; Tensor TPU/NPU access is not assumed.

## Install
    bash termux-tensor/install.sh
    tensor doctor
    tensor status

## Model management
    tensor model import ~/storage/downloads/model.litertlm
    tensor model list
    tensor model check model
    tensor model select model
    tensor model recommend
    tensor model current

The compatibility engine checks format, ARM64, required runtime, free RAM, free storage and a conservative resource heuristic. Model file size is not treated as exact runtime RAM usage.

## Runtime
    tensor runtime status
    tensor lm status
    tensor lm run
    tensor lm benchmark
    tensor server start
    tensor server test

Endpoint: http://127.0.0.1:9379/v1

## Safety policy
- One active model by default.
- LAN exposure disabled.
- Background inference disabled by default.
- Automatic selection only chooses a model that passes all blocking compatibility checks.
- Warning-level models may be selected manually; blocked models cannot be selected.
- Android may suspend or terminate background Termux processes.

See termux-tensor/docs/INSTALL.md and termux-tensor/docs/SETTINGS.md.
