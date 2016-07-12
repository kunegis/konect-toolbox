%
% Compute the sparse eigenvalue decomposition of a skew-symmetric
% matrix  B in real/Gower form. 
%
% Given a skew-symmetric matrix B, this computes U, D and V such that
%
% 	B = U D V' - V D U'
%
% where U and V are the real and complex parts of the eigenvectors of
% B, and D is diagonal, real and nonnegative.  Note that if B was
% constructed from a matrix A as B = A - A', then U D V' is in the
% general case *not* the singular value decomposition of A, and in
% fact not even a good approximation of it.  This method is faster
% than computing the actual eigenvalue decomposition of A - A'.  The
% columns of U and V are orthonormal.  The actual eigenvalue
% decomposition of B is given by 
%
%	B = Q L Q'
% 
% with
%
%	Q = [ U + iV ; U - iV ] / sqrt(2),
%	L = [ iD, 0 ; 0, -iD ].
%
% Another feature of that decomposition is that a rank of floor(n/2)
% is enough to decompose all matrices exactly.  I.e., when B has size
% n*n, then there is always a r <= floor(n/2) such that an exact
% decomposition exists in which U and V have size n*r and D has size
% r*r.    
% 
% RESULT 
%	U,D,V	The decomposition
%
% PARAMETERS 
%	B	(n*n) Real, square, skew-symmetric matrix to be
%		decomposed 
%	r	Rank; if more than floor(n/2), it is rounded to that
%		value, which is enough in all cases to recover the
%		complete matrix A
%	opts	(optional) Passed to eigs()
%

function [U D V] = konect_eigskew(B, r, opts)

if ~exist('opts', 'var')
    opts = struct();
end

r = min(r, floor(size(B,1) / 2)); 

% We need only the positive imaginary eigenvalues of B.  However, eigs()
% doesn't have an option to find them, so find the largest real
% eigenvalues of -iB.
[U D] = eigs(-1i * B, r, 'lr', opts);

% For each pair (+/- i lambda, u +/- iv), return (lambda, sqrt(2) u, sqrt(2) v)
U = U * sqrt(2); 
V = imag(U);
U = real(U);
D = real(D); 
