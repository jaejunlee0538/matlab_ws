x = [3,11,7,0,-1,4,2];
nx = [-3:3];

h = [2,3,0,-5,2,1];
nh = [-1:4];

[y, ny] = conv_m(x,nx,h,nh);

figure(1)
subplot(2,1,1);
stem(nx,x,'r');
hold on
stem(nh,h,'b');
hold off;
legend('x', 'h');
title('x and h');

subplot(2,1,2);
stem(ny, y, 'r');
title('result of convolution');