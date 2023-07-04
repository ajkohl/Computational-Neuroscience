#!/bin/bash
#SBATCH -t 2:00:00
#SBATCH --ntasks=2
#SBATCH --mem-per-cpu=5G
#SBATCH --job-name fcma_voxel_select_cv
#SBATCH --output log/%j-fcma_voxel_select_cv.out


# Set up the environment
module load miniconda
module load OpenMPI
conda activate /gpfs/gibbs/project/cmhn/share/conda_envs/mybrainiak

if [ ! -d ./log ]; then
  mkdir ./log
fi

chmod 700 ./fcma_voxel_selection_cv.py

# How many threads can you make
export OMP_NUM_THREADS=32

# Prepare inputs to voxel selection function
data_dir=$1  # What is the directory containing data?
suffix=$2  # What is the extension of the data you're loading?
mask_file=$3  # What is the path to the whole brain mask?
epoch_file=$4  # What is the path to the epoch file?
left_out_subj=$5  # Which participant (as an integer) are you leaving out for this cv?
output_dir=$6 # Where do you want to save the data?

# Run the script
srun --mpi=pmi2 ./fcma_voxel_selection_cv.py $data_dir $suffix $mask_file $epoch_file $left_out_subj $output_dir
