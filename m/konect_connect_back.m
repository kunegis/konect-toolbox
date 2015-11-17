%
% Maps a reduced matrix decomposition back to a full matrix
% decomposition.  Used in conjunction with konect_connect_matrix().  Nodes that
% were not in the subset get eigenvector entries of zero; this is
% compatible with all matrix decompositions. 
%
% PARAMETERS 
%	cc	0/1 vector denoting the extracted subset of vertices
%	U	Subset eigenvector matrix
%

function [ret] = konect_connect_back(cc, U)

ret = zeros(size(cc, 1), size(U, 2));
ret(find(cc), :) = U; 
