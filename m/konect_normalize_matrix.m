%
% Compute the matrix normalization.  Given a real rectangular matrix
% A, its normalization is 
%
%   D_u^-0.5 * A * D_v^-0.5
%
% with D_u and D_v and the left and right diagonal degree matrices
% defined by
%
%   D_u(i,i) = sum_{j = 1:m} | A(i,j) |
%   D_v(i,i) = sum_{j = 1:n} | A(j,i) |
%
% i.e., D_u and D_v contain the sum of absolute values of rows and
% columns. 
%
% This type of normalization is used to contruct many types of
% characteristic graph matrices, for instance the normalized
% adjacency matrix from the adjacency matrix. 
%
% The resulting matrix can be denormalized back (e.g., after
% additional changes to it) by using the output parameters T_u and
% T_v. 
%
% RESULT 
%	B	(m*n) The normalized matrix; sparse
%	T_u	(m*m) The matrix D_u^-0.5; sparse
%	T_v	(n*n) The matrix D_v^-0.5; sparse
%
% PARAMETERS 
%	A	(m*n) The non-normalized matrix; sparse
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function [B T_u T_v] = konect_normalize_matrix(A)

[m,n] = size(A); 
A_abs = konect_absx(A); 

T_u = sum(A_abs,2)  .^ -.5;
T_v = sum(A_abs,1)' .^ -.5;
T_u(T_u ~= T_u) = 1;
T_v(T_v ~= T_v) = 1;
T_u = spdiags(T_u, [0], m,m);
T_v = spdiags(T_v, [0], n,n); 

B = T_u * A * T_v;  

