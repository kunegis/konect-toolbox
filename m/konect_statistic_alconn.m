%
% Compute the normalized algebraic connectivity [alconn].
%
% PARAMETERS 
%	a	Adjacency or biadjacency matrix
%	format
%	weights
%
% RESULT 
%	value	The normalized algebraic connectivity
%

function value = konect_statistic_alconn(a, format, weights)

opts.disp = 2; 

[u d] = konect_decomposition('lap-n', a, 2, format, weights, opts);

value = d(2,2)

