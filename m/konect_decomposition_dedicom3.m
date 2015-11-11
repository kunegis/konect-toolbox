%
% Implementation of the method from
%
% [1] A Generalization of Takane's Algorithm for DEDICOM, Henk A. L. Kiers,
%     Jos M. F. Ten Berge, Yoshio Takane, Jan de Leeuw, Psychometrika, 55,
%     151-158, 1990. 
%
% PARAMETERS 
%	A	(n*n) Adjacency matrix of directed graph
%	r	Rank of the decomposition
%	enable_alpha	(0/1) whether to enable to alpha term.  When
%		enabled, the algorithm is slower but has better convergence
%		behavior. 
%	opts	Passed to eigs()/svds()
%
% RESULT 
%	U	(n*r) Eigenvector matrix
%	D	(r*r) Nondiagonal and asymmetric eigenvalue matrix 
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function [U D] = konect_decomposition_dedicom3(A, r, enable_alpha, opts)

epsilon = 1e-7; 
maxit = 200; 

n = size(A,1); 

% Iteratively, update U and X in the decomposition.  U is always kept
% orthogonal. 

[U dx v] = svds(double(A), r, 'L', opts); 

if enable_alpha
    norm_a = dx(1,1);
end

D = zeros(r,r); 

for i = 1:maxit
    d_old = D;
    D = U' * A * U;
    
    if enable_alpha
        alpha = abs(norm_a * norm(D));
        U = (A * U) * (U' * A' * U) + (A' * U) * (U' * A * U) + 2 * alpha * U;         
    else
        U = (A * U) * (U' * A' * U) + (A' * U) * (U' * A * U); 
    end

    [U rr] = qr(U, 0);

    if rem(i,10) == 0
        dif = norm(D - d_old, 'fro')^2 / prod(size(D)); 
        fprintf(1, 'iteration %d dif= %g\n', i, dif); 
        if dif < epsilon, break; end; 
    end
end

[U D] = konect_order_dedicom(U, D); 
