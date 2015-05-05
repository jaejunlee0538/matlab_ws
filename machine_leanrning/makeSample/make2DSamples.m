clear all;
close all;
clc;

K=4;
dim = 2;

gnd_truth(1) = struct('N',200,'M',100,'mu',[10 10]','cov',[6 2; 2 2]);
gnd_truth(2) = struct('N',200,'M',100,'mu',[4 1]','cov',[1 0.7; 0.7 4]);
gnd_truth(3) = struct('N',200,'M',100,'mu',[-5 4]','cov',[1 -0.4;-0.4 5]);
gnd_truth(4) = struct('N',200,'M',100,'mu',[10 0]','cov',[6 2; 2 2]);

figure()
subplot(1,2,1)
x1 = sample_gaussian(gnd_truth(1).mu', gnd_truth(1).cov,gnd_truth(1).N);
plot(x1(:,1),x1(:,2),'b.');
hold on;
x2 = sample_gaussian(gnd_truth(2).mu', gnd_truth(2).cov,gnd_truth(2).N);
plot(x2(:,1),x2(:,2),'r.');
x3 = sample_gaussian(gnd_truth(3).mu', gnd_truth(3).cov,gnd_truth(3).N);
plot(x3(:,1),x3(:,2),'k.');
x4 = sample_gaussian(gnd_truth(4).mu', gnd_truth(4).cov,gnd_truth(4).N);
plot(x4(:,1),x4(:,2),'m.');
title('training set')

subplot(1,2,2)
x1_t = sample_gaussian(gnd_truth(1).mu', gnd_truth(1).cov,gnd_truth(1).M);
plot(x1_t(:,1),x1_t(:,2),'b.');
hold on;
x2_t = sample_gaussian(gnd_truth(2).mu', gnd_truth(2).cov,gnd_truth(2).M);
plot(x2_t(:,1),x2_t(:,2),'r.');
x3_t = sample_gaussian(gnd_truth(3).mu', gnd_truth(3).cov,gnd_truth(3).M);
plot(x3_t(:,1),x3_t(:,2),'k.');
x4_t = sample_gaussian(gnd_truth(4).mu', gnd_truth(4).cov,gnd_truth(4).M);
plot(x4_t(:,1),x4_t(:,2),'m.');
title('test set')

training_data = [x1 1*ones(length(x1),1);x2 2*ones(length(x2),1);x3 3*ones(length(x3),1); x4 4*ones(length(x4),1)];
test_data = [x1_t 1*ones(length(x1_t),1);x2_t 2*ones(length(x2_t),1);x3_t 3*ones(length(x3_t),1); x4_t 4*ones(length(x4_t),1)];
training_data = training_data';
test_data = test_data';
save('4_gaussian_samples','training_data','test_data','K')

