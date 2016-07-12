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

%%count = 0; 
%%count_max = 100; 

%%v_visited= zeros(n, 1); 
v_best = zeros(n, 1);
v_best_size = 0; 

while 1
%%while count < count_max

%%    count = count + 1; 

%%    fprintf(1, '[%d]\n', count); 

%%    assert(nnz(A) > 0); 
    if nnz(A) == 0
        assert(v_best_size >= 1);
        break;
%%        v_best= zeros(n, 1);
%%        v_best(1)= 1;
%%        v_best_size= 1; 
%%        break;
    end

    %
    % Pick a node i that has neighbors
    %
    [x] = find(sum(A, 2));
    i = x(1);
%%    [y] = find(A(i,:));
%%    j = y(1);
    fprintf(1, 'i = %u\n', i); 

    %%    i = 1+floor(rand * n); 
    %%    Ai = A(i,:); 
    %%    if sum(Ai) == 0, continue; end;
    %%    js = find(Ai);
    %%    j = js(1 + floor(rand * size(js,2))); 

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
        
        % Cannot get bigger than this
        if v_size > .5 * n, break; end; 
    end

    %
    % Remove all edges in the found strongly connected component from
    % A 
    %

    A(v, :) = 0;
    A(:, v) = 0;

end

v = v_best; 

