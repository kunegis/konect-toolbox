%
% Compute the estimated effective diameter [diameter].  Exact values
% of the diameter and effective diameter are computed from the hop
% distribution. 
%
% RESULT 
%	value	Diameter
%
% PARAMETERS 
% 	A 	Adjacency or biadjacency matrix
%	format
%	weights
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function value = konect_statistic_diameter(A, format, weights)

consts = konect_consts(); 

if format ~= consts.BIP
    A = A + A';
end

value = konect_effective_diameter(A);
