function samples = linearSample( a, b, min, max, N )
% x2 = (a * x1 + b) + random_noise.
% x1 is in range of [min max];

rnd = min + (max-min)*rand(N,1);

samples = [rnd  (a * rnd + b + sample_gaussian(0,10,N))];

end

