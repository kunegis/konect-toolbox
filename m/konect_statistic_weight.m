%
% Compute the weight of a network, i.e., the sum of absolute edge
% weights.  For unweighted networks, this equals the volume. 
%
% PARAMETERS 
%	A
%	format
%	weights
%
% RESULT 
%	value	The weight value
%

function value = konect_statistic_weight(A, format, weights)

value = full(sum(sum(konect_absx(A)))); 

size_value = size(value) 
