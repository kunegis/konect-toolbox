%
% Compute the entropy of a vector.  
%
% RESULT 
%	value	Entropy in nats 
%
% PARAMETERS 
%	values	Distribution values; nonnegative; need not sum to one 
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function value = konect_normalized_entropy(values)

values = values ./ sum(values); 
 
values_log = log(values);

value = sum(- values .* log(values));

