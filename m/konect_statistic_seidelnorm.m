%
% Compute the "Seidel norm", i.e., the largest absolute value of the
% Seidel adjacency matrix.
%
% PARAMETERS 
%	a 	Adjacency/biadjacency matrix
%	format 
%	weights
%	opts	(optional) Options passed to eigs/svds
%
% RESULT 
%	values	The Seidel norm 
%

function values = konect_statistic_seidelnorm(A, format, weights, opts) 

if ~exist('opts', 'var'),    
    opts = struct();     
    opts.disp = 2; 
end

[U D] = konect_decomposition('seidel', A, 1, format, weights, opts);

values(1) = abs(D(1,1));
