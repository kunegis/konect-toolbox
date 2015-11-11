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
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function value = konect_statistic_alconn(a, format, weights)

opts.disp = 2; 

[u d] = konect_decomposition('lap-n', a, 2, format, weights, opts);

value = d(2,2)

