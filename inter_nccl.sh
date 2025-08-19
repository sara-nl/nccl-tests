#!/bin/bash
#SBATCH --job-name="NCCL_tests"
#SBATCH --nodes=2
#SBATCH --output=res_nccl_inter.out
#SBATCH --error=rfm_nccl_inter.err
#SBATCH --time=0:2:0
#SBATCH --exclusive
#SBATCH -p gpu_h100
#SBATCH --reservation=NCCL_test
#SBATCH --gpus-per-node=4

module load 2024
module load foss/2024a
module load CMake/3.29.3-GCCcore-13.3.0
module load CUDA/12.6.0
module load NCCL/2.22.3-GCCcore-13.3.0-CUDA-12.6.0
module load cuDNN/9.5.0.50-CUDA-12.6.0

export NCCL_SOCKET_IFNAME="eno"
#export NCCL_SOCKET_IFNAME="ib0"
export NCCL_DEBUG=INFO
export NCCL_DEBUG_FILE=nccl_log_inter_%h.txt
export NCCL_TOPO_DUMP_FILE=nccl_topo_inter.xml
export NCCL_DEBUG_SUBSYS=ALL

#export NCCL_IGNORE_CPU_AFFINITY=1
#export NCCL_DEBUG=INFO

#srun --ntasks=2 --ntasks-per-node=1 nvidia-smi


#srun --nodes=2 --ntasks-per-node=1 nccl-tests/build/all_gather_perf --ngpus 1 --datatype float -b 8 -e 8G -f 2
srun --nodes=2 --ntasks-per-node=4 --cpus-per-task=1 build/all_reduce_perf -b 8 -e 8G -f 2 -g 1
