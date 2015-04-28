% operator
m_op        = 2.0;
b_op        = 2.0;
c_op        = 10.0;
% master
m_m         = 6.0;
b_m         = 0.1;
% slave
m_s         = 6.0;
b_s         = 0.1;
% object(object2 in paper)
m_w         = 3.0;
b_w         = 1.0;
c_w         = 50.0;
% gains(Force-Reflecting Servo Type)
K_mpm       = 0.0;
K_mpm_d     = 0.0;
K_mpm_dd    = 0.0;
K_mfm       = 2.5;
K_mps       = 0.0;
K_mps_d     = 0.0;
K_mps_dd    = 0.0;
K_mfs       = 3.5;

K_spm       = 400;
K_spm_d     = 0.0;
K_spm_dd    = 0.0;
K_sfm       = 0.0;
K_sps       = 400;
K_sps_d     = 50;
K_sps_dd    = 0.0;
K_sfs       = 0.0;

master_controller = @(x_m, xd_m, xdd_m, f_m, x_s, xd_s, xdd_s, f_s) ((K_mpm * x_m + K_mpm_d * xd_m + K_mpm_dd * xdd_m + K_mfm * f_m) - ...
        (K_mps * x_s + K_mps_d * xd_s + K_mps_dd * xdd_s + K_mfs * f_s));
slave_controller = @(x_m, xd_m, xdd_m, f_m, x_s, xd_s, xdd_s, f_s) ((K_spm * x_m + K_spm_d * xd_m + K_spm_dd * xdd_m + K_sfm * f_m) - ...
        (K_sps * x_s + K_sps_d * xd_s + K_sps_dd * xdd_s + K_sfs * f_s));