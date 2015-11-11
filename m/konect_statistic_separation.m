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
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function values = konect_statistic_separation(A, format, weights)

opts.disp = 2;

[u d] = konect_decomposition('sym', a, 2, format, weights, opts);

values = abs(d(1,1) / d(2,2));
