%
% Compute the approximate overall clustering coefficient of a
% network.  The network must not be bipartite.  Edge weights are
% ignored, except for their sign. Effectively, this will return the
% signed clustering coefficient.  Pass (A ~= 0) in this case to get
% the ordinary clustering coefficient.  
%
% PARAMETERS 
%	A 	Adjacency matrix; must be square; only the sign of
%		weights is used, not the magnitude.  
%	format	Network format
%	epsilon (optional) Precision
%
% RESULT 
%	clusco		Overall clustering coefficient
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function clusco = konect_clusco_approx(A, format, epsilon)

consts = konect_consts(); 
  
batch_size = 29; 

sum_pairs = 0;
sum_count = 0;

if ~exist('epsilon')
    epsilon = 0.0006; 
end

if format == consts.SYM
    A = A + A'; 
end

% Make diagonal zero
A = A - diag(diag(A)); 

if sum(abs(diag(A))) > 0
    error('*** A must be diagonal-free'); 
end

A = sign(A); 

% Remove zero lines and columns
a_abs = abs(A); 
degree_out = sum(a_abs,2);
degree_in  = sum(a_abs,1)';
ok = (degree_out > 0) & (degree_in > 0);
A = A(ok, ok); 

n = size(A, 1) 

iteration_count_max = n 
iteration_count_min = floor(0.0012 * n); 

fprintf(1, 'Clusco(%d)...\n', n); 

clusco_last = NaN; 

perm = randperm(n); 

for k = 1 : iteration_count_max

    i = perm(k); 

    ao = A(i, :)';  % Outlink vector
    ai = A(:, i);   % Inlink vector

    % Positive/negative out/in-neighbors  
    nebs_op = find(ao > 0); 
    nebs_on = find(ao < 0); 
    nebs_ip = find(ai > 0); 
    nebs_in = find(ai < 0); 

    a_pp = A(nebs_ip, nebs_op); 
    a_pn = A(nebs_ip, nebs_on);
    a_np = A(nebs_in, nebs_op);
    a_nn = A(nebs_in, nebs_on);

    node_count = full(sum(sum(a_pp)) - sum(sum(a_pn)) - sum(sum(a_np)) + sum(sum(a_nn))); 
    node_pairs = (size(nebs_ip, 1) + size(nebs_in, 1)) * ...
        (size(nebs_op, 1) + size(nebs_on, 1)) - sum((ai ~= 0) & (ao ~= 0)); 

    if node_count > node_pairs
        error 'Invalid counts'; 
    end		   

    sum_count = sum_count + node_count; 
    sum_pairs = sum_pairs + node_pairs; 

    if mod(k, batch_size) == 0

        clusco = sum_count / sum_pairs;

        fprintf(1, '  clusco(%d) = %g\n', k, clusco); 
        
        if k > iteration_count_min
            diff = abs(clusco - clusco_last); 
            fprintf(1, '  clusco(%d) = %g [%g]\n', k, clusco, diff); 
            if diff < epsilon
                fprintf(1, 'Clusco = %g\n', clusco); 
                return;
            end
        end

        clusco_last = clusco; 
    end

end;

clusco = sum_count / sum_pairs; 

