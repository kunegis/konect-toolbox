%
% Normalized clustering coefficient, such that for large n, the
% distribution of values over all n-graphs is independent of n. 
%

function values = konect_statistic_clusco_norm(A, format, weights)

v = konect_statistic_clusco2(A, format, weights);

v = v(1);

n = size(A,1); 

values = (v - 0.5) * sqrt(n * (n-1) / 2); 

