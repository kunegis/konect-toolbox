%
% Compute the "patest" statistic. This equals
%
%    X = log(d_max) / log(|V|),
%
% where d_max is the maximal degree and |V| is the number of nodes.
%
% We compute it always for RIGHT distributions, since this is used in
% the Preferential Attachment paper. 
%
% PARAMETERS 
%	a	Adjacency matrix
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

function values = konect_statistic_patest(A, format, weights)

consts = konect_consts();

A = A ~= 0; 

if format == consts.SYM
    A = A + A';
end

n = size(A, 1)
d_max = max(sum(A,1)); 

values = [ (log(d_max) / log(n)) ]


values= full(values); 
