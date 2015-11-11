%
% Number of triangles, normalized such that for any n, in the uniform
% distribution, the statistic values have the same distribution.
%
% This approximation considers each possible triangle to be
% uncorrelated to others, and thus the total number of triangles is a
% binomial distribution with total count (n; 3) and probability for
% each triangle of 1/8. 
%

function values = konect_statistic_triangles_norm(A, format, weights)

t = konect_statistic_triangles(A, format, weights);
n = konect_statistic_size(A, format, weights);

%
% Assume a binomial distribution with the parameters:
%
% 	N = (n ; 3)
% 	P = 1/8
%
% Its normal approximation is given by
%
%	mu = PN
%	sigma = sqrt(NP(1-P))
% 

mu = (1/48) * n * (n-1) * (n-2);

sigma = sqrt( 7 / 384 * n * (n-1) * (n-2));

values = (t - mu) / sigma;

