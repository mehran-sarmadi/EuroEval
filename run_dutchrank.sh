#!/usr/bin/env bash
set -uo pipefail

DATASETS="dutch-cola sick-nl dutch-central-exam-mcq"
ITERATIONS=1

MODELS=(
  "openrouter/openai/gpt-4.1-nano"
  "openrouter/google/gemini-2.5-flash-lite"
  "openrouter/qwen/qwen3.5-flash-02-23"
  "openrouter/google/gemini-2.5-flash-lite-preview-09-2025"
)

for model in "${MODELS[@]}"; do
  echo "=========================================="
  echo "Running: $model"
  echo "=========================================="
  uv run euroeval \
    --model "$model" \
    --dataset $DATASETS \
    --num-iterations "$ITERATIONS" \
    --evaluate-test-split \
    --verbose
  echo ""
  echo "Finished: $model"
  echo ""
done

echo "All models complete."
