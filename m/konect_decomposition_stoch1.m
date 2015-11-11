%
% Compute the 'stoch1' decomposition of a network, i.e., the
% decomposition of the matrix D^-1 A, where A is the adjacency matrix
% of the network and D the diagonal degree matrix.  This corresponds
% to the matrix used for computation of PageRank
% ("Google matrix"), up to the teleportation term.  The dominant left
% eigenvector returned by this function is thus the PageRank
% vector. Instead of the teleportation factor, this function
% restricts the computation to the largest connected component of the
% bipartite double cover.  
%
% To get the PageRank without teleportation, call this function with
% r = 1. 
%
% PARAMETERS 
%	A	(m*n) Adjacency or biadjacency matrix 
%	r	Rank of the decomposition 
%	format  Format of network
%	weights Weights of network
%	opts	(optional) Passed to eigs()
%
% RESULT 
%	U	(m*r) Left eigenvectors of the matrix D^-1 A
%	D	(r*r) Eigenvalues of the matrix D^-1 A
%	V	(n*r) Right eigenvectors of the matrix D^-1 A
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function [U D V] = konect_decomposition_stoch1(A, r, format, weights, opts)

if ~exist('opts', 'var'),    
    opts = struct();     
end

consts = konect_consts(); 
[negative] = konect_data_weights();

if format == consts.BIP

    [A cc1 cc2 n] = konect_connect_matrix_bipartite(A); 

    [mm nn] = size(A); 

    A = konect_matrix('bip', A); 
    A = konect_matrix('stoch1', A, format, weights); 

    r = min([r (size(A,1)-2)]); 
        
    [uv D] = eigs(A, r, 'lr', opts);

    U = uv(1:mm, :);
    V = uv(mm+1:mm+nn, :); 

    U = konect_connect_back(cc1, U);
    V = konect_connect_back(cc2, V); 

else % SQUARE
        
    if format == consts.SYM
        [A cc n] = konect_connect_matrix_square(A); 
        A = A + A';  
    else
        [A cc n] = konect_connect_matrix_strong(A); 
    end

    if n <= 1
        U = zeros(n,r);
        V = zeros(n,r);
        D = zeros(r, r); 
    else
        [P] = konect_matrix('stoch1', A, format, weights, opts); 
        r = min(r, size(P,1)-2); 
        [U D] = eigs(P, r, 'lr', opts); 

        % Make the dominant left eigenvector be nonnegative
        if sum(U(:,1) < 0)
            U(:,1) = -U(:,1);
        end

        % Do V = pinv(U)' using the economic full SVD
        [uu dd vv] = svd(U, 'econ');  V = uu * pinv(dd) * vv'; 
        %        D = D'; % Not a no-op because the diagonal is complex 
        
    end

    U = konect_connect_back(cc, U); 
    V = konect_connect_back(cc, V); 

end

D = real(D);
dd = diag(D);
[dd ii] = sort(dd, 'descend');
D = D(ii,ii);
U = U(:,ii);
V = V(:,ii);

