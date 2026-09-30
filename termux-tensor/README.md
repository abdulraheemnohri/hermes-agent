# Hermes Agent — Google Tensor / Termux Edition

Termux-only Google Tensor / Pixel profile for running Hermes with local ARM64 inference.

## V1 architecture

Android / Google Tensor → Termux (aarch64) → Hermes Agent → local inference

- LiteRT-LM: direct `.litertlm` inference through `litert_lm_main` when a compatible Android ARM64 binary is available.
- llama.cpp: `.gguf` OpenAI-compatible localhost server fallback.
- CPU baseline: no direct Tensor TPU/NPU access is assumed from a normal Termux process.

## Install

    bash termux-tensor/install.sh
    tensor doctor
    tensor status

## Models

    tensor model import ~/storage/downloads/model.litertlm
    tensor model list
    tensor model info model
    tensor model select model
    tensor model current

Models are separated into `~/.hermes/models/litertlm/` and `~/.hermes/models/gguf/`.

## LiteRT-LM

    command -v litert_lm_main
    export TENSOR_LITERT_BIN=/path/to/litert_lm_main
    tensor lm status
    tensor lm run
    tensor lm benchmark

## llama.cpp server

    tensor model select my-model.gguf
    tensor server start
    tensor server status
    tensor server test
    tensor logs

Endpoint: `http://127.0.0.1:9379/v1`

Configure Hermes:

    tensor hermes configure
    hermes

## Production CLI

    tensor doctor|health
    tensor status
    tensor runtime status
    tensor version
    tensor logs [lines]
    tensor model list|import|select|current|info|remove
    tensor lm run|benchmark|status
    tensor server start|stop|restart|status|test
    tensor thermal status|set <cool|balanced|performance>
    tensor hermes configure|chat|gateway|doctor

`tensor doctor` exits with 0 healthy, 1 warnings, or 2 errors.

## Thermal policy

Default policy is `balanced`, stored in `~/.hermes/tensor/config/tensor.conf`.

    tensor thermal set cool
    tensor thermal set balanced
    tensor thermal set performance

This is a policy setting; it does not claim to directly control the phone's thermal governor.

## Security and resource policy

- Local endpoint binds to `127.0.0.1` by default.
- One active model is the default policy.
- Parallel/background inference is not enabled by this profile.
- Keep long-running Termux gateway execution opt-in.
- Android may suspend or terminate background Termux processes.
- Do not expose port `9379` to a LAN without authentication and access control.

See `termux-tensor/docs/INSTALL.md` for full installation and troubleshooting.