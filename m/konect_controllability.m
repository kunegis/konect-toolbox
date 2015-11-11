%
% Compute the controllability of a given graph, as defined in:
%
% [1] Controllability of Complex Networks, Liu Y.-Y., J.-J. Slotine and
%     A.-L. Barabasi, Nature 473:167--173, May 2011. 
%
% PARAMETERS 
%	A 	Adjacency or biadjacency matrix (depending on FORMAT); weights are ignored 
%	format	The format of the network, as defined in konect_consts.m 
%
% RESULT 
%	ret	The maximal directed matching, i.e., the number of nodes
%		in the network minus the controllability value (|V| - C)
%
% LIBRARIES 
%	BGL 	This function uses BGL
% 
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function ret = konect_controllability(A, format)

consts = konect_consts(); 

% Set A to the actual adjacency matrix 
if format == consts.BIP
    [m n] = size(A); 
    A = [ sparse(m,m) , A ; A' , sparse(n,n) ]; 
elseif format == consts.SYM
    A = A + A';
end

[n x] = size(A); 

% Create the bipartite double cover 
B = [ sparse(n,n) , A ; A' , sparse(n,n) ]; 

mm = maximal_matching(B); 
ret = sum(mm > 0) / 2;



