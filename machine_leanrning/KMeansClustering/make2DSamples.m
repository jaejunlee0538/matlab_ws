clear all;
close all;
clc;

%% parameters
% mu array: [mu1 ; mu2 ; mu3] => size : K x D
% sigma array: [sig1 , sig2, sig3] => size : D x (D x K)

% same size gaussian sample
% mu = [0,0 ; -3,3 ; 3,3];
% sigma = [[1,0;0,1] , [1,0;0,1] , [1,0;0,1]];

mu = [0,-1 ; -3,3 ; 3,3];
sigma = [[3,0;0,3] , [1,0;0,1] , [1,0;0,1]];

N = 500;

%% 
% size of mu : D x K
mu = mu';
% 
D = size(mu,1);
% number of means
K = size(mu,2);
% sigma - size : D x D x K
sigma = reshape(sigma, size(sigma,1), size(sigma,1), K);

%% generate data set

data = zeros(D, N, K);
for i =1:1:K
    data(:,:,i) = sample_gaussian(mu(:,i), sigma(:,:,i),N)';
end

save('gaussian_samples', 'data', 'mu','sigma')


