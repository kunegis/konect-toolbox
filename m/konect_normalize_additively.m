%
% Normalize a dataset additively, given row and column means. 
%
% PARAMETERS 
%	T	(r*3) Data matrix
%	means	Normalization parameters or []
%
% RESULT 
%	T	(r*3) Updated data matrix
%

function T = konect_normalize_additively(T, means)

if size(means.U)
    T(:,3) = T(:,3) - means.U(T(:,1)) - means.V(T(:,2)); 
end
