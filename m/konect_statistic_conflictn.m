%
% Compute the normalized algebraic conflict [conflictn].  This is
% related to the spectrum of the normalized Laplacian, and not just a
% normalization of the regular conflict, which is related to the
% spectrum of the regular Laplacian. 
%
% PARAMETERS 
%	A	Adjacency of biadjacency matrix
%	format
% 	weight
%
% RESULT 
%	values	Normalized algebraic conflict; 0 for unweighted networks
%

function values = konect_statistic_conflictn(A, format, weights)

opts.disp = 2; 

[U D] = konect_decomposition('sym-n', A, 1, format, weights, opts);

values = 1 - D(1,1); 
