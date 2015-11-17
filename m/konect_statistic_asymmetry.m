%
% Compute the spectral asymmetry, i.e. the smallest eigenvalue of the
% Hermitian Laplacian.  This is computed for the largest weakly
% connected component. 
%
% PARAMETERS 
%	A	Adjacency matrix of a directed graph
%	format
%	weights
%
% RESULT 
%	value	The algebraic asymmetry
%

function value = konect_statistic_asymmetry(A, format, weights)

opts.disp = 2; 

A = konect_connect_matrix_square(A); 

L = konect_matrix('lapherm', A, format, weights);

[U D] = konect_eigl(L, 1, opts); 

value = real(D(1,1));

