%
% Compute the unique volume of a network, i.e., the number of edges
% without taking into account edge multiplicities.
%
% Note:  this looks trivial, but we can't replace it by the number
% of lines in the out.* file.  In other words, [uniquevolume] is
% distinct from [lines]. 
%
% PARAMETERS 
%	A	Adjacency or biadjacency matrix
%	format
%	weights
%
% RESULT 
%	values	Column vector of results
%		[1] Unique volume
%
%
% GROUP:  MULTI
%

function values = konect_statistic_uniquevolume(A, format, weights)

[negative, interval_scale, multi] = konect_data_weights();

multi
weights

multi(weights)

assert(multi(weights) == 1); 

values = nnz(A); 
