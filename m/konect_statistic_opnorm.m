%
% The largest singular value of a directed graphs asymmetric quadratric
% adjacency matrix.  This is also known as the Ky Fan 1-norm or the
% operator 2-norm. 
%
% GROUP:  asym 
%

function values = konect_statistic_opnorm(A, format, weights, opts)

consts = konect_consts(); 
  
if format ~= consts.ASYM
  error('*** Error: [opnorm] expected format to be ASYM'); 
end
  
if ~exist('opts', 'var'),    
    opts = struct();     
    opts.disp = 2; 
end

opts.tol = 1e-7; % (default is 1e-14 in Matlab)

[U D V] = konect_decomposition('svd', A, 1, format, weights, opts); 

values(1) = D(1,1)
assert(values(1) >= 0);
