%
% Compute the Gini coefficient and coordinates of the Lorenz curve.  
%
% RESULT 
%	gini	The Gini coefficient
%	r_x	X values of Lorenz plot
%	r_y	Y values of Lorenz plot
%
% PARAMETERS 
%	v	Array of values, e.g. degree values 
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function [gini r_x r_y] = konect_gini_direct(v)

if size(v, 1) < size(v, 2)
    v = v'; 
end

v = sort(v); 

n = length(v); 

s = cumsum(v) / sum(v); 

r_x = (0:n)' / n; 
r_y = [ 0 ;  s ]; 

gini = 1 - (2 * sum(s) - 1) / n; 

% Prune r_x and r_y 
m = length(r_x); 
m_max = 200; 
if m > m_max
    indexes = floor(1:((m-1)/m_max):m);
    indexes(end) = m; 
    r_x = r_x(indexes);
    r_y = r_y(indexes); 
end
