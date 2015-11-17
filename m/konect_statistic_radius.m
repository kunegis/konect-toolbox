%
% Compute [normdiag]. 
%
% PARAMETERS 
%	a	Adjacency or biadjacency matrix
%	format
%	weights
%
% RESULT 
%	value	The value
%

function value = konect_statistic_radius(a, format, weights)

opts.disp = 2; 

[u d] = konect_decomposition('diag', a, 1, format, weights, opts); 

value = d(1,1); 

