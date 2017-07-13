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
% GROUP:  negative
%

function value = konect_statistic_negativity(A, format, weights)

consts = konect_consts(); 
  
assert(weights == consts.SIGNED | weights == consts.MULTISIGNED | ...
       weights == consts.WEIGHTED | weights == consts.MULTIWEIGHTED); 

m = nnz(A);
m_negative = nnz(A < 0);

value = m_negative / m; 

