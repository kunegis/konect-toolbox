%
% Same as konect_clusco() but, do not support negative edges and
% directed graphs, and therefore be faster.  The difference when
% calling it is that A can be the half-adjacency matrix in this
% function. 
%
% PARAMETERS 
%	A 	(n*n) Half-adjacency matrix; must be a square 0/1
%		matrix 
%
% RESULT 
%	c_local		(n*1) Node vector giving the local clustering
%			coefficient of each node; the value is zero
%			when the degree of a node is zero or one 
%	c_global_1	Global clustering coefficient (varant 1),
%			defined as the probability that two incident
%			edges are completed by a third edge to form a
%			triangle; this is the default clustering
%			coefficient in KONECT
%	c_global_2	Global clustering coefficient (variant 2),
%			defined as the average local clustering
%			coefficient; usually not used in KONECT 
%

function [c_local, c_global_1, c_global_2] = konect_clusco_simple(A)

assert(size(A, 1) == size(A, 2)); 

n = size(A, 1); 

% Check that the matrix is a -1/0/+1 matrix 
[x y z] = find(A);
if sum(z ~= 1) > 0
    error('*** A must be a 0/+1 matrix'); 
end

% Remove diagonal elements
z(x == y) = 0;
A = sparse(x, y, z, n, n); 
A = A + A';
A = (A ~= 0); 
% A is now the full adjacency matrix 

sum_pairs = 0;
sum_count = 0;

c_local = zeros(n, 1);

t = konect_timer(n); 

for u = 1 : n

    t = konect_timer_tick(t, u); 

    % Vectors of neighbors 
    a = A(:, u);

    % Indexes of neighbors 
    nebs = find(a > 0);

    % Submatrices of relationships between neighbors 
    A_sub = A(nebs, nebs);

    % Number of edges among neighbors, double counted 
    user_count = nnz(A_sub);
    
    % Number of possible neighbor pairs, double counted 
    user_pairs = nnz(a) * (nnz(a) - 1);
    % user_pairs = full((length(nebs_ip) + length(nebs_in)) * (length(nebs_op) + length(nebs_on)) ...
    %                   - sum((ai ~= 0) & (ao ~= 0)));

    sum_count = sum_count + user_count;
    sum_pairs = sum_pairs + user_pairs;

    if user_pairs ~= 0
        c_u = user_count / user_pairs; 
        c_local(u) = c_u; 
        if abs(c_u) > 1
            A_pp
            A_pn
            A_np
            A_nn
            nebs_op
            nebs_on
            nebs_ip
            nebs_in
            error(sprintf('*** c_u = %f, u = %d, user_count = %d, user_pairs = %d, [%d %d %d %d]', ...
                          c_u, u, user_count, user_pairs, ...
                          length(nebs_op), length(nebs_on), length(nebs_ip), length(nebs_in))); 
        end
    end;

end;

konect_timer_end(t); 

c_global_1 = sum_count / sum_pairs;
c_global_2 = mean(c_local); 

if abs(c_global_1) > 1
    error(sprintf('*** c_global_1 = %f', c_global_1)); 
end

if abs(c_global_2) > 1
    error(sprintf('*** c_global_2 = %f', c_global_2)); 
end
