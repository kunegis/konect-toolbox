%
% Determine whether a given graph contains at least one triangle.  This
% function uses the same algorithm and implementation as
% konect_statistic_triangles(), but aborts on finding the first
% triangle.  Refer to that function for documentation.
%
% This function uses a timer in the same way as
% konect_statistic_triangles(), whose iteration is aborted as soon as a
% triangle is found. 
%
% PARAMETERS 
%	A	Adjacency matrix
%	format
%	weights
%
% RESULT 
%	ret	(0/1) Whether the given graph contains at least one triangle
%

function ret = konect_contains_triangle(A, format, weights)

% Size in double variables of the largest number of doubles that is to
% be used as temporary memory.  Used in the calculation of the default
% value of SIZE_CHUNK.  
size_resident = 1e7; 

consts = konect_consts(); 

if ~(format == consts.SYM | format == consts.ASYM)
  ret = 0;
  error('*** Expected graph to be unipartite'); 
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

size_chunk = floor(size_resident / n); 
if size_chunk < 1, size_chunk = 1; end; 

[k from to] = konect_fromto(1, n, size_chunk);

t = konect_timer(n); 

ret = 0; 

for j = 1 : k

    t = konect_timer_tick(t, to(j)); 

    count_j = sum(sum(A(:,from(j):to(j)) .* (A * A(:,from(j):to(j))), 1), 2); 

    if count_j ~= 0
      ret = 1;
      return; 
    end
end

konect_timer_end(t); 
