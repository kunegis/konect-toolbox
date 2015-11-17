%
% Compute the average precision, given only the 0/1 vector sorted by
% scores, which don't have to be given. 
%
% PARAMETERS 
%	t	(e*1) The 0/1 vector, ranked by descending scores
%

function ap = konect_ap_sorted(t)

ap = mean((1:sum(t))' ./ find(t)); 
