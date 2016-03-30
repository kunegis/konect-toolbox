%
% Find the largest strongly connected component of a directed graph. 
%
% PARAMETERS 
%	a	(n×n) Square asymmetric adjacency matrix
%
% RESULT 
%	v	(n×1) 0/1 vector of vertices in the connected component
%

function [v] = konect_connect_strong_nobgl(a)

[n,nx] = size(a);

a = logical(a ~= 0); 

count = 0; 
count_max = 100; 

v_best = [];
v_best_size = 0; 

while count < count_max
    count = count + 1; 

    fprintf(1, '[%d]\n', count); 

    % Find an edge i->j
    i = 1+floor(rand * n); 
    ai = a(i,:); 
    if sum(ai) == 0, continue; end;
    js = find(ai);
    j = js(1 + floor(rand * size(js,2))); 
  
    % Find all nodes reachable from j
    u = zeros(n,1); 
    u(j) = 1; 
    k = 1; 
    while 1
        u = u | logical(a' * u); 
        k_new = sum(u); 
        fprintf(1, '  ->%d\n', k_new); 
        if k_new == k, break; end; 
        k = k_new; 
    end

    % Find all nodes from which i is reachable
    w = zeros(n,1); 
    w(i) = 1; 
    k = 1; 
    while 1
        w = w | logical(a * double(w)); 
        k_new = sum(w); 
        fprintf(1, '  <-%d\n', k_new); 
        if k_new == k, break; end; 
        k = k_new; 
    end

    % The intersection is part of the component
    v = u & w; 
    
    fprintf(1, '  size = %d\n', sum(v)); 

    v_size = sum(v); 
    if v_size > v_best_size
        v_best = v; 
    end

    % Cannot get bigger than this
    if v_size > .5 * n, break; end; 
end

v = v_best; 

% The algorithm is imprecise, so if no component is found, just
% return a single node as a component. 
if sum(v) == 0
    v(1) = 1;
end

% TODO eleminate impossible edges from the network continuously so
% that the algorithm converges. 