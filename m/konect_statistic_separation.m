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
%		[1]  | lambda1/lambda2 |
%		[2]  | lambda2/lambda1 |
%

function values = konect_statistic_separation(A, format, weights)

opts.disp = 2;

[U D] = konect_decomposition('sym', A, 2, format, weights, opts);

values = [ abs(D(1,1) / D(2,2)); ...
	   abs(D(2,2) / D(1,1)) ];
