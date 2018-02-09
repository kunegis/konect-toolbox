%
% Determine the number of loops in a network. 
%
% PARAMETERS 
%	A	Adjacency or biadjacency matrix
%	format
%	weights
%
% RESULT 
%	values	Column vector of values
%		[1]	Number of loops
%
% GROUP:  square 
%

function values = konect_statistic_loops(A, format, weights)

consts = konect_consts(); 
  
assert(format ~= consts.BIP); 
assert(size(A,1) == size(A,2)); 

if weights == consts.POSITIVE
  loops = trace(A); 
else
  loops = sum(diag(A) ~= 0); 
end

values(1) = loops;
