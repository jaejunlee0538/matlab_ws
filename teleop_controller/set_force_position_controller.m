% force position controller
% note : if K_sfs exceed 1.0, slave force/position response will diverge.
%
controller_type.name = 'f-p type';
K_mpm       = -200.0;
K_mpm_d     = 0.0;
K_mpm_dd    = 0.0;
K_mfm       = 0.0; 
K_mps       = -200.0;
K_mps_d     = 0.0;
K_mps_dd    = 0.0;
K_mfs       = 0.0; 

K_spm       = 0.0;
K_spm_d     = 0.0;
K_spm_dd    = 0.0;
K_sfm       = 1.0; 
K_sps       = 0.0;
K_sps_d     = 0.0;
K_sps_dd    = 0.0;
K_sfs       = 0.0; 