%
% Compute the degree distribution entropy [dentropy2].
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

function values = konect_statistic_dentropy2(a, format, weights)

consts = konect_consts(); 

a = a ~= 0; 

d1 = sum(a,2);
d2 = sum(a,1)'; 

if format == consts.BIP
    values = [ konect_dentropy2([d1 ; d2]); konect_dentropy2(d1); konect_dentropy2(d2)]; 
elseif format == consts.SYM
    values = konect_dentropy2(d1 + d2); 
elseif format == consts.ASYM
    values = [ konect_dentropy2(d1 + d2); konect_dentropy2(d1); konect_dentropy2(d2)]; 
end

