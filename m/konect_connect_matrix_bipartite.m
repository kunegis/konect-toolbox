%
% Extract the largest connected component from a biadjacency matrix.
% The original matrix can be recovered using konect_connect_back(). 
%
% RESULT 
%	Bs		(nx1*nx2) Biadjacency matrix of largest connected component
%	cc1, cc2	(nx1, nx2) 0/1 vector of chosen left/right subset
%	n		Number of nodes in the found component (n = n1 + n2)
%	n1		Number of left nodes in the found component
%	n2		Number of right nodes in the found component 
%
% PARAMETERS 
%	B		(n1*n2) Biadjacency matrix
%

function [Bs cc1 cc2 n n1 n2] = konect_connect_matrix_bipartite(B)

[cc1 cc2] = konect_connect_bipartite(B);

Bs = B(cc1, cc2); 

[n1 n2] = size(Bs); 
n = n1 + n2;
