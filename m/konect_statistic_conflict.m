%
% Compute the algebraic conflict [conflict].  The conflict is
% computed for the largest connected component. 
%
% PARAMETERS 
%	A 	Adjacency or biadjacency matrix
%	format
%	weights
%
% RESULT 
%	values	Results as column vector
%		[1] The algebraic conflict \xi
%		[2] The relative relaxed frustration \xi n / 8 m
%
% ATTRIBUTE:  negative
%

function values = konect_statistic_conflict(A, format, weights)

consts = konect_consts(); 

opts.disp = 2; 

if weights == consts.UNWEIGHTED | weights == consts.POSITIVE | ...
            weights == consts.POSWEIGHTED
    % Would be zero.  We don't allow that.
    assert(0); 
end

% Build the Laplacian matrix L
if format ~= consts.BIP 
    [A cc n] = konect_connect_matrix_square(A);
    % M is computed as an undirected graph 
    L = konect_matrix('lap', A, format, weights, opts); 
    m = (nnz(L) - n) / 2;
else % BIP
    [A cc1 cc2 n] = konect_connect_matrix_bipartite(A); 
    L = konect_matrix('lap', A, format, weights, opts); 
    m = nnz(A); 
end

lambda_n = eigs(L, 1, 'lm', opts)

lambda_n_minus_1 = eigs(lambda_n * speye(size(L,1)) - L, 1, 'lm', opts)

conflict = lambda_n - lambda_n_minus_1

values = [ ...
    conflict, ...
    (conflict * n / 8 / m)
         ]'; 


