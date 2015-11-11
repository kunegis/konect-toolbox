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
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING.
%

function value = konect_statistic_weight(A, format, weights)

value = full(sum(sum(konect_absx(A)))); 

size_value = size(value) 
