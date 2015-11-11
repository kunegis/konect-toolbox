%
% Compute the spectral norm [snorm]. 
% 
% PARAMETERS 
%	a 	Adjacency/biadjacency matrix
%	format 
%	weights
%	opts	(optional) Options passed to eigs/svds
%
% RESULT 
%	values	The spectral norm 
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function values = konect_statistic_snorm(a, format, weights, opts) 

if ~exist('opts', 'var'),    
    opts = struct();     
    opts.disp = 2; 
end

[u d] = konect_decomposition('sym', a, 1, format, weights, opts);
values = abs(d(1,1));

