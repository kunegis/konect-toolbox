%
% Find biggest connected component of bipartite graph.
%
% RESULT 
%	v	0/1 vector of left nodes in connected component
%	w	0/1 vector of right nodes in conneced component
%
%	Returns v=[] and w=[] when no largest component is found 
%	
% PARAMETERS 
%	B	Biadjacency matrix of bipartite graph (i.e., 
% 		[0 B;B' 0] is the actual adjacency matrix.)
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function [v, w] = konect_connect_bipartite(B)

if ~konect_usingoctave()

[m n] = size(B);

A = [sparse(m,m) B ; B' sparse(n,n)];

[ci sizes] = components(A, 'full2sparse', 1);

[x i] = sort(-sizes);

v = (ci(1:m) == i(1));
w = (ci((m+1) : (m+n)) == i(1)); 

else

    [v, w] = konect_connect_bipartite_nobgl(B); 
    
end