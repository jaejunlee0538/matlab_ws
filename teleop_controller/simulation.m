clear all

%% Choose controller scheme

% set_position_position_controller
set_position_force_controller
% set_force_position_controller
% set_force_force_controller


master_controller = @(x_m, xd_m, xdd_m, f_m, x_s, xd_s, xdd_s, f_s) ((K_mpm * x_m + K_mpm_d * xd_m + K_mpm_dd * xdd_m + K_mfm * f_m) - ...
        (K_mps * x_s + K_mps_d * xd_s + K_mps_dd * xdd_s + K_mfs * f_s));
slave_controller = @(x_m, xd_m, xdd_m, f_m, x_s, xd_s, xdd_s, f_s) ((K_spm * x_m + K_spm_d * xd_m + K_spm_dd * xdd_m + K_sfm * f_m) - ...
        (K_sps * x_s + K_sps_d * xd_s + K_sps_dd * xdd_s + K_sfs * f_s));

%% operator input function
input_force = @(t) ( 5-5*cos(4*pi*t));
% input_force = @(t) ( 5-5*cos(1*pi*t));
% input_force = @(t) (1);

%% init simulation
TDPA_ON = 1;
dt = 0.001;
comm_delay = 100; % 100 dt steps
sim_time = 100;
t = linspace(0, sim_time, sim_time/dt);

x_m_log = zeros(size(t));
x_s_log = zeros(size(t));
f_m_log = zeros(size(t));
f_s_log = zeros(size(t));
f_s_delayed_log = zeros(size(t));
xd_m_delayed_log = zeros(size(t));
Em_in_log = zeros(size(t));
Em_out_log = zeros(size(t));
Es_in_log = zeros(size(t));
Es_out_log = zeros(size(t));

%% initial condition
x_m_delayed = 0;
xd_m_delayed = 0;
xdd_m_delayed = 0;
f_m_delayed = 0;
x_s_delayed = 0;
xd_s_delayed = 0;
xdd_s_delayed = 0;
f_s_delayed = 0;
Em_in_delayed = 0;
Es_in_delayed = 0;

%% simulation start
tau_op = input_force(t(1));
[x_m, xd_m, xdd_m, f_m] = master_simulation(x_s_delayed, xd_s_delayed, xdd_s_delayed, f_s_delayed,...
    tau_op, dt, master_controller);
[x_s, xd_s, xdd_s, f_s] = slave_simulation(x_m_delayed, xd_m_delayed, xdd_m_delayed, f_m_delayed,...
    dt, slave_controller);

buffer_master_to_slave = [x_m, xd_m, xdd_m, f_m, Em_in_delayed];
buffer_slave_to_master = [x_s, xd_s, xdd_s, f_s, Es_in_delayed];

for i = 2:length(t)
    if size(buffer_master_to_slave,1) > comm_delay
        from_master = buffer_master_to_slave(1,:);
        buffer_master_to_slave = buffer_master_to_slave(2:end,:);
        x_m_delayed = from_master(1);
        xd_m_delayed = from_master(2);
        xdd_m_delayed = from_master(3);
        f_m_delayed = from_master(4);
        Em_in_delayed = from_master(5);
    end
    if size(buffer_slave_to_master,1) > comm_delay
        from_slave = buffer_slave_to_master(1,:);
        buffer_slave_to_master = buffer_slave_to_master(2:end,:);
        x_s_delayed = from_slave(1);
        xd_s_delayed = from_slave(2);
        xdd_s_delayed = from_slave(3);
        f_s_delayed = from_slave(4);
        Es_in_delayed = from_slave(5);
    end

    %-----------------------Master Side-----------------------------------
    tau_op = input_force(t(i));
    if TDPA_ON == 0
        % TDPA Off
        Em_in = 0;
        Em_out= 0;
    else
        % TDPA On
        [f_s_delayed, Em_in, Em_out] = TDPA_master(xd_m, f_s_delayed, Es_in_delayed, dt);
    end
    [x_m, xd_m, xdd_m, f_m] = master_simulation(x_s_delayed, xd_s_delayed, xdd_s_delayed, f_s_delayed, ...
        tau_op, dt, master_controller);
    %---------------------------------------------------------------------
    
    %-----------------------Slave Side-----------------------------------
    if TDPA_ON == 0
        % TDPA Off
        Es_in = 0;
        Es_out= 0;
    else
        % TDPA On
        [xd_m_delayed, Es_in, Es_out] = TDPA_slave(xd_m_delayed, f_s, Em_in_delayed, dt);
    end
    
    [x_s, xd_s, xdd_s, f_s] = slave_simulation(x_m_delayed, xd_m_delayed, xdd_m_delayed, f_m_delayed,...
        dt, slave_controller); 
    %---------------------------------------------------------------------
    buffer_master_to_slave(end+1, :) = [x_m, xd_m, xdd_m, f_m, Em_in];
    buffer_slave_to_master(end+1, :) = [x_s, xd_s, xdd_s, f_s, Es_in];
    
    % logging
    x_m_log(i) = x_m;
    x_s_log(i) = x_s;
    f_m_log(i) = f_m;
    f_s_log(i) = f_s;
    f_s_delayed_log(i) = f_s_delayed;
    xd_m_delayed_log(i) = xd_m_delayed;
    Em_in_log(i) = Em_in;
    Em_out_log(i) = Em_out;
    Es_in_log(i) = Es_in;
    Es_out_log(i) = Es_out;
end

%% plotting control result
figure(1);
subplot(1,2,1);
plot(t, x_m_log, 'r','linewidth',2);
hold on; grid on;
plot(t, x_s_log, 'b','linewidth',2);
hold off;
xlabel('t(sec)','fontsize',15); ylabel('position(m)','fontsize',15)
legend('master', 'slave');
title(strcat(controller_type.name,'(position response)'),'fontsize',20);


subplot(1,2,2);
plot(t, f_m_log, 'r','linewidth',2);
hold on; grid on;
plot(t, f_s_log, 'b','linewidth',2);
hold off;
xlabel('t(sec)','fontsize',15); ylabel('force(N)','fontsize',15)
legend('master', 'slave');
title(strcat(controller_type.name,'(force response)'),'fontsize',20);

%% TDPA Result
figure(3)
subplot(1,2,1);
[ax,h1,h2] = plotyy(t, f_s_delayed_log, t, [Es_in_log',Em_out_log']);
set(h2(1),'linewidth',3);
set(h2(2),'linewidth',3);
set(h1,'linewidth',1);
set(h1, 'color','k');
set(get(ax(1),'Ylabel'),'String','F_s delayed')
set(get(ax(1),'Ylabel'),'FontSize',15)
set(get(ax(2),'Ylabel'),'String','Energy')
set(get(ax(2),'Ylabel'),'FontSize',15)
xlabel('t(sec)','fontsize',15); 
grid on;
lh = legend( 'F_s delayed', 'Es in', 'Em out');
set(lh,'fontsize',13)
set(lh,'location','northwest')
title('Master Side Port', 'fontsize', 20);


subplot(1,2,2);
[ax,h1,h2] = plotyy(t,xd_m_delayed_log, t,[Es_in_log',Em_out_log']);
set(h2(1),'linewidth',3);
set(h2(2),'linewidth',3);
set(h1,'linewidth',1);
set(h1, 'color','k');
set(get(ax(1),'Ylabel'),'String','X_d_m delayed')
set(get(ax(1),'Ylabel'),'FontSize',15)
set(get(ax(2),'Ylabel'),'String','Energy')
set(get(ax(2),'Ylabel'),'FontSize',15)
xlabel('t(sec)','fontsize',15); 
grid on;
lh = legend('X_d_m delayed', 'Em in', 'Es out');
set(lh,'fontsize',13)
set(lh,'location','northwest')
title('Master Side Port', 'fontsize', 20);
title('Slave Side Port', 'fontsize', 20);




