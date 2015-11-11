%
% Compute the spectral distribution of a symmetric matrix. This is an
% internal function that needs explicit bounds values.
%
% Use the method from:
%
% On Sampling-based Approximate Spectral Decomposition, Sanjiv
% Kumar, Mehryar Mohri, Ameet Talwalkar.  ICML 2009.
%
% PARAMETERS 
%	A	(n*n) Symmetric matrix 
%	lower	Lower bound for eigenvalues
%	upper	Upper bound for eigenvalues
%	k	Number of bins
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function [counts, begins, ends] = konect_spectral_distribution_plain2(A, lower, upper, k)

l_max = 2000;

assert(size(A, 1) == size(A, 2)); 

'compute norm for check'
epsi = norm(A - A', 'fro')
if abs(epsi) >= 1e-10, error('*** matrix A is not symmetric'); end

n = size(A,1)

begins = (lower + (upper - lower) * (0:(k-1)) / k)';
ends   = (lower + (upper - lower) * (1:k)     / k)';


% Column sample
'computing permutation'
p = randperm(n);

l = min(n, l_max)
pl = p(1:l);

'building sampled matrix'
C = A(pl, pl);

'call eig()'
dd = eig(full(C)); 
'done' 

dd'

dda = dd * (n / l);

for i = 1 : k
    
    counts(i) = sum(dda >= begins(i) & dda < ends(i)); 

end

counts = counts'

counts = counts * (n / sum(counts))

