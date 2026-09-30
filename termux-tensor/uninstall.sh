#!/data/data/com.termux/files/usr/bin/bash
set -u
TERMUX_BIN="${PREFIX:-/data/data/com.termux/files/usr}"
LOCAL_BIN="$HOME/.local/bin"
for dir in "$TERMUX_BIN" "$LOCAL_BIN"; do
  for name in tensor tensor-compat tensor-doctor tensor-env tensor-lm tensor-model tensor-model-manager tensor-profile tensor-runtime tensor-server tensor-setup tensor-status tensor-thermal tensor-benchmark hermes-tensor; do
    rm -f "$dir/$name"
  done
done
echo "Tensor command wrappers removed."
echo "Model and state data under ~/.hermes were preserved."
