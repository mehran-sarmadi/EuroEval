#!/usr/bin/env bash
set -uo pipefail

DATASETS=("dutch-cola" "sick-nl" "dutch-central-exam-mcq")
ITERATIONS=1

MODELS=(
  "openrouter/openai/gpt-oss-120b"
  "openrouter/qwen/qwen3-235b-a22b-2507"
  "openrouter/google/gemma-4-26b-a4b-it"
  "openrouter/xiaomi/mimo-v2-flash"
  "openrouter/openai/gpt-5-nano"
  "openrouter/google/gemma-4-31b-it"
)

# Build --dataset flags
DATASET_ARGS=()
for ds in "${DATASETS[@]}"; do
  DATASET_ARGS+=(--dataset "$ds")
done

for model in "${MODELS[@]}"; do
  echo "=========================================="
  echo "Running: $model"
  echo "=========================================="
  uv run euroeval \
    --model "$model" \
    "${DATASET_ARGS[@]}" \
    --num-iterations "$ITERATIONS" \
    --evaluate-test-split \
    --debug \
    --verbose
  echo ""
  echo "Finished: $model"
  echo ""
done

echo "All models complete."
