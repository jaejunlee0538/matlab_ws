clear all;
close all;

K=4;
sampler1 = @(N)(linearSample(2,3,-10,20,N));
sampler2 = @(N)(linearSample(-0.5,60,-40,-10,N));
sampler3 = @(N)(linearSample(2,-30,-10,10,N));
sampler4 = @(N)(linearSample(2,50,-10,50,N));
N_training = 200;
N_test = 80;
x1 = sampler1(N_training);
x2 = sampler2(N_training);
x3 = sampler3(N_training);
x4 = sampler4(N_training);

x1_t = sampler1(N_test);
x2_t = sampler2(N_test);
x3_t = sampler3(N_test);
x4_t = sampler4(N_test);

figure();
subplot(1,2,1);
plot(x1(:,1),x1(:,2),'b.');hold on;
plot(x2(:,1),x2(:,2),'r.')
plot(x3(:,1),x3(:,2),'k.')
plot(x4(:,1),x4(:,2),'m.')
subplot(1,2,2);
plot(x1_t(:,1),x1_t(:,2),'b.');hold on;
plot(x2_t(:,1),x2_t(:,2),'r.')
plot(x3_t(:,1),x3_t(:,2),'k.')
plot(x4_t(:,1),x4_t(:,2),'m.')



training_data = [x1 1*ones(length(x1),1);x2 2*ones(length(x2),1);x3 3*ones(length(x3),1); x4 4*ones(length(x4),1)];
test_data = [x1_t 1*ones(length(x1_t),1);x2_t 2*ones(length(x2_t),1);x3_t 3*ones(length(x3_t),1); x4_t 4*ones(length(x4_t),1)];
training_data = training_data';
test_data = test_data';
save('data2.mat','training_data','test_data','K')