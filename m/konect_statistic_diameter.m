%
% Compute the estimated effective diameter [diameter].  
%
% This statistic (named "diameter") gives approximate values of the
% 90-percentile effective diamater.  The values are approximate because
% they use a heuristic, node sampling.  No estimate of the accuracy of
% the result is returned. 
% 
% To get exact values of the diameter and effective diameter, use the
% function konect_hopdistr() followed by a call to one of the
% konect_diam*() functions, which correspond to the statistics having
% names like "diam" (the diameter), "diameff90", etc. 
%
% RESULT 
%	value	Diameter
%
% PARAMETERS 
% 	A 	Adjacency or biadjacency matrix
%	format
%	weights
%

function value = konect_statistic_diameter(A, format, weights)

consts = konect_consts(); 

if format ~= consts.BIP
    A = A + A';
end

value = konect_effective_diameter(A);
