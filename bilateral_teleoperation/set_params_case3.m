
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

%% controller
k1 = 8.0;
k2 = 70.0;
m_hat = 2.0;
b_hat = 1.0;
c_hat = 0.0;
lamda = 0.21;
k_mf = 0.0;
k_sf = 0.0;

func = @(x,y) (0.5 * (x+y));
master_controller = @(x_m, xd_m, xdd_m, f_m, x_s, xd_s, xdd_s, f_s)...
    (...
    m_m * (func(xdd_m, xdd_s) + k1*(func(xd_m, xd_s) - xd_m) + k2*(func(x_m, x_s) - x_m))...
    + b_m*xd_m - 0.5*(1+k_mf)*(m_hat*func(xdd_m, xdd_s) + b_hat*func(xd_m, xd_s) + c_hat*func(x_m, x_s))...
    + 0.5*lamda*m_m*func(f_m, f_s) -k_mf*(func(f_m, f_s)-f_m) - func(f_m, f_s)...
    );
slave_controller = @(x_m, xd_m, xdd_m, f_m, x_s, xd_s, xdd_s, f_s)...
    (...
    m_s * (func(xdd_m, xdd_s) + k1*(func(xd_m, xd_s) - xd_s) + k2*(func(x_m, x_s) - x_s))...
    + b_s * xd_s - 0.5*(1+k_sf)*(m_hat*func(xdd_m, xdd_s) + b_hat*func(xd_m, xd_s) + c_hat*func(x_m, x_s))...
    - 0.5*lamda*m_s*func(f_m, f_s) + k_sf*(func(f_m, f_s)-f_s) + func(f_m, f_s)...
    );