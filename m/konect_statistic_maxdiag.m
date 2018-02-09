%
% The cyclic eigenvalue:  For directed graphs, we can consider the
% largest eigenvalue of the (generally asymmetric) adjacency matrix.
% This is zero for acyclic graphs.  It equals the spectral norm and
% operator 2-norm for symmetric graphs.
%
% GROUP:  asym
%

function values = konect_statistic_maxdiag(A, format, weights, opts)

consts = konect_consts(); 
  
if format ~= consts.ASYM
  error('*** Error: [opnorm] expected format to be ASYM'); 
end
  
if ~exist('opts', 'var'),    
    opts = struct();     
    opts.disp = 2; 
end

opts.tol = 1e-7; % (default is 1e-14 in Matlab)

[U D V] = konect_decomposition('diag', A, 1, format, weights, opts);

values(1) = D(1,1)
assert(values(1) >= 0);
