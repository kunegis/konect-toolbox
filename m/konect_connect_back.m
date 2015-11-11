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
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function [ret] = konect_connect_back(cc, U)

ret = zeros(size(cc, 1), size(U, 2));
ret(find(cc), :) = U; 
