%
% Compute the algebraic connectivity [alcon].
%
% PARAMETERS 
%	A	Adjacency or biadjacency matrix
%	format
%	weights
%	opts	(optional) Options passed to eigs/svds
%
% RESULT 
%	value	The algebraic connectivity
%
% TODO 
%
% * in analogy to anticonflict, define a normalized variant of the
%   algebraic conflict/connectivity as 
%   lambda_min [L] * 2 * sqrt(n) / e. 
%

function value = konect_statistic_alcon(A, format, weights, opts)

if ~exist('opts', 'var'),    
    opts = struct();     
    opts.disp = 2; 
end

[u d] = konect_decomposition('lap', A, 2, format, weights, opts); 

if size(d,1) < 2 
    value = NaN; 
    return; 
end

value = d(2,2);
