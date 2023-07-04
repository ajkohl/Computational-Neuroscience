import numpy as np 
import os
import scipy.io
import nibabel as nib
from nilearn.maskers import NiftiMasker
from nilearn.masking import compute_epi_mask
from sklearn import preprocessing
from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import PredefinedSplit
from copy import deepcopy
from brainiak import image, io

def processregressor(regressor, TR_array, df):
    """Get data from regressor into array, match with TRs

    Params:
    regressor (str): the regressor you want to match
    TR_array (list): list of the TRs
    df (data_frame): contains the data for regressors
    ---
    Returns:
    TR_matched regressor array
    """
    
    array = df[f'{regressor}'].values # get values from pandas dataframe
    reg_vals = np.column_stack((TR_array, array)) # combine TRs with regressor values
    return reg_vals


def remove_duplicate_rows(regressor_array):
    """removes any duplicate rows
    
    Params
    regressor array
    
    Returns
    regressor array (without duplicate rows)
    """
    i = 0
    while i < regressor_array.shape[0]:
        
        try:
            if regressor_array[i][0] == regressor_array[i + 1][0]: # if current TR == next TR
                regressor_array = np.delete(regressor_array, i + 1, axis=0) # remove the next row if it is a duplicate
                i -= 1
            i += 1
        except:
            if i == regressor_array.shape[0] - 1:
                break
    return regressor_array

def upsample_labels(regressor_array, totalTRs):
    """ upsample TRs
    Params:
    regressor_array
    totalTRs
    
    Returns:
    regressor_array (upsampled)
    """
    idx = 0
    while idx < totalTRs:
        try:
            # Obtain value for the current TR
            present_TR = regressor_array[idx][0]
            # Inspect the subsequent row: if it isn't the previous TR + 1, set the next TR as the previous TR value
            if regressor_array[idx + 1][0] != present_TR + 1:
                regressor_array = np.insert(regressor_array, idx + 1, np.array([idx + 1, regressor_array[idx][1]]), axis=0)
            else:
                # Include a row if required
                pass
        except Exception as error:  # Stop the loop if at the final TR
            if idx == totalTRs - 1:
                break
        idx += 1
    return regressor_array


def mask_preprocess_data(data, mask_name, mask, num_subs):
    """Mask and preprocess data for all subjects.

    Params:
    data: 4D fMRI data
    mask_name (str): name of mask
    mask: boolean mask
    num_subs: number of subjects

    Returns:
    mdataPath: path to all subjects' BOLD data for a mask
    """
    all_subject_data = []
    for subject in range(num_subs):
        masked_data = image.mask_image(data[subject], mask)
        scaler = preprocessing.StandardScaler().fit(masked_data)
        preprocessed_data = scaler.transform(masked_data)
        all_subject_data.append(preprocessed_data)

    mdataPath = os.path.join('/home', 'cmhn_ak2776', 'palmer_scratch', 'final_project', f'{mask_name}_data.npy')
    np.save(mdataPath, all_subject_data)
    print(f'Saved {mask_name} data for all subjects')
    return mdataPath