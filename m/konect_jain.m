%
% Compute Jain's fairness index.
%
% RESULT 
%	value		Jain's fairness index
%
% PARAMETERS 
%	x		Vector of values
%

function [value] = konect_jain(x)

value = sum(x)^2 / length(x) / sum(x .^ 2); 
