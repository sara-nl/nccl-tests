#!/bin/bash

#SBATCH -p gpu_h100
#SBATCH --gpus-per-node=1
#SBATCH -t 00:10:00
#SBATCH --reservation=NCCL_test

module load 2024
module load foss/2024a
module load CMake/3.29.3-GCCcore-13.3.0
module load CUDA/12.6.0
module load NCCL/2.22.3-GCCcore-13.3.0-CUDA-12.6.0
module load cuDNN/9.5.0.50-CUDA-12.6.0

rm -rf build/

make MPI=1
