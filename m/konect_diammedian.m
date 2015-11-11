%
% Compute the median distance using the (0-based) vector d.
%
% PARAMETERS 
%	d	(1*(diameter+1)) Vector d 
%	n	Number of nodes
%
% RESULT 
%	ret	The median distance
%

function ret = konect_diammedian(d, n)

assert(size(d,1) == 1); 

ret = floor(konect_diameff(d, 0.5)); 

