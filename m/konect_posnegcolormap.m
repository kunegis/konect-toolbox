%
% From a matrix of numbers to be displayed using imagesc(), generate
% a colormap such that white=0, green>0 and red<0. 
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function [colormap_a] = konect_posnegcolormap(matrix)

gam = 2; 

granularity = 0.01; 

p_min = min(min(matrix))
p_max = max(max(matrix))

to_one = max(-p_min, p_max)
p_min = p_min / to_one
p_max = p_max / to_one

colormap_a = [ ...
    (-(p_min:granularity:0))' .^ gam * [0 -1 -1] + ones(length(p_min:granularity:0),1) * [1 1 1]; 
    (granularity:granularity:p_max)'.^ gam * [-1 0 -1] + ones(length(granularity:granularity:p_max),1) * [1 1 1] ...
]



