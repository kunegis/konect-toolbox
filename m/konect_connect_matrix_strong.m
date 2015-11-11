%
% Extract the largest strongly connected component from an adjacency
% matrix.  The original matrix can be recovered using konect_connect_back(). 
%
% RESULT 
%	As	Adjacency matrix of largest strongly connected component
%	cc	0/1 vector of chosen vertices
%	n	Number of vertices in the found component
%
% PARAMETERS 
%	A	Adjacency matrix
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function [As cc n] = konect_connect_matrix_strong(A)

cc = konect_connect_strong(A);

f = find(cc); 

As = A(f, f);

n = size(As, 1);
