% position_position_controller
% Gain setting for Position-Position Controller 
% Every gains related with force signals have to be zero.
controller_type.name = 'p-p type';
K_mpm       = -400.0;
K_mpm_d     = 0.0;
K_mpm_dd    = 0.0;
K_mfm       = 0.0; % must be zero
K_mps       = -400.0;
K_mps_d     = 0.0;
K_mps_dd    = 0.0;
K_mfs       = 0.0; % must be zero

K_spm       = 400.0;
K_spm_d     = 0.0;
K_spm_dd    = 0.0;
K_sfm       = 0.0; % must be zero
K_sps       = 400.0;
K_sps_d     = 0.0;
K_sps_dd    = 0.0;
K_sfs       = 0.0; % must be zero