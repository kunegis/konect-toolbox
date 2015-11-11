%
% Compute the maximum degree [maxdegree]. 
%
% PARAMETERS 
%	A	Adjacency matrix
%	format	
%	weights
%
% RESULT 
%	values	Column vector of results
%		[1]	Max degree
%		[2]	Max outdegree (ASYM); max left degree (BIP)
%		[3]	Max indegree (ASYM); max right degree (BIP) 
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function values = konect_statistic_maxdegree(A, format, weights)

consts = konect_consts();

if weights ~= consts.POSITIVE
    A = A ~= 0; 
end

if format == consts.SYM

    values = [ max(sum(A,1) + sum(A,2)') ]

elseif format == consts.ASYM

    values = [ max(sum(A,1) + sum(A,2)') ]; 
    values = [ values ; max(sum(A,2)) ];
    values = [ values ; max(sum(A,1)) ]

else % format == consts.BIP

    values = [ max(max(sum(A,1)), max(sum(A,2))) ]; 
    values = [ values ; max(sum(A,2)) ];
    values = [ values ; max(sum(A,1)) ]

end

values = full(values); 
