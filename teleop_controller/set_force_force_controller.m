% force force controller
% K_mfm, K_mfs,K_sfs can be increased gradually(+0.25 per step).
% For example, if K_mfm is increased +0.25, K_mfs or K_sfs can be increased also slightly.
% But K_sfm cannot be increased.
controller_type.name = 'f-f type';
K_mpm       = 0.0;
K_mpm_d     = 0.0;
K_mpm_dd    = 0.0;
K_mfm       = 0; 
K_mps       = 0.0;
K_mps_d     = 0.0;
K_mps_dd    = 0.0;
K_mfs       = 1; 

K_spm       = 0.0;
K_spm_d     = 0.0;
K_spm_dd    = 0.0;
K_sfm       = 1; 
K_sps       = 0.0;
K_sps_d     = 0.0;
K_sps_dd    = 0.0;
K_sfs       = 0; 