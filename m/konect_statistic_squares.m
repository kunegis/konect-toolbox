%
% The number of squares in a graph.
%
% The computed number of squares is independent of the orientation
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
%		[1] Number of squares
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function values = konect_statistic_squares(A, format, weights, opts)

%
% Method:  count all squares including overlapping edges, and
% remove from it the number of two-stars and edges.  (See exact
% formula below.)  
%

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

% Set diagonal elements to zero. 
A = A - spdiags(diag(A), [0], n, n); 

% Count all squares, including the twostars and edges.  This is the
% total count of squares including squares including those where
% multiple nodes overlap (being in fact edges and two-stars), and
% counting each orientation separately. 
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

%
% How to get the actual number
%
% C:  total count of squares with overlap (count_total)
% q:  number of squares
% s:  number of two-stars
% m:  number of edges
%
% C = 8 q + 2 m + 4 s
%
% q = (C - 2 m - 4 s) / 8
%

d = sum(A,2); 

count_twostars_double = d' * (d-1); 

count_edges_double = nnz(A); 

values = (count_total - count_edges_double - 2 * count_twostars_double) / 8;

assert(values >= 0);
assert(values == floor(values)); 
