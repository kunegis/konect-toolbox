%
% Compute the controllability [controllability].
%
% PARAMETERS 
%	A	Adjacency / biadjacency matrix
%	format	
%	weights
%
% RESULT 
%	values	The values as a column vector
%		[1] The controllability (C)
%		[2] The relative controllability (C / |V|)
%

function values = konect_statistic_controllability(A, format, weights)

consts = konect_consts(); 

A = A ~= 0;

max_dir_matching = konect_controllability(A, format);

% Number of nodes |V|, not counting isolated nodes
if format == consts.BIP
    n = sum(sum(A, 2) ~= 0) + sum(sum(A, 1) ~= 0); 
else
    n = sum(sum(A | A', 2) ~= 0); 
end

values = [ 
    n - max_dir_matching;
    (n - max_dir_matching) / n
]

