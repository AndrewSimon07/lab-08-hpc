#!/bin/bash
#SBATCH --account=ds2022
#SBATCH --job-name=summarize
#SBATCH --partition=gpu-mig
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=2
#SBATCH --mem=16G
#SBATCH --time=00:05:00
#SBATCH --array=1-101
#SBATCH --output=logs/summarize-%A_%a.out

export HF_HUB_OFFLINE=1

# TODO: load uv
module load uv

# TODO: run summarize.py ...
uv run python src/book_analysis/summarize.py "$1" "$SLURM_ARRAY_TASK_ID"
