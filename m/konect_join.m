%
% Join lines of a r*(2 or 3) matrix with same first and second values.
%
% The result has the same number of columns as the input. 
%
% PARAMETERS 
%	T	(r*2 or r*3)	Sparse entries with duplicates
%
% RESULT 
%	T	(r*3) 		Sparse entries without duplicates
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function T = konect_join(T)

A = konect_spconvert(T);
[x y z] = find(A);

T = [x y z]; 
