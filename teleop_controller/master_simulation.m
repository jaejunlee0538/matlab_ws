function [x_m_, xd_m_, xdd_m_, f_m_] = master_simulation(x_s, xd_s, xdd_s, f_s, input_force, dt, master_controller)
persistent first_run
persistent x_m
persistent xd_m
persistent xdd_m
persistent f_m

%% initialize master simulator
if isempty(first_run)
    first_run = false;

    x_m = 0;
    xd_m = 0;
    xdd_m = 0;
    f_m = 0;
end
%% operator and master parameters
% operator
m_op        = 2.0;
b_op        = 2.0;
c_op        = 10.0;
% master
m_m         = 6.0;
b_m         = 0.1;

%% simulation
% operator impedance => master dynamics works at every cases
% master dynamics => operator impedance works except 1st case. 

tau_op = input_force;

% master controller
tau_m = master_controller(x_m, xd_m, xdd_m, f_m, x_s, xd_s, xdd_s, f_s);

% operator impedance model
f_m = tau_op - (m_op*xdd_m + b_op*xd_m + c_op*x_m);   

% master dynamics
xdd_m = (tau_m + f_m - b_m*xd_m) / m_m;
xd_m = xd_m + xdd_m * dt;
x_m = x_m + xd_m * dt;    

%% copy sim result to output variables
x_m_ = x_m;
xd_m_ = xd_m;
xdd_m_ = xdd_m;
f_m_ = f_m;

end

