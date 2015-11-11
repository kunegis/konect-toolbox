%
% Find the largest weakly connected component of a unipartite graph.
% Edge weights are ignored.  Edge directions are ignored. 
%
% This implementation uses BGL. 
%
% PARAMETERS 
%	A	(n*n) Half-adjacency matrix of unipartite graph
%
% RESULT 
%	v	0/1 vector of nodes in the connected component or
%		[] when there is no large connected component
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function [v] = konect_connect_square(A)

if ~konect_usingoctave()

    [n,nx] = size(A);
    if n ~= nx, error '*** Matrix must be square'; end; 

    % Symmetric adjacency matrix.  The input matrix to BGL must be symmetric. 
    A = (A ~= 0); 
    A = A | A';
    A = A - spdiags(diag(A), [0], n, n); 

    [ci sizes] = components(A, 'full2sparse', 1); 

    [x i] = sort(-sizes);

    v = (ci == i(1)); 

else 

    v = konect_connect_square_nobgl(A); 

end
