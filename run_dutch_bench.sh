#!/usr/bin/env bash
# Run EuroEval on selected Dutch datasets × models.
# Usage: bash run_dutch_bench.sh

set -euo pipefail

DATASETS=(
  dutch-cor
  duidelijke-taal
  multiloko-nl
  dutch-proverbs
  gerlangmod-nl
  valeu-nl
  include-nl
  wiki-lingua-nl
  zebra-puzzles-hard-nl
  multi-wiki-qa-nl
)

MODELS=(
  gemini-2.5-flash-lite
  gemma-4-31b
  gemini-2.5-flash-lite-preview
  gpt-5-nano
  qwen-3.5-flash
  mimo-v2-flash
  gpt-oss-120b
  gemma-4-26b
  qwen3-235b
  gpt-4.1-nano
)

# Build --dataset flags
DS_FLAGS=""
for ds in "${DATASETS[@]}"; do
  DS_FLAGS+=" --dataset ${ds}"
done

# Build --model flags
MODEL_FLAGS=""
for m in "${MODELS[@]}"; do
  MODEL_FLAGS+=" --model ${m}"
done

echo "=== Running EuroEval ==="
echo "Datasets: ${DATASETS[*]}"
echo "Models:   ${MODELS[*]}"
echo ""

env -u http_proxy -u https_proxy -u HTTP_PROXY -u HTTPS_PROXY \
  python -m euroeval \
    ${MODEL_FLAGS} \
    ${DS_FLAGS} \
    --evaluate-test-split \
    --few-shot \
    --save-results
