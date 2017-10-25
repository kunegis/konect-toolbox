%
% Compute the size of the largest strongly connected component
% [cocos]. 
%
% PARAMETERS 
%	A	Adjacency matrix
%	format
%	weights
%
% RESULT 
%	values	Size of the largest connected component
%		[1] Size of largest strongly connected component, in
%		    nodes (N_s)
%		[2] Relative size (N_s / n)
%
% GROUP:  asym
%

function values = konect_statistic_cocos(A, format, weights)

consts = konect_consts(); 

if format ~= consts.ASYM
    error(['*** Strongly connected component is only defined for ' ...
           'directed networks']); 
end

n = size(A,1)

v = konect_connect_strong(A);

assert(sum(v ~= 0 & v ~= 1) == 0); 

value_1 = sum(v)

assert(value_1 >= 0);
assert(value_1 <= n); 

value_2 = value_1 / n

assert(value_2 <= 1.0); 

values = [ value_1; value_2 ]; 
