%
% Split a large range of numbers into chunks.  Used when using
% vector/matrix operations on the whole data would use too much memory.
%
% PARAMETERS 
%	a	First index in desired range
%	b	Last index in desired range
%	n	Size of one block 
%
% RESULT 
%	k	Number of chunks
%	from	(k) Indexes of first item in each chunk
%	to	(k) Indexes of last item in each chunk 
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function [k from to] = konect_fromto(a, b, n)

from = a:n:b;
to = [(from(2:end)-1) b];

k = size(from,2); 

