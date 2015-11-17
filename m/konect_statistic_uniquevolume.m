%
% Compute the unique volume of a network, i.e., the number of edges
% without taking into account edge multiplicities.
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

function values = konect_statistic_uniquevolume(A, format, weights)

consts = konect_consts();

values = nnz(A); 

% Note:  this looks trivial, but we can't replace it by the number
% of lines in the out.* file.  In other words, [uniquevolume] is
% distinct from [lines]. 

