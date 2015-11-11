%
% Compute the Gini coefficient of a degree distribution, given index
% values. The second and third output parameters give the coordinates
% of points on the Lorenz curve.  The returned R_X and R_Y values are
% reduced to at most 200.    
%
% RESULT 
%	gini	The Gini coefficient
%	r_x	X values of Lorenz plot
%	r_y	Y values of Lorenz plot
%
% PARAMETERS 
%	p	(e*1) Index values, e.g. node IDs
%	q	(e*1) (optional, default = []) Multiplicities or []
%		for unweighted case, e.g. degree values 
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function [gini r_x r_y] = konect_gini(p, q)

if ~exist('q', 'var') | length(q) == 0
    q = 1; 
end

counts = full(sparse(full(p+1), 1, double(q), max(p) + 1, 1)); 

counts = counts(2:end); 

counts = counts(find(counts)); 

[gini r_x r_y] = konect_gini_direct(counts); 
