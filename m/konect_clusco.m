%
% Compute the local and global clustering coefficients, and at the
% same time the local clustering coefficients for all nodes. 
%
% Note: to compute just the global clustering coefficient, it is
% faster to use the expression
%
%     c = 3t / s.
%
% which expresses the global clustering coefficient c in terms of the
% number of triangles t and the number of wedges s. 
%
% Loops are ignored.  If A not symmetric, the directed clustering
% coefficient is computed.  If A contains negative values, the signed
% clustering coefficient is computed. 
%
% PARAMETERS 
%	A 	(n*n) Adjacency matrix; must be square; must be a 0/1
%		matrix for the usual (unsigned) clustering
%		coefficient, or -1/0/+1 for the signed clustering
%		coefficient  
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

function [c_local, c_global_1, c_global_2] = konect_clusco(A)

assert(size(A, 1) == size(A, 2)); 

n = size(A, 1); 

% Check that the matrix is a -1/0/+1 matrix 
[x y z] = find(A);
if sum(abs(z) ~= 1) > 0
    error('*** A must be a -1/0/+1 matrix'); 
end

% Remove diagonal elements
z(x == y) = 0;
A = sparse(x, y, z, n, n); 

sum_pairs = 0;
sum_count = 0;

c_local = zeros(n, 1);

t = konect_timer(n); 

for u = 1:n

    t = konect_timer_tick(t, u); 

    % Vectors of neighbors 
    ao = A(u, :)';
    ai = A(:, u);

    % Indexes of positive and negative neighbors 
    nebs_op = find(ao > 0);
    nebs_on = find(ao < 0);
    nebs_ip = find(ai > 0);
    nebs_in = find(ai < 0);

    % Submatrices of relationships between neighbors 
    A_pp = A(nebs_ip, nebs_op);
    A_pn = A(nebs_ip, nebs_on);
    A_np = A(nebs_in, nebs_op);
    A_nn = A(nebs_in, nebs_on);

    % Number of edges among neighbors 
    user_count = full(sum(sum(A_pp)) - sum(sum(A_pn)) - sum(sum(A_np)) + sum(sum(A_nn)));
    
    % Number of possible neighbor pairs 
    user_pairs = full((length(nebs_ip) + length(nebs_in)) * (length(nebs_op) + length(nebs_on)) ...
                      - sum((ai ~= 0) & (ao ~= 0)));

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
