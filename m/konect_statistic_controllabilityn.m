%
% Compute the relative controllability [controllabilityn].
%
% PARAMETERS 
%	A	Adjacency / biadjacency matrix
%	format	
%	weights
%
% RESULT 
%	values	The values as a column vector
%		[1] The relative controllability (C / |V|)
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function values = konect_statistic_controllabilityn(A, format, weights)

consts = konect_consts(); 

A = A ~= 0;

max_dir_matching = konect_controllability(A, format);

% Number of nodes |V|, not counting isolated nodes
if format == consts.BIP
    n = sum(sum(A, 2) ~= 0) + sum(sum(A, 1) ~= 0); 
else
    n = sum(sum(A | A', 2) ~= 0); 
end

values = [ (n - max_dir_matching) / n ]


