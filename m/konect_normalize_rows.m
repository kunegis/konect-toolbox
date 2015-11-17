%
% Normalize the rows of a decomposition multiplicatively, such that each
% row of U and V has norm 1.  This is typically used with Laplacian
% matrices.  For a full orthogonal decomposition, this is a no-op. 
%
% PARAMETERS 
%	U	(n*r) Matrix of eigenvectors
%
% RESULT 
%	U 	(n*r) Normalized matrix
%

function [U] = konect_normalize_rows(U)

[n r] = size(U); 

w = sum(conj(U) .* U, 2) .^ -0.5;

w(isinf(w)) = 0;

U = spdiags(w, [0], n, n) * U;

