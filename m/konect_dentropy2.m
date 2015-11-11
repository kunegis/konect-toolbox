%
% Compute the degree distribution entropy [dentropy2]. 
%
% RESULT 
%	ret	The degree distribution entropy in nats 
%
% PARAMETERS 
%	d	Column vector of degrees
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function ret = konect_dentropy2(d)

[counts ids] = sort(full(d)); 
maxcount = counts(end); 
freq = histc(counts, 0 : maxcount);

% freq(1) is always zero -- this is no problem.

ret = konect_dentropy(freq); 
