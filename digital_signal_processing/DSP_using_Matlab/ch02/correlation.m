clear all;
figure(1);

%% original signal
x = linspace(8.0 , 0, 30);
nx = 0:(length(x)-1);
subplot(2,2,2);
stem(nx,x);title('original signal');

%% shifted and noise-added signal
[y,ny] = sigshift(x,nx,5);              % obtain x(n-2)
w = randn(1,length(y)); nw = ny;        % generate w(n)
[y,ny] = sigadd(y,ny,w,nw);             % obtain y(n) = x(n-2) + w(n)
subplot(2,2,1);
stem(ny,y);title('shifted + noise');

%% folded signal for calculating correlation
[x,nx] = sigfold(x,nx);                 % obtain x(-n)
[rxy,nrxy] = conv_m(y,ny,x,nx);         % cross-corrlation
subplot(2,2,3);
stem(nx,x);title('folded signal');

%% correlation
subplot(2,2,4);
stem(nrxy,rxy);title('correlation');



% Example 2.9
%
% x(n)=[3,11,7,0,-1,4,2]; nx = [-3:3]
% y(n)=x(n-2)+w(n)
% ryx = cross(y,x)
%
% noise sequence 1
% 
% x = [3, 11, 7, 0, -1, 4, 2]; nx=[-3:3]; % given signal x(n)
% [y,ny] = sigshift(x,nx,2);              % obtain x(n-2)
% w = randn(1,length(y)); nw = ny;        % generate w(n)
% [y,ny] = sigadd(y,ny,w,nw);             % obtain y(n) = x(n-2) + w(n)
% [x,nx] = sigfold(x,nx);                 % obtain x(-n)
% [rxy,nrxy] = conv_m(y,ny,x,nx);         % cross-corrlation
% subplot(2,1,1);stem(nrxy,rxy)
% axis([-4,8,-50,250]);xlabel('lag variable l')
% ylabel('rxy');title('Crosscorrelation: noise sequence 1')
% gtext('Maximum')
% 
% %
% 
% % noise sequence 2
% 
% x = [3, 11, 7, 0, -1, 4, 2]; nx=[-3:3]; % given signal x(n)
% [y,ny] = sigshift(x,nx,2);              % obtain x(n-2)
% w = randn(1,length(y)); nw = ny;        % generate w(n)
% [y,ny] = sigadd(y,ny,w,nw);             % obtain y(n) = x(n-2) + w(n)
% [x,nx] = sigfold(x,nx);                 % obtain x(-n)
% [rxy,nrxy] = conv_m(y,ny,x,nx);         % cross-corrlation
% subplot(2,1,2);stem(nrxy,rxy)
% gtext('Maximum')
% axis([-4,8,-50,250]);xlabel('lag variable l')
% ylabel('rxy');title('Crosscorrelation: noise sequence 2')