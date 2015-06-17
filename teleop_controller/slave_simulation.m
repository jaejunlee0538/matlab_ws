function [ x_s_, xd_s_, xdd_s_, f_s_ ] = slave_simulation( x_m, xd_m, xdd_m, f_m, dt, slave_controller)
persistent first_run
persistent x_s
persistent xd_s
persistent xdd_s
persistent f_s

%% initialize master simulator
if isempty(first_run)
    first_run = false;

    x_s = 0;
    xd_s = 0;
    xdd_s = 0;
    f_s = 0;
end

%% slave and object parameters
% slave
m_s         = 6.0;
b_s         = 0.1;
% object(object2 in paper)
m_w         = 3.0;
b_w         = 1.0;
c_w         = 50.0;

%% simulation
% slave controller
tau_s = slave_controller(x_m, xd_m, xdd_m, f_m, x_s, xd_s, xdd_s, f_s);

% slave dynamics
xdd_s = (tau_s - f_s - b_s * xd_s) / m_s;
xd_s = xd_s + xdd_s * dt;
x_s = x_s + xd_s * dt;

% object impedance model
f_s = m_w * xdd_s + b_w * xd_s + c_w * x_s;

%% copy sim result to output variables

x_s_ = x_s;
xd_s_ = xd_s;
xdd_s_ = xdd_s;
f_s_ = f_s;
end

