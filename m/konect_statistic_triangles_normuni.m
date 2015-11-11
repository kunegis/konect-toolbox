%
% Number of triangles, normalized such that for any n, in the uniform
% distribution, the statistic values have the same distribution.
%
% This is the correct method as derived by a newer estimate of the
% variance. 
%

function values = konect_statistic_triangles_normuni(A, format, weights)

t = konect_statistic_triangles(A, format, weights);

n = konect_statistic_size(A, format, weights);

mu = (1/48) * n * (n-1) * (n-2);
sigma = sqrt(n^4 / 128 - (11 / 384) * n^3 + n^2 / 32 - n / 96);

values = (t - mu) / sigma;


