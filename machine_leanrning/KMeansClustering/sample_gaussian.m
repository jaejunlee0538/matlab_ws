function M = sample_gaussian(mu, Sigma, N)
mu = mu(:);
n=length(mu);
[U,D,V] = svd(Sigma);
M = randn(n,N);
M = (U*sqrt(D))*M + mu*ones(1,N); 
M = M';