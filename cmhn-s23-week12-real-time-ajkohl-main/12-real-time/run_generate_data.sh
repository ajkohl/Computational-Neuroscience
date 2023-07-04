#!/usr/bin/env bash
#SBATCH --output=fmrisim-%j.out
#SBATCH --job-name fmrisim
#SBATCH -p day 
#SBATCH --reservation=cmhn
#SBATCH -t 30:00
#SBATCH --mem-per-cpu=10G
#SBATCH -n 1

# Set up the environment
module load miniconda
module load OpenMPI
conda activate /gpfs/gibbs/project/cmhn/share/conda_envs/mybrainiak

# Check you are in the correct directory
if [ ${PWD##*/} == '12-real-time' ]
then
    cd ..
    echo "Changing to the tutorials directory"
fi


# Make script executable
chmod 700 ./12-real-time/generate_data.py
python ./12-real-time/generate_data.py
