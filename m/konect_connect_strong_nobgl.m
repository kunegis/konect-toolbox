%
% Find the (or one) largest strongly connected component of a
% directed graph.  The resulting component contains at least one
% node, and at most all nodes. 
%
% PARAMETERS 
%	A	(n*n) Square asymmetric adjacency matrix
%
% RESULT 
%	v	(n*1) 0/1 vector of vertices in the found largest
%		strongly connected component 
%

function [v] = konect_connect_strong_nobgl(A)

[n, nx] = size(A);
assert(n == nx); 
assert(n >= 1); 

fprintf(1, 'konect_connect_strong_nobgl()  n = %u, m = %u\n', ...
        n, nnz(A)); 

%
% Algorithm:  
%   * Pick a node i at random 
%   * Find all nodes reachable from i AND from which i is reachable,
%     this represents the connected component containing i. 
%   * Iterate until the largest strongly component is found
%   * At each step, remove from the matrix A the edges that have
%     already been visited
%

A = logical(A ~= 0); 

v_best = zeros(n, 1);
v_best_size = 0; 

% 
% First, remove all nodes that don't have in-edges AND out-edges.
% Such nodes all make up strongly components of size one.
%

i = (sum(A,2) == 0) | (sum(A,1)' == 0); 
if nnz(i) > 0
    fprintf(1, 'Removing %u nodes without in- AND out-edges\n', nnz(i));
    i = find(i);
    v_best(i(1)) = 1;
    v_best_size = 1;
    A(i,:) = 0; 
    A(:,i) = 0;
end

while 1

    if nnz(A) == 0
        assert(v_best_size >= 1);
        break;
    end

    %
    % Pick a node i that has the most neighbours 
    %
    [xx ii] = sort(sum(A, 2) + sum(A, 1)', 'descend'); 
    n_remaining = nnz(xx); 
    i = ii(1); 
    assert(sum(A(i,:)) + sum(A(:,i)) > 0); 
    fprintf(1, 'i = %u   (%u nodes remaining, %u edges remaining)\n', ...
            i, n_remaining, nnz(A) / 2); 

    %
    % Find all nodes reachable from i
    %
    v_from = zeros(n,1); 
    v_from(i) = 1; 
    k = 1; 
    while 1
        v_from = v_from | logical(A' * v_from); 
        k_new = sum(v_from); 
        fprintf(1, '  ->%d\n', k_new); 
        if k_new == k, break; end; 
        k = k_new; 
    end

    % Find all nodes from which i is reachable
    v_to = zeros(n,1); 
    v_to(i) = 1; 
    k = 1; 
    while 1
        v_to = v_to | logical(A * double(v_to)); 
        k_new = sum(v_to); 
        fprintf(1, '  <-%d\n', k_new); 
        if k_new == k, break; end; 
        k = k_new; 
    end

    %
    % The intersection is the found strongly connected component.  It
    % contains at least i. 
    %
    v = v_from & v_to; 
    v_size = sum(v); 
    fprintf(1, '  v_size = %u (v_best_size = %u)\n', v_size, v_best_size); 
    assert(v(i) == 1);
    assert(sum(v) >= 1); 

    if v_size > v_best_size
        v_best = v; 
        v_best_size = v_size;
    end

    % Cannot get bigger than this
    if v_best_size > n_remaining, break; end; 

    %
    % Remove all edges in the found strongly connected component from
    % A 
    %
    A(v, :) = 0;
    A(:, v) = 0;

end

v = v_best; 
