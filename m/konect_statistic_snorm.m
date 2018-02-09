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

function values = konect_statistic_snorm(A, format, weights, opts) 

if ~exist('opts', 'var'),    
    opts = struct();     
    opts.disp = 2; 
end

[U D] = konect_decomposition('sym', A, 1, format, weights, opts);

values(1) = abs(D(1,1));
