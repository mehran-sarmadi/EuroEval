#!/usr/bin/env bash
set -uo pipefail

DATASETS="dutch-cola sick-nl dutch-central-exam-mcq"
ITERATIONS=1

MODELS=(
  "openrouter/openai/gpt-5"
  "openrouter/google/gemini-2.0-flash-lite-001"
  "openrouter/meta-llama/llama-4-scout"
  "openrouter/meta-llama/llama-3.1-8b-instruct"
  # Add more models below:
  # "openrouter/provider/model-name"
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
