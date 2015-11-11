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
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function value = konect_statistic_radius(a, format, weights)

opts.disp = 2; 

[u d] = konect_decomposition('diag', a, 1, format, weights, opts); 

value = d(1,1); 

