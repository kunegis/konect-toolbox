% 
% Normalized number of unique edges, such that the value has standard
% normal distribution in uniform graphs.
%

function values = konect_statistic_volume_norm(A, format, weights)

m = konect_statistic_uniquevolume(A, format, weights); m = m(1);
p = 0.5; 
n = size(A,1); 

values = (m - p * (1/2) * n * (n-1)) / sqrt(p * (1-p) * (1/2) * n * (n-1));
