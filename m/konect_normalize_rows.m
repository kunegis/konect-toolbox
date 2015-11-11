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
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function [U] = konect_normalize_rows(U)

[n r] = size(U); 

w = sum(conj(U) .* U, 2) .^ -0.5;

w(isinf(w)) = 0;

U = spdiags(w, [0], n, n) * U;

