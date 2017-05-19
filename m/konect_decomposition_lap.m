%
% Compute the Laplacian decomposition of a network's largest
% connected component. 
%
% RESULT 
%	U	(m*r) Eigenvectors of the Laplacian matrix (only left
%		nodes when the graph is bipartite)
%	V	(n*r) Eigenvectors of the Laplacian matrix (only for
%		bipartite networks / right nodes; [] otherwise)
%	D	(r*r) Eigenvalues of the Laplacian matrix; nonnegative
%
% PARAMETERS 
%	A	(m*n) Adjacency or biadjacency matrix 
%	r	Rank of the decomposition 
%	format
%	weights 
%	opts	(optional) Passed to eigs()
%

function [U D V] = konect_decomposition_lap(A, r, format, weights, opts)

if ~exist('opts', 'var'),    
    opts = struct();     
end

consts = konect_consts(); 
[negative] = konect_data_weights();

if format ~= consts.BIP 
    [A cc n] = konect_connect_matrix_square(A);
    L = konect_matrix('lap', A, format, weights, opts); 
    r = min(r, size(A,1) - 1); 
    [U,D] = konect_eigl(L, r, opts);
    U = konect_connect_back(cc, U); 
    V = []; 
else % BIP
    [A cc1 cc2 n] = konect_connect_matrix_bipartite(A); 
    [m,n] = size(A); 
    L = konect_matrix('lap', A, format, weights, opts); 
    r = min([r (m-1) (n-1)]); 
    [uu,D] = konect_eigl(L, r, opts);
    U = uu(1:m, :);
    V = uu((m+1):(m+n), :);
    U = konect_connect_back(cc1, U);
    V = konect_connect_back(cc2, V); 
end

if ~negative(weights)
    % Numerically, eigs() may return values as high as 1e-15, although
    % we know it is exactly zero.  
    D(1,1) = 0; 
end

f = diag(D) < 0;
D(f,f) = 0; 

