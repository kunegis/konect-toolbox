%
% Compute the power law exponent [power].
%
% PARAMETERS 
%	A 	Adjacency/biadjacency matrix
%	format
%	weights
%
% RESULT 
%	values	Column vector of values
%		for undirected graph:  power_a, sigma_a
%		for directed graph: power_a, sigma_a, power_u, sigma_u, power_v, sigma_v
%		for bipartite graph:  power_a, sigma_a, power_u, sigma_u, power_v, sigma_v
%		for POSITIVE graphs, append the same on the underlying UNWEIGHTED network
%

function values = konect_statistic_power(A, format, weights)

consts = konect_consts(); 

values = []; 

if weights ~= consts.POSITIVE; 
    weights_used = [ consts.UNWEIGHTED ]; 
else
    weights_used = [ weights ; consts.UNWEIGHTED ]; 
end

% Ignore edge weights 
A = (A ~= 0); 

for k = 1 : length(weights_used)

    w = weights_used(k); 

    if format == consts.SYM | format == consts.ASYM
        [gamma sigma] = konect_power_law_flat(A | A', w);
        values = [ values ; gamma ; sigma];
    else % BIP
        [m n] = size(A); 
        [gamma sigma] = konect_power_law_flat([sparse(m,m) A; A' sparse(n,n)], w); 
        values = [ values ; gamma ; sigma]; 
    end

    if format == consts.ASYM | format == consts.BIP
        [gamma sigma] = konect_power_law_flat(A, w);
        values = [values ; gamma ; sigma];
        [gamma sigma] = konect_power_law_flat(A', w);
        values = [values ; gamma ; sigma];
    end
end
