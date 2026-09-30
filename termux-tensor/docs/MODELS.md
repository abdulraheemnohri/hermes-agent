# Termux Tensor Model Manager

## Download

Use `tensor model download <URL> [SHA256]` for `.litertlm` or `.gguf` files. Downloads resume with curl and remain in a `.part` file until the transfer succeeds. If a SHA-256 is supplied, the completed file is verified before activation.

## Discovery

`tensor model scan` searches the managed model directories and Android shared Downloads when available.

## Safety

Only HTTP(S) URLs are accepted. Only `.litertlm` and `.gguf` files are accepted. The downloader never selects a model automatically; compatibility checks remain the gate for selection.
