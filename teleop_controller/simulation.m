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
comm_delay = 1000; % 100 dt steps
sim_time = 50;
t = linspace(0, sim_time, sim_time/dt);

%% initial condition
x_m = 0; xd_m = 0; xdd_m = 0; f_m = 0;
x_s = 0; xd_s = 0; xdd_s = 0; f_s = 0;

xd_m_delayed = 0;
f_m_delayed = 0;
xd_s_delayed = 0;
f_s_delayed = 0;
Em_in_delayed = 0;
Es_in_delayed = 0;

x_ms = 0;
xd_ms = 0;
xdd_ms = 0;
xd_ms_prev = 0;

x_sm = 0;
xd_sm = 0;
xdd_sm = 0;
xd_sm_prev = 0;

%% simulation start
IDX_x_m=1; IDX_xd_m=2; IDX_xdd_m=3; IDX_f_m=4; IDX_Em_in=5;IDX_Em_out=6;
IDX_xd_s_delayed = 7; IDX_f_s_delayed = 8; IDX_Es_in_delayed = 9; IDX_x_sm = 10;
master_data = zeros(length(t), 10);

IDX_x_s=1; IDX_xd_s=2; IDX_xdd_s=3; IDX_f_s=4; IDX_Es_in=5; IDX_Es_out=6;
IDX_xd_m_delayed = 7; IDX_f_m_delayed = 8; IDX_Em_in_delayed = 9; IDX_x_ms = 10;
slave_data = zeros(length(t), 10);

for i = 2:length(t)
    %% receiving delayed data
    if i > (comm_delay+1)
        idx_delayed_data = i-(comm_delay+1);
        
        xd_s_delayed = slave_data(idx_delayed_data, IDX_xd_s);
        f_s_delayed = slave_data(idx_delayed_data, IDX_f_s);
        Es_in_delayed = slave_data(idx_delayed_data, IDX_Es_in);
        
        f_m_delayed = master_data(idx_delayed_data, IDX_f_m);
        xd_m_delayed = master_data(idx_delayed_data, IDX_xd_m);
        Em_in_delayed = master_data(idx_delayed_data, IDX_Em_in);
    end
    
    %% -----------------------Master Side-----------------------------------
    % generate operator input at time t
    tau_op = input_force(t(i));
    
    % if TDPA is on and network is active, f_s_delayed will be modified.
    % Otherwise, f_s_delayed will be left intact.
    [f_s_delayed, Em_in, Em_out] = TDPA_master(xd_m, f_s_delayed, Es_in_delayed, dt, TDPA_ON);
    
    % calculating xdd_s and x_s from xd_s.
    xd_sm_prev = xd_sm;
    xd_sm = xd_s_delayed;
    xdd_sm = (xd_sm - xd_sm_prev)/dt;
    x_sm = x_sm + xd_sm*dt;
    
    % simulate master
    [x_m, xd_m, xdd_m, f_m] = master_simulation(x_sm, xd_sm, xdd_sm, f_s_delayed, ...
        tau_op, dt, master_controller);
    %---------------------------------------------------------------------
    
    %% -----------------------Slave Side-----------------------------------
    
    % if TDPA is on and network is active, xd_m_delayed will be modified.
    % Otherwise, xd_m_delayed will be left intact.
    [xd_m_delayed, Es_in, Es_out] = TDPA_slave(xd_m_delayed, f_s, Em_in_delayed, dt, TDPA_ON);
    
    % calculating xdd_m and x_m from xd_m.
    xd_ms_prev = xd_ms;
    xd_ms = xd_m_delayed;
    xdd_ms = (xd_ms - xd_ms_prev)/dt;
    x_ms = x_ms + xd_ms*dt;
    
    % simulate slave
    [x_s, xd_s, xdd_s, f_s] = slave_simulation(x_ms, xd_ms, xdd_ms, f_m_delayed,...
        dt, slave_controller); 
    %---------------------------------------------------------------------
    
    %% Sending data
    master_data(i,:) = [x_m, xd_m, xdd_m, f_m, Em_in, Em_out, xd_s_delayed, f_s_delayed, Es_in_delayed, x_sm];
    slave_data(i,:) = [x_s, xd_s, xdd_s, f_s, Es_in, Es_out, xd_m_delayed, f_m_delayed, Em_in_delayed, x_ms];
end


%% plotting control result
figure(1);
subplot(1,2,1);
plot(t, master_data(:,IDX_x_m), 'r','linewidth',2);
hold on; grid on;
plot(t, slave_data(:, IDX_x_s), 'b','linewidth',2);
hold off;
xlabel('t(sec)','fontsize',15); ylabel('position(m)','fontsize',15)
legend('master', 'slave');
title(strcat(controller_type.name,'(position response)'),'fontsize',20);


subplot(1,2,2);
plot(t, master_data(:,IDX_f_m), 'r','linewidth',2);
hold on; grid on;
plot(t, slave_data(:, IDX_f_s), 'b','linewidth',2);
hold off;
xlabel('t(sec)','fontsize',15); ylabel('force(N)','fontsize',15)
legend('master', 'slave');
title(strcat(controller_type.name,'(force response)'),'fontsize',20);

%% TDPA Result
figure(2)
subplot(1,2,1);
[ax,h1,h2] = plotyy(t, master_data(:, IDX_f_s_delayed), ...
    t, [master_data(:,IDX_Es_in_delayed),master_data(:,IDX_Em_out)]);
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
[ax,h1,h2] = plotyy(t,slave_data(:, IDX_xd_m_delayed),...
    t,[slave_data(:,IDX_Em_in_delayed), slave_data(:, IDX_Es_out)]);
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

%% 
figure(3)
subplot(2,1,1);
plot(t, master_data(:, IDX_x_m), t, slave_data(:,IDX_x_ms));
h = legend('X_m', 'X_m_s');
set(h, 'fontsize',15);
title('X_m viewed from slave','fontsize',20)
xlabel('t(sec)', 'fontsize',15);
ylabel('position','fontsize',15);

subplot(2,1,2);
plot(t, slave_data(:, IDX_x_s), t, master_data(:, IDX_x_sm));
h = legend('X_s', 'X_s_m');
set(h, 'fontsize',15);
title('X_s viewed from master','fontsize',20)
xlabel('t(sec)', 'fontsize',15);
ylabel('position','fontsize',15);


