%
% Compute the edge distribution entropy [dentropy].
%
% PARAMETERS 
%	a	Adjacency/biadjacency matrix
%	format
%	weights
%
% RESULT 
%	values	Column vector of results.  The first value is the global
%		entropy.  The next next ones are the left/right
%		entropies (only BIP and ASYM). 
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function values = konect_statistic_dentropy(a, format, weights)

consts = konect_consts(); 

a = a ~= 0; 

d1 = sum(a,2);
d2 = sum(a,1)'; 

if format == consts.BIP
    values = [ konect_dentropy([d1 ; d2]); konect_dentropy(d1); konect_dentropy(d2)]; 
elseif format == consts.SYM
    values = konect_dentropy(d1 + d2); 
elseif format == consts.ASYM
    values = [ konect_dentropy(d1 + d2); konect_dentropy(d1); konect_dentropy(d2)]; 
end

