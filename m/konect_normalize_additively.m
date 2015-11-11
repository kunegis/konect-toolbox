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
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function T = konect_normalize_additively(T, means)

if size(means.U)
    T(:,3) = T(:,3) - means.U(T(:,1)) - means.V(T(:,2)); 
end
