%
% Code to compute the DEDICOM by Yoshio Takane.  Adapted to large sparse
% matrices by Jérôme Kunegis. 
%
% RESULT 
%	U	(n*r) "Eigenvectors" 
%	D	(r*r) Non-diagonal "eigenvalue" matrix 
%
% PARAMETERS 
%	A	(n*n) Square adjacency matrix
%	r	Rank 
%	opts	(optional) Passed to eigs() 
%

function [U D] = konect_decomposition_takane(A, r, opts)

itmax = 2000;
conv = 1e-8;

if ~exist('opts', 'var')
  opts = struct(); 
end

% Initial estimate
[u0 d0] = eigs(@(x)(A' * (A * x) + A * (A' * x)), size(A,1), r, 'lm', opts);

st = norm(double(A), 'fro') ^ 2;

U = u0;
au = A * U;
atu = A' * U;
D = U' * au;
so = norm(D, 'fro') ^ 2; 
i = 0;

G = au * D' + atu * D;
M2 = G - U * (U' * G); 
v = norm(M2, 'fro'); 

while i < itmax & conv < v
    i = i + 1;
    utemp = au * D' + atu * D;
    [un d2 v2] = svd(utemp, 'econ');
    au = A * un;
    atu = A' * un;
    D = un' * au;
    sn = norm(D, 'fro') ^ 2 / 2;

    G = au * D' + atu * D;
    M2 = G - U * (U' * G); 
    v = sqrt(norm(M2, 'fro')^2 / sum(size(M2))) ; 

    if mod(i, 20) == 0
        fprintf(1, '[%d] norm = %g\n', i, v); 
    end

    so = sn;
    U = un;
end

[U D] = konect_order_dedicom(U, D); 
