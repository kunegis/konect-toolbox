%
% Compute the smallest eigenvalue of the signless Laplacian K = D + A
% of the underlying unweighted graph, multiplied by n/(8m).  This is a
% measure of bipartivity in the range [0, 1/2].  The matrix A is
% computed by ignoring edge weights.  Multiple edges are not taken
% into account.  The computation is restricted to the network's
% largest connected component. 
%
% GROUP:  square
%
% PARAMETERS 
%	A 	Adjacency or biadjacency matrix
%	format
%	weights
%
% RESULT 
%	values
%		[1] The smallest eigenvalue * n/(8m); zero for bipartite networks
%		[2] The eigenvalue it self [nonbipal], \chi 
%

function values = konect_statistic_anticonflict(A, format, weights)

consts = konect_consts(); 

opts.disp = 2; 

if format == consts.BIP
    % We know it is zero 
    values = [ 0 ]; 
    return; 
end

% Ignore edge weights and multiplicities
A = ( A ~= 0 );

A = A | A';
A = triu(A); 

% Restrict computation to the largest connected component 
A = konect_connect_matrix_square(A); 

K = konect_matrix('lapqu', A, format, weights);

[U D] = konect_eigl(K, 1, opts, 'lm'); 

lambda_min_K = D(1,1)

if lambda_min_K < 0
    % K is positive semi-definite, so we now that this is a numerical
    % error. Round to zero.   
    lambda_min_K = 0 
end

A_abs = konect_absx(A); 

n = nnz(sum(A_abs, 1)' + sum(A_abs, 2)) 
m = nnz(A) 

anticonflict = lambda_min_K * n / 8 / m 

assert(anticonflict >= 0);
assert(anticonflict <= 0.5); 

values = [ anticonflict ; lambda_min_K ]; 
