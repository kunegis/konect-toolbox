%
% The dyadic conflict \eta. Only for signed directed networks. This
% is the proportion of node pairs ("dyads") connected by two edges in
% opposite directions in which the node edges have opposite sign.  It
% can be seen as a rudimentary measure of conflict in signed directed
% graphs. 
%
% PARAMETERS 
%	A	Adjacency matrix
%	format	must be ASYM
%	weights must be one the signed weights
%
% RESULTS 
%	values	Column vector of results
%		[1] \eta
%
% GROUP:  asymnegative
%

function values = konect_statistic_dconflict(A, format, weights)

consts = konect_consts(); 

assert(format == consts.ASYM);
assert(weights == consts.SIGNED | weights == consts.MULTISIGNED | ...
       weights == consts.WEIGHTED | weights == consts.MULTIWEIGHTED); 

[m n] = size(A)

assert(m == n);

A_abs = konect_absx(A); 

m_dyads = nnz(A_abs & A_abs')

m_conflict = nnz((A > 0) & (A' < 0))

values = [ (m_conflict / m_dyads) ]


