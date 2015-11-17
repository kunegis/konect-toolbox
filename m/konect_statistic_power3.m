%
% Compute the power law exponent using the correct and slow method, with p-values [power3].
%
% PARAMETERS 
%	A 	Adjacency/biadjacency matrix
%	format
%	weights
%
% RESULT 
%	values	Column vector of values
%		for undirected graph:  power_a, ...
%		for directed graph: power_a, ..., power_u, ..., power_v, ...
%		for bipartite graph:  power_a, ..., power_u, ..., power_v, ...
%

function values = konect_statistic_power3(A, format, weights)

consts = konect_consts(); 

values = []; 

% Ignore edge weights 
A = (A ~= 0); 

if format == consts.SYM | format == consts.ASYM
    nvalues = konect_power_law_range(A | A', weights, 1);
    values = [ values ; nvalues];
else % BIP
    [m n] = size(A); 
    nvalues = konect_power_law_range([sparse(m,m) A; A' sparse(n,n)], weights, 1); 
    values = [ values ; nvalues]; 
end

if format == consts.ASYM | format == consts.BIP
    nvalues = konect_power_law_range(A, weights, 1);
    values = [values ; nvalues];
    nvalues = konect_power_law_range(A', weights, 1);
    values = [values ; nvalues];
end
