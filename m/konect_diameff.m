% 
% Compute the effective diameter from the (0-based) hop plot array. 
%
% RESULT 
%	value	Effective diameter
%
% PARAMETERS 
%	d	(1*(diameter+1)) Hop distribution vector, as returned
%		by konect_hopdistr(). 
%	p	(optional) Percentile (e.g., 0.9 for 90-percentile);
%		defaults to 0.9; pass 0.5 and use floor() on the
%		result to get the median path length
%	

function [value] = konect_diameff(d, p)

assert(length(p) == 1); 

d
p

if ~exist('p', 'var')
    p = 0.9;
end

if size(d,2) == 1
    d = d';
end

amount = p * d(end)

value = NaN

for i = 1 : length(d)-1
    i
    if d(i) <= amount & d(i+1) > amount
        value = i - 1 + (amount - d(i)) / (d(i+1) - d(i))
        break;
    end
end

if isnan(value)
    value = length(d)
end

assert(length(value) == 1);
