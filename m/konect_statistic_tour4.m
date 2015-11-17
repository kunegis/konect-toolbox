%
% The number of 4-tours in a graph.  This is similar to the number
% of 4-cycles (squares), but allows nodes to overlap, and is
% therefore easier to compute.  The multiplicity of edges and loops
% are ignored. 
%
% PARAMETERS 
%	A	
%	format
%	weights
%	opts	(optional)
%
% RESULT 
%	values 	Columns vector of results
%		[1] Number of 4-tours
%

function values = konect_statistic_tour4(A, format, weights, opts)

% Size in double variables of the largest number of doubles that is to
% be used as temporary memory.  Used in the calculation of the default
% value of SIZE_CHUNK.  
size_resident = 1e7; 

consts = konect_consts(); 

if format == consts.BIP
    [n1 n2] = size(A); 
    A = [sparse(n1,n1), A; A', sparse(n2,n2)]; 
end

n = size(A, 1); 

A = konect_absx(A);
A = A | A'; 

% Necessary to make matrix multiplication work, because matrix
% multiplication does not work with logical matrices. 
A = double(A); 

% Set diagonal elements to zero to ignore loops 
A = A - spdiags(diag(A), [0], n, n); 

% Total number of 4-tours
count_total = 0; 

size_chunk = floor(size_resident / n); 
if size_chunk < 1, size_chunk = 1; end; 

[k from to] = konect_fromto(1, n, size_chunk);

t = konect_timer(n); 

for j = 1 : k

    t = konect_timer_tick(t, to(j)); 

    count_j = sum(sum(A(:,from(j):to(j)) .* (A * (A * A(:,from(j):to(j)))), 1), 2); 

    count_total = count_total + count_j; 

end

konect_timer_end(t); 

values = count_total;

assert(values >= 0);
assert(values == floor(values)); 
