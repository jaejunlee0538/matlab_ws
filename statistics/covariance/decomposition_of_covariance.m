% A = L * L' = U' * U
% inv(A) = inv(L')*inv(L) = inv(U)*inv(U')
% ref[1] - 12p. chi^2 AND mahalanobis distance
x = rand(200,3);
mu_ = mean(x,1);
cov_ = cov(x);

U = chol(cov_, 'upper');
cov_ - U'*U

L = chol(cov_, 'lower');
cov_ - L*L'

% [1] http://ais.informatik.uni-freiburg.de/teaching/ws11/robotics2/pdfs/rob2-20-dataassociation.pdf
% 