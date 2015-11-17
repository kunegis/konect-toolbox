%
% Compute the spectral separation [separation].
% 
% PARAMETERS 
%	A	Adjacency / biadjacency matrix
%	format
%	weights
%
% RESULTS 
%	values 	Spectral separation
%

function values = konect_statistic_separation(A, format, weights)

opts.disp = 2;

[u d] = konect_decomposition('sym', a, 2, format, weights, opts);

values = abs(d(1,1) / d(2,2));
