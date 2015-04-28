%% Introductory Digital Signal Processing, 2nd Edition, Paul A.Lynn. 
% example 1.2
close all;
clear all;
%% 
func1 = @(n)(exp(0.2*n));
func2 = @(n) (cos(pi*n/7));
func3 = @(n) (exp(n/15).*sin(pi*n/6));
unit_func = @(n) (n>=0);
func4 = @(n) (exp(-n/5).*cos(n).*unit_func(n));

%%
idx = -30:1:30;
figure()
stem(idx, func1(idx)); grid on;
figure()
stem(idx, func2(idx)); grid on;
figure()
stem(idx, func3(idx)); grid on;
figure()
stem(idx, func4(idx)); grid on;
autoArrangeFigures()


