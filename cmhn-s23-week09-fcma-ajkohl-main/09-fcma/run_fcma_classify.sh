#!/bin/bash
#SBATCH -t 60
#SBATCH -n 2
#SBATCH --mem-per-cpu=2G
#SBATCH --job-name fcma_classify
#SBATCH --output log/%j-fcma_classify.out


# Set up the environment
module load miniconda
module load OpenMPI
conda activate /gpfs/gibbs/project/cmhn/share/conda_envs/mybrainiak

chmod 700 ./fcma_classify.py


# Prepare inputs to voxel selection function
data_dir=$1  # What is the directory containing data?
suffix=$2  # What is the extension of the data you're loading 
mask_file=$3  #What is the path to the top N mask file (THIS IS NOT THE WHOLE BRAIN MASK)
epoch_file=$4  # What is the path to the epoch file
left_out_subj=$5  #Which participant (as an integer) are you using for testing? 
second_mask=$6  # Do you want to use a second mask to compare the data with? Necessary for extrinsic analyses. Otherwise ignore this input or set to None

# Run the python script (use mpi if running on the cluster)

srun --mpi=pmi2 ./fcma_classify.py $data_dir $suffix $mask_file $epoch_file $left_out_subj $second_mask

