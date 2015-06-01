% b) x(n) = n[u(n)-u(n-10)]+10*exp(-0.3(n-10))(u(n-10)-u(n-20)); 0<=n<=20
n = 0:20;
x1 = n.*(stepseq(0,0,20)-stepseq(10,0,20));
x2 = 10*exp(-0.3*(n-10)).*(stepseq(10,0,20)-stepseq(20,0,20));
x = x1+x2;
subplot(2,2,1);stem(n,x);
title('original signal')
xlabel('n');ylabel('x(n)');axis([0,20,-1,11])

[xe, xo, m] = evenodd(x, n);

subplot(2,2,3);
stem(m,xe); title('x even')

subplot(2,2,4);
stem(m,xo); title('x odd')

x_reproduced = xe + xo;
subplot(2,2,2);
stem(m,x_reproduced); title('reproduced signal(xe + xo)')
