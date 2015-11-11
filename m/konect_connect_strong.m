%
% Find the largest strongly connected component of a directed
% graph.  Edge weights are ignored. 
%
% PARAMETERS 
%	A	(n*n) Square asymmetric adjacency matrix
%
% RESULT 
%	cc	(n*1) 0/1 vector of vertices in the connected component
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function [cc] = konect_connect_strong(A)

if ~konect_usingoctave()

    A = (A ~= 0); 

    [ci sizes] = components(A, 'full2sparse', 1);

    [x i] = sort(sizes);

    cc = zeros(size(A,1), 1);
    cc(find(ci == i(end))) = 1;

else

    cc = konect_connect_strong_nobgl(A); 
    
end