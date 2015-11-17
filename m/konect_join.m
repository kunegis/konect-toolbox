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

function T = konect_join(T)

A = konect_spconvert(T);
[x y z] = find(A);

T = [x y z]; 
