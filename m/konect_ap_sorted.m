%
% Compute the average precision, given only the 0/1 vector sorted by
% scores, which don't have to be given. 
%
% PARAMETERS 
%	t	(e*1) The 0/1 vector, ranked by descending scores
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function ap = konect_ap_sorted(t)

ap = mean((1:sum(t))' ./ find(t)); 
