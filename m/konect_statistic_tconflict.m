% GROUP:  squarenegative

function [value] = konect_statistic_tconflict(A, format, weights)

assert(size(A, 1) == size(A, 2)); 

n = size(A, 1); 

A = konect_signx(A+A'); 

% Remove diagonal elements
[x y z] = find(A);
z(x == y) = 0;
A = sparse(x, y, z, n, n); 

sum_neg = 0;
sum_tot = 0;

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

  % Number of negative triangles for that node
  user_neg = full(sum(sum(A_pn > 0)) + sum(sum(A_np > 0)) + sum(sum(A_pp < 0)) + sum(sum(A_nn < 0)));
    
  % Number of triangles
  user_tot = full(sum(sum(A_pn ~= 0)) + sum(sum(A_np ~= 0)) + sum(sum(A_pp ~= 0)) + sum(sum(A_nn ~= 0)));

  sum_neg = sum_neg + user_neg;
  sum_tot = sum_tot + user_tot;
end;

konect_timer_end(t); 

value = sum_neg / sum_tot;
