%
% Bipartivity [bip].  This is defined as
%
% 	[bip] = 1 - [nonbip] = | λ_min[A] / λ_max[A] |,
%
% i.e., the absolute ratio between the smallest and largest eigenvalue
% of the adjacency matrix' eigenvalues.  Note:  "smallest eigenvalue"
% refers here to the actual smallest eigenvalue, i.e., the one nearest
% to minus infinity, rather than the one nearest to zero.
%
% The highest possible value is +1 for bipartite networks (and only for
% them). The infinimum of possible values is zero, but zero itself
% cannot be attained for nonempty loopless graphs.  This can be proved
% easily by noticing that the trace of the adjacency matrix of a
% loopless graph is zero, and therefore there has to be at least one
% negative eigenvalue. Note that a graph containing only loops,
% including a graph containing no edges at all, has a [bip] value of
% zero. 
%
% In general, measures of non-bipartivity are prefered over measures of
% bipartivity in KONECT.
%
% ATTRIBUTE:  square
%

function values = konect_statistic_bip(A, format, weights)

error unimplemented here

