%
% Compute the power law exponent using the correct and slow method [power2].
%
% PARAMETERS 
%	A 	Adjacency/biadjacency matrix
%	format
%	weights
%
% RESULT 
%	values	Column vector of values
%		for undirected graph:  power_a, xmin_a, L_a
%		for directed graph: power_a, ..., power_u, ..., power_v, ...
%		for bipartite graph:  power_a, ..., power_u, ..., power_v, ...
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function values = konect_statistic_power2(A, format, weights)

consts = konect_consts(); 

values = []; 

% Ignore edge weights
A = (A ~= 0); 

if format == consts.SYM | format == consts.ASYM
    nvalues = konect_power_law_range(A | A', weights);
    values = [ values ; nvalues];
else % BIP
    [m n] = size(A); 
    nvalues = konect_power_law_range([sparse(m,m) A; A' sparse(n,n)], weights); 
    values = [ values ; nvalues]; 
end

if format == consts.ASYM | format == consts.BIP
    nvalues = konect_power_law_range(A, weights);
    values = [values ; nvalues];
    nvalues = konect_power_law_range(A', weights);
    values = [values ; nvalues];
end
