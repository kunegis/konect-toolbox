%
% The number of triangles in a graph.
%
% The computed number of triangles is independent of the orientation
% of edges.  The multiplicity of edges is ignored.  Loops in 
% graph are ignored. 
%
% PARAMETERS 
%	A	Adjacency matrix
%	format
%	weights
%	opts	(optional)
%
% RESULT 
%	values 	Columns vector of results
%		[1] Number of triangles
%
% ATTRIBUTE:  square 
%

function values = konect_statistic_triangles(A, format, weights, opts)

% Size in double variables of the largest number of doubles that is to
% be used as temporary memory.  Used in the calculation of the default
% value of SIZE_CHUNK.  
size_resident = 1e7; 

consts = konect_consts(); 

if format == consts.BIP
    error '*** Number of triangles is trivially zero for bipartite networks'; 
end

n = size(A, 1); 

A = konect_absx(A);
A = A | A'; 

% Necessary to make matrix multiplication work, because matrix
% multiplication does not work with logical matrices. 
A = double(A); 

% Set diagonal elements to zero, to exclude triangles that contain
% loops. 
A = A - spdiags(diag(A), [0], n, n); 

% Count all triangles as the sum of the diagonal entries of A^3.
% This will count each triangle six times (3!). 
count_total = 0; 

size_chunk = floor(size_resident / n); 
if size_chunk < 1, size_chunk = 1; end; 

[k from to] = konect_fromto(1, n, size_chunk);

t = konect_timer(n); 

for j = 1 : k

    t = konect_timer_tick(t, to(j)); 

    count_j = sum(sum(A(:,from(j):to(j)) .* (A * A(:,from(j):to(j))), 1), 2); 
    count_total = count_total + count_j;

end

konect_timer_end(t); 

count_reduced = count_total / 6; 

if count_reduced ~= floor(count_reduced)
    error '*** count not a multiple of 6';
end

values = count_reduced; 
