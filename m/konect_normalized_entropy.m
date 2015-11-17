%
% Compute the entropy of a vector.  
%
% RESULT 
%	value	Entropy in nats 
%
% PARAMETERS 
%	values	Distribution values; nonnegative; need not sum to one 
%

function value = konect_normalized_entropy(values)

values = values ./ sum(values); 
 
values_log = log(values);

value = sum(- values .* log(values));

