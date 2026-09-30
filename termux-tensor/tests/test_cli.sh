#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BIN="$ROOT/bin"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
export HERMES_HOME="$TMP/hermes"
export PATH="$TMP/fakebin:$BIN:$PATH"
mkdir -p "$TMP/fakebin" "$HERMES_HOME/models/litertlm" "$HERMES_HOME/models/gguf" "$HERMES_HOME/tensor/state"
for f in "$BIN"/*; do bash -n "$f"; done
cat >"$TMP/fakebin/litert_lm_main" <<'EOF'
#!/bin/sh
echo "prefill 100 tokens/s"
echo "decode 50 tokens/s"
echo "initialization 2 ms"
echo "time to first token 300 ms"
EOF
chmod +x "$TMP/fakebin/litert_lm_main"
cat >"$TMP/fakebin/hermes" <<'EOF'
#!/bin/sh
exit 0
EOF
chmod +x "$TMP/fakebin/hermes"
MODEL="$HERMES_HOME/models/litertlm/test.litertlm"
printf 'test-model' >"$MODEL"
"$BIN/tensor-setup"
"$BIN/tensor-model" select test.litertlm >/dev/null || true
"$BIN/tensor-benchmark" run "$MODEL" >/dev/null
grep -q $'\t100\t50\t0.002000\t0.300000\t' "$HERMES_HOME/tensor/runtime/benchmarks/history.tsv"
"$BIN/tensor-model" recommend >/dev/null
[ "$(cat "$HERMES_HOME/tensor/state/current-model")" = "$MODEL" ]
"$BIN/tensor-thermal" performance >/dev/null
grep -q '^TENSOR_THERMAL_MODE=performance$' "$HERMES_HOME/tensor/config/tensor.conf"
"$BIN/tensor-runtime" json | python3 -c 'import json,sys; json.load(sys.stdin)'
"$BIN/tensor-doctor" --json | python3 -c 'import json,sys; json.load(sys.stdin)'
printf 'PASS: Termux Tensor CLI tests\n'
