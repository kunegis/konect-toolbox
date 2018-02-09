%
% Compute the algebraic conflict [conflict].  The conflict is
% computed for the largest connected component.  Multiple edges as
% well as loops are ignored. 
%
% PARAMETERS 
%	A 	Adjacency or biadjacency matrix
%	format
%	weights
%
% RESULT 
%	values	Results as column vector
%		[1] The smallest eigenvalue of the signed Laplacian \lambda, based on largest connected component
%		[2] The relative relaxed frustration \xi = \lambda n / 8 m
%
% GROUP:  negative
%

function values = konect_statistic_conflict(A, format, weights)

consts = konect_consts(); 
[negative, interval_scale, multi] = konect_data_weights()

tol = 1e-6

opts.disp = 2; 

if 1 ~= negative(weights)
%% if weights == consts.UNWEIGHTED | weights == consts.POSITIVE | ...
%%    weights == consts.POSWEIGHTED
    % Would be zero.  We don't allow that.
    assert(0); 
    exit(1);
    error('***'); 
end

% Remove multiple edges
A = (A > 0) - (A < 0); 

% Build the Laplacian matrix L
if format ~= consts.BIP 

    [n1 n2] = size(A);
    assert(n1 == n2); 

    % Remove loops
    A = A - spdiags(diag(A), [0], n1, n1); 

    [A cc n] = konect_connect_matrix_square(A);
    % M is computed as an undirected graph 
    L = konect_matrix('lap', A, format, weights, opts); 
    m = (nnz(L) - n) / 2;

else % BIP

    [A cc1 cc2 n] = konect_connect_matrix_bipartite(A); 
    L = konect_matrix('lap', A, format, weights, opts); 
    m = nnz(A); 

end

opts.tol = tol

%%lambda_n = normest(L)
lambda_n = eigs(L, 1, 'lm', opts)
%%if lambda_n == 0
%%    dd = load_eig()
%%    lambda_n= dd(1)
%%end

L_m = lambda_n * speye(size(L,1)) - L;
opts.tol = tol / lambda_n
%%lambda_n_minus_1 = normest(L_m, tol_2)
lambda_n_minus_1 = eigs(L_m, 1, 'lm', opts)
%%if lambda_n_minus_1 == 0
%%    dd = load_eig()
%%    lambda_n_minus_1= dd(1)
%%end

conflict = lambda_n - lambda_n_minus_1

if conflict < 0
  % This is an error
  error('*** [conflict] must not be negative'); 
end

values = [ ...
    conflict, ...
    (conflict * n / 8 / m)
         ]'; 
