close all
global coeff_
pos1 = 0.0;
vel1 = 1.0;
acc1 = 1.0;
pos2 = 0.01;
vel2 = 1.0;
acc2 = 0.0;
duration = 0.016;
sampling_time = 0.008;

set_profile_duration(pos1, vel1, acc1, pos2, vel2, acc2, duration);

% t = 0:sampling_time:duration;
t = (-0.018):0.001:(duration + 10*0.001);
pos = zeros(size(t));
vel = zeros(size(t));
acc = zeros(size(t));
for i = 1:length(t)
    pos(i) = spline_pos(t(i));
    vel(i) = spline_vel(t(i));
    acc(i) = spline_acc(t(i));
end
equation = sprintf('init[%.4f %.4f %.4f] / goal[%.4f %.4f %.4f] \r\nx(t)=%.4ft^5 + %.4ft^4 + %.4ft^3 + %.4ft^2 + %.4ft + %.4f',...
    pos1,vel1,acc1,pos2,vel2,acc2,...
    coeff_(6),coeff_(5),coeff_(4),coeff_(3),coeff_(2),coeff_(1));
figure();
subplot(3,1,1);
plot(t, pos,'linewidth',2);
grid on; hold on;
plot(0, pos1,'rx','markersize',20,'linewidth',3)
plot(duration, pos2,'kx','markersize',20,'linewidth',3)
legend('spline','start','goal');
xlabel('t(sec)', 'fontsize',20);
ylabel('angle(rad)', 'fontsize',20);
c_xlim = get(gca,'xlim');
c_ylim = get(gca,'ylim');
x_len = (c_xlim(2) - c_xlim(1))*0.1;
y_len = (c_ylim(2) - c_ylim(1))*0.1;
set(gca,'xlim',[c_xlim(1)-x_len, c_xlim(2)+x_len])
set(gca,'ylim',[c_ylim(1)-y_len, c_ylim(2)+y_len])
title(equation,'fontsize',15);

subplot(3,1,2);
plot(t, vel,'linewidth',2);
grid on; hold on;
plot(0, vel1,'rx','markersize',20,'linewidth',3)
plot(duration, vel2,'kx','markersize',20,'linewidth',3)
legend('spline','start','goal');
xlabel('t(sec)', 'fontsize',20);
ylabel('angular vel(rad/s)', 'fontsize',20);
c_xlim = get(gca,'xlim');
c_ylim = get(gca,'ylim');
x_len = (c_xlim(2) - c_xlim(1))*0.1;
y_len = (c_ylim(2) - c_ylim(1))*0.1;
set(gca,'xlim',[c_xlim(1)-x_len, c_xlim(2)+x_len])
set(gca,'ylim',[c_ylim(1)-y_len, c_ylim(2)+y_len])

subplot(3,1,3);
plot(t, acc,'linewidth',2);
grid on; hold on;
plot(0, acc1,'rx','markersize',20,'linewidth',3)
plot(duration, acc2,'kx','markersize',20,'linewidth',3)
legend('spline','start','goal');
xlabel('t(sec)', 'fontsize',20);
ylabel('angular acc(rad/s^2)', 'fontsize',20);
c_xlim = get(gca,'xlim');
c_ylim = get(gca,'ylim');
x_len = (c_xlim(2) - c_xlim(1))*0.1;
y_len = (c_ylim(2) - c_ylim(1))*0.1;
set(gca,'xlim',[c_xlim(1)-x_len, c_xlim(2)+x_len])
set(gca,'ylim',[c_ylim(1)-y_len, c_ylim(2)+y_len])

