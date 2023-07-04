# README for custom project

Depending upon the dataset you choose to use, you will need to follow all or some of the steps included here.  
## 1. Create your own conda environment on Grace. 
- Included in this repository is a file `environment.yml` that will allow you to create an exact copy of our current conda environment. From the command line, navigate to this directory. 
- If you are using the Grace shell, you will need to start an interactive session by running the command `srun --ntasks-per-node=2 -t 2:00:00 --pty bash`. Skip this step if you are using the Jupyterlab terminal. 
- Load in the module for miniconda: `module load miniconda` 
- Create the conda environment: `conda env create -f environment.yml`
    - This will not be immediate; it will take time to install all the packages. Be patient.
- Once your environment finishes installing, you can activate your environment with `conda activate myenv`. You MUST make sure your environment is activated when you do anything from the command line.
- Make your environment compatible with Jupyter by running the following commands: `module unload miniconda`; `ycrc_conda_env.sh build`
- Now, when you start a notebook from the open on demand portal, go to the dropdown menu for environment setup and select `myenv`. 

## 2. Create your own conda environment on Milgram.
- First, follow the instructions from the first week of class to set up your github account on Milgram and pull this repository somewhere on Milgram.
- Included in this repository is a file `environment_milgram.yml` that will allow you to create an exact copy of our current conda environment. From the command line, navigate to this directory. 
- If you are using the Milgram shell, you will need to start an interactive session by running the command `srun --ntasks-per-node=2 -t 2:00:00 --pty bash`. Skip this step if you are using the Jupyterlab terminal. 
- Load in the module for miniconda: `module load miniconda` 
- Create the conda environment: `conda env create -f environment_milgram.yml`
    - This will not be immediate; it will take time to install all the packages. Be patient.
- Activate your conda environment with `conda activate myenv`. 
- Install brainiak separately: `conda install -c brainiak -c defaults -c conda-forge brainiak`
- Make your environment compatible with Jupyter by running the following commands: `module unload miniconda`; `ycrc_conda_env.sh build`
- Now, when you start a notebook from the open on demand portal, go to the dropdown menu for environment setup and select `myenv`. 

**Any time you go to do something from the command line now, you MUST run `module load miniconda; conda activate myenv`**

## 3. Using DataLad to install data from OpenNeuro.
- If you are installing a dataset from OpenNeuro, you are going to use the Datalad package to do so. Install Datalad to your conda environment with: `pip install --user datalad`. 
- Review the documentation on Datalad: https://handbook.datalad.org/en/latest/
- When you have **thoroughly** read up on Datalad and your dataset and have decided to install it, go to your scratch directory from the command line and continue.  
- Follow the instructions on your dataset's homepage for installation with datalad:
    - for example, if you are installing https://openneuro.org/datasets/ds004488/, click on the "download" tab and run `datalad install https://github.com/OpenNeuroDatasets/ds004488.git`
    - This installs simlinks for all the files in the dataset. Next, you need to figure out which files you need (so you're only downloading files relevant to your analyses).
    
## 4. Determining what state your dataset is in.
Every dataset on OpenNeuro is a little different (or NDA, etc). Ideally they will be in [BIDS format](https://bids.neuroimaging.io/), which we learned about in week 2. If they are not in BIDS format, it will be harder to ascertain how the data are preprocessed and then perform whatever additional preprocessing you need to. You must identify what format your data are in. We want to use data that has been preprocessed, ideally with [fMRIprep](https://fmriprep.org/en/stable/) and aligned to a common anatomical template (MNI space). 

A few examples: 
- Consider this dataset: https://openneuro.org/datasets/ds003720/versions/1.0.0
    - These data are in BIDS format but have not been preprocessed (or the preprocessed data have not been released). You can tell this because, at the same directory level as the 'sub-XX' folders, there is no folder called 'derivatives' 
- Consider this dataset: https://openneuro.org/datasets/ds000121/versions/00001
    - These data are in BIDS format but we do not have the necessary fmriprep output files. You can tell this because there is a 'derivatives' folder, but inside we only have a directory called 'mriqc' with a bunch of PDF files. 
- Consider this dataset: https://openneuro.org/datasets/ds004488/versions/1.0.0
    - These data are in BIDS format and have had fmriprep already run because there's a folder caller `derivatives/fmriprep` and each subject nested within. 
    
You can sometimes find more information in the dataset's README.

## 5. Download data from datalad.
- Running datalad install only installs simlinks ; you will need to actually run `datalad get` to get the full files contents in this directory. 
- Depending upon how many subjects' data your dataset has, you may or may not want to install all of them. If you do, you will want to run `datalad get sub*` to install all the subjects' data. Otherwise, you can specify only certain subjects with `datalad get sub-XX` or whatever the directory name is. If your dataset already has derivatives, you should get those files with `datalad get derivatives/*`. 
- This must be run from inside your datalad repository. 
- In order to run fmriprep, you need to have both anatomical images and functional images (so the contents of both `anat` and `func` directories, in BIDS format).
- Getting datasets takes more time than installing them, so beware! After you run `datalad get` you can try opening the NiftiImage files in a jupyter notebook, as we've been doing all semester, to make sure they were installed properly.