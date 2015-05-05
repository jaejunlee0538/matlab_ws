% close all;
clear all;
%% 
g = 9.81;
m = 68.1;
cd = 0.25;
dt = 1;

%% differential equation of xd
diff_eq = @(xd) (g - cd/m*xd*xd);

%% analytical solution of xd, x
xd_ = @(t) (sqrt(g*m/cd) * tanh(sqrt(g*cd/m)*t));
x_ = @(t) (m/cd * log(cosh(sqrt(g*cd/m)*t)));

%% initial condition
x_euler = 0;
xd_euler = 0;
x_heun = 0;
xd_heun = 0;

%%
t_end = 25;
t = 0:dt:t_end;
if t(end) < t_end
    t(end+1) = t_end;
end

x_euler_log = zeros(size(t));
xd_euler_log = zeros(size(t));
x_heun_log = zeros(size(t));
xd_heun_log = zeros(size(t));
%% simulation
for i = 1:1:length(t)
    % euler method
    xdd = diff_eq(xd_euler);
    xd_euler = xd_euler + xdd * dt;
    x_euler = x_euler + xd_euler * dt;
    x_euler_log(i) = x_euler;
    xd_euler_log(i) = xd_euler;
    
    % heun method
    xdd = diff_eq(xd_heun);
    xdd_init = xdd;
    for k =1:1:3
        % predictor
        xd_heun_pred = xd_heun + xdd * dt;
        % corrector
        xdd = 0.5 * (xdd_init + diff_eq(xd_heun_pred));
    end
    xd_heun = xd_heun + xdd*dt;
    x_heun = x_heun + xd_heun*dt;
    x_heun_log(i) = x_heun;
    xd_heun_log(i) = xd_heun;
end

%% plot
lw = 1;
tfs = 30;

% x plot
figure(1)
clf
plot(t, x_(t), 'r-o','linewidth',lw);hold on;
plot(t, x_euler_log,'b-o','linewidth',lw); 
plot(t, x_heun_log,'m-o','linewidth',lw); 

grid on;
title('x','fontsize',tfs);
legend('analytic', 'euler','heun');

% xd plot
figure(2)
clf
plot(t, xd_(t), 'r-o','linewidth',lw);hold on;
plot(t, xd_euler_log,'b-o','linewidth',lw); 
plot(t, xd_heun_log,'m-o','linewidth',lw); 

grid on;
title('xd','fontsize',tfs);
legend('analytic', 'euler','heun');
%%
% autoArrangeFigures();