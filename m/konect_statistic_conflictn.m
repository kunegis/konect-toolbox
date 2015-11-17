%
% Compute the normalized algebraic conflict [conflictn].
%
% PARAMETERS 
%	a	Adjacency of biadjacency matrix
%	format
% 	weight
%
% RESULT 
%	values	Normalized algebraic conflict; 0 for unweighted networks
%

function values = konect_statistic_conflictn(a, format, weights)

opts.disp = 2; 

[u d] = konect_decomposition('sym-n', a, 1, format, weights, opts);

values = 1 - d(1,1); 
