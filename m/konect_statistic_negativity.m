%
% Compute the reciprocity of a signed or weighted network, i.e., the
% proportion of negatively weighted edges.
%
% PARAMETERS 
%	A	Adjacency or biadjacency matrix
%	format
%	weights
%
% RESULT 
%	value	The negativity (in the range [0,1])
%

function value = konect_statistic_negativity(A, format, weights)

m = nnz(A);
m_negative = nnz(A < 0);

value = m_negative / m; 

