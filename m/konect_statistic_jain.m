%
% Compute Jain's fairness index [jain] [740].
%
% PARAMETERS 
%	a	Adjacency/biadjacency matrix
%	format
%	weights
%
% RESULT 
%	values	Column vector of results.  
%		[1] 	Global value
%		[2]	Left value (BIP)
%		[2]	Outdegree value (ASYM)
%		[3]	Right value (BIP)
%		[3]	Indegree value (ASYM)
%

function values = konect_statistic_jain(A, format, weights)

consts = konect_consts(); 

A = A ~= 0; 

d1 = sum(A,2);
d2 = sum(A,1)'; 

if format == consts.BIP
    values = [ konect_jain([d1 ; d2]); konect_jain(d1); konect_jain(d2)]; 
elseif format == consts.SYM
    values = konect_jain(d1 + d2); 
elseif format == consts.ASYM
    values = [ konect_jain(d1 + d2); konect_jain(d1); konect_jain(d2)]; 
end

values = full(values);
