#!/bin/bash 
#
# Takes in a results directory from fcma analysis and a certain number of voxels to threshold for a mask as input

#You will need to load fsl module/conda for your cluster
module load FSL/6.0.5-centos7_64

# Source the FSL config script 
. ${FSLDIR}/etc/fslconf/fsl.sh

# Take inputs
input_dir=$1  # What is the path to the data?
voxel_number=$2  # What voxel threshold are you setting?
output_dir=$3  # Where do you want to put the data?

# Create output_dir
if [ ! -d ${output_dir} ]; then
  mkdir ${output_dir}
fi

# Iterate through each volume in the fcma directory
for file in ${input_dir}/*_seq.nii.gz
do	
	# Preprocess the file name
	fbase=$(basename "$file")
	pref="${fbase%%.*}"
	
	# Create the voxel mask
	fslmaths $file -uthr $voxel_number -bin ${output_dir}/${pref}_top${voxel_number}.nii.gz

done

# Concatenate all of the masks from each volume
fslmerge -t ${output_dir}/all_top${voxel_number} ${output_dir}/fc_no*top${voxel_number}.nii.gz

# Create a probability map of each voxel being included across participants
fslmaths ${output_dir}/all_top${voxel_number} -Tmean ${output_dir}/prop_top${voxel_number} -odt float
