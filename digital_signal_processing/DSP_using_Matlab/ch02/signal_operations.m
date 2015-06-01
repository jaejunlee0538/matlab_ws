%% step signal
[x1,n1] = stepseq(0, -10, 10);
[x2,n2] = impseq(3, -5, 5);

%% signal addition
[x3, n3] = sigadd(x1,n1,x2,n2);

figure(1);
subplot(3,1,1);
plot(n1,x1,'.','MarkerSize',20); grid on;title('signal addition')
subplot(3,1,2);
plot(n2,x2,'.','MarkerSize',20); grid on;
subplot(3,1,3);
plot(n3,x3,'.','MarkerSize',20); grid on;

%% signal multiplication
[x3, n3] = sigmult(x1,n1,x2,n2);

figure(2);
subplot(3,1,1);
plot(n1,x1,'.','MarkerSize',20); grid on;title('signal multiplication');
subplot(3,1,2);
plot(n2,x2,'.','MarkerSize',20); grid on;
subplot(3,1,3);
plot(n3,x3,'.','MarkerSize',20); grid on;

%% signal scaling
x1 = 2.0 * x1;
n1 = n1;

%% signal shifting
[x3,n3] = sigshift(x1,n1, 5);

figure(3);
subplot(2,1,1);
plot(n1,x1,'.','MarkerSize',20); grid on;title('signal shifting');
subplot(2,1,2);
plot(n3,x3,'.','MarkerSize',20); grid on;

%% signal folding
[x1,n1] = sigshift(x1,n1, 5);
[x3,n3] = sigfold(x1,n1);

figure(4);
subplot(2,1,1);
plot(n1,x1,'.','MarkerSize',20); grid on;title('signal folding');
subplot(2,1,2);
plot(n3,x3,'.','MarkerSize',20); grid on;

%% sample summation


%% sample product

%% signal energy
Ex = sum(x1 .* conj(x1));
Ex = sum(abs(x1) .^ 2); 

