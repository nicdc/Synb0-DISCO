#!/bin/bash

TOPUP=1

for arg in "$@"
do
    case $arg in
        -i|--notopup)
        TOPUP=0
    esac
done


# Set path for executable
#export PATH=$PATH:/extra

# Set up freesurfer
#export FREESURFER_HOME=/extra/freesurfer
#source $FREESURFER_HOME/SetUpFreeSurfer.sh

# Set up FSL
#. /extra/fsl/etc/fslconf/fsl.sh
#export PATH=$PATH:/extra/fsl/bin
#export FSLDIR=/extra/fsl

# Set up ANTS
#export ANTSPATH=/extra/ANTS/bin/ants/bin/
#export PATH=$PATH:$ANTSPATH:/extra/ANTS/ANTs/Scripts

# Set up pytorch
#source /extra/pytorch/bin/activate

# Prepare input
prepare_input.sh ${PWD}/INPUTS/b0.nii.gz ${PWD}/INPUTS/T1.nii.gz ${PWD}/INPUTS/T1_mask.nii.gz ${SYNB0_DIR}/atlases/mni_icbm152_t1_tal_nlin_asym_09c.nii.gz ${SYNB0_DIR}/atlases/mni_icbm152_t1_tal_nlin_asym_09c_2_5.nii.gz ${PWD}/OUTPUTS

# Run inference
#NUM_FOLDS=5
#for i in $(seq 1 $NUM_FOLDS);
#  do echo Performing inference on FOLD: "$i"
#  python3 /home/nick/Synb0-DISCO/src/inference.py ${PWD}/OUTPUTS/T1_norm_lin_atlas_2_5.nii.gz ${PWD}/OUTPUTS/b0_d_lin_atlas_2_5.nii.gz ${PWD}/OUTPUTS/b0_u_lin_atlas_2_5_FOLD_"$i".nii.gz ${SYNB0_DIR}/src/train_lin/num_fold_"$i"_total_folds_"$NUM_FOLDS"_seed_1_num_epochs_100_lr_0.0001_betas_\(0.9\,\ 0.999\)_weight_decay_1e-05_num_epoch_*.pth
#done

# Take mean
#echo Taking ensemble average
#fslmerge -t ${PWD}/OUTPUTS/b0_u_lin_atlas_2_5_merged.nii.gz ${PWD}/OUTPUTS/b0_u_lin_atlas_2_5_FOLD_*.nii.gz
#fslmaths ${PWD}/OUTPUTS/b0_u_lin_atlas_2_5_merged.nii.gz -Tmean ${PWD}/OUTPUTS/b0_u_lin_atlas_2_5.nii.gz

# Apply inverse xform to undistorted b0
#echo Applying inverse xform to undistorted b0
#antsApplyTransforms -d 3 -i ${PWD}/OUTPUTS/b0_u_lin_atlas_2_5.nii.gz -r ${PWD}/INPUTS/b0.nii.gz -n BSpline -t [${PWD}/OUTPUTS/epi_reg_d_ANTS.txt,1] -t [${PWD}/OUTPUTS/ANTS0GenericAffine.mat,1] -o ${PWD}/OUTPUTS/b0_u.nii.gz

# Smooth image
#echo Applying slight smoothing to distorted b0
#fslmaths ${PWD}/INPUTS/b0.nii.gz -s 1.15 ${PWD}/OUTPUTS/b0_d_smooth.nii.gz

#if [[ $TOPUP -eq 1 ]]; then
#    Merge results and run through topup
#    echo Running topup
#    fslmerge -t ${PWD}/OUTPUTS/b0_all.nii.gz ${PWD}/OUTPUTS/b0_d_smooth.nii.gz ${PWD}/OUTPUTS/b0_u.nii.gz
#    topup -v --imain=${PWD}/OUTPUTS/b0_all.nii.gz --datain=${PWD}/INPUTS/acqparams.txt --config=b02b0.cnf --iout=${PWD}/OUTPUTS/b0_all_topup.nii.gz --out=${PWD}/OUTPUTS/topup --subsamp=1,1,1,1,1,1,1,1,1 --miter=10,10,10,10,10,20,20,30,30 --lambda=0.00033,0.000067,0.0000067,0.000001,0.00000033,0.000000033,0.0000000033,0.000000000033,0.00000000000067 --scale=0
#fi


# Done
echo FINISHED!!!
