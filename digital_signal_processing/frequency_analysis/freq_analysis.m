% close all
% f = 440;
% sampling_rate = 11025;
% n = 0:1/sampling_rate:1;
% x = sin(2*pi*f*n);
% 
% X = fft(x, 25);
% 
% freq_range = 0:(sampling_rate);
% 
% plot(freq_range, X);
%% prof code
clear all
close all
f = 440;
sampling_rate = 11025;
n = 0:1/sampling_rate:1;
x = sin(2*pi*f*n);

N = 1024;
xw = x(1:N)'.*hamming(N);
% xw = x(1:N)';

X = fft(xw);
X_mag = 20*log10(abs(X));
X_phase = unwrap(angle(X));

f = (0:N-1)*sampling_rate/N;

% original & windowed signal
figure(1);
plot(n(1:N), x(1:N),'r'); hold on
plot(n(1:N), xw(1:N),'b');
hold off
legend('original signal', 'windowed signal');

figure(2);
plot(f, X_mag);

figure(3);
plot(f, X_phase);
