%
% Estimate the 90-percentile effective diameter of a graph.  The graph
% should be connected.  In unipartite graphs, this computes the strong
% (i.e., unidirectional) diameter.  To get the weak (unoriented)
% diameter, pass A+A'.
%
% The value returned is imprecise as a heuristic is used (node
% sampling).  No accuracy of the result is returned, or even known. 
%
% This always computes the 90-percentile effective diameter. 
%
% PARAMETERS 
%	A	Adjacency matrix or biadjacency matrix 
%	epsi 	(optional) Requested precision
%
% RESULT 
%	diameter	The compute effective diameter
%

function ret = konect_effective_diameter(A, epsi)

% Compute the effective diameter at this value (e.g. at 90%) 
threshold = .9; 

% Size of a "batch"
iteration_count = 9; 

% Requested precision
if ~exist('epsi', 'var')
    epsi = .029; 
end

% Initialize the Matlab random number generator
RandStream.setDefaultStream(RandStream('mt19937ar','seed',sum(100*clock)));

fprintf(1, 'Diameter (%d * %d, %d)...\n', size(A,1), size(A,2), nnz(A)); 

[m,n] = size(A); 

% Maximum number of overall iterations
iteration_count_max = m; 

% Minimum number of batches to compute
iteration_count_min = floor(m * 0.000001); 

al = A ~= 0; 

% number of paths computed
count = 0; 
counts = 0; 

% We actually compute the half-diameter because we also use a*a', so we
% double the result at the end. 

diameter_last = NaN; 

perm = randperm(m); 

for i = 1 : iteration_count_max

    index = perm(1 + floor(rand * m)); 

    u = zeros(m,1);
    u(index) = 1;
    r_last = 0;
    r = 1;
    distance = 0;

    while r ~= r_last
        r_last = r;
        u_new = logical(al * (al' * u));
        distance = distance + 1; 

        r_new = sum((u_new - u) > 0); 
        u = logical(al* (al' * u) + u);
        r = sum(u); 
        if size(counts, 2) < distance
            counts(distance) = r_new; 
        else
            counts(distance) = counts(distance) + r_new; 
        end
        count = count + r_new; 
    end;

    if mod(i, iteration_count) == 0 | i == iteration_count_max
        counts_i = counts / count; 

        diameter = NaN;
        counts_i = cumsum(counts_i); 

        counts_i = [0 counts_i]; 
        for j = 1:(size(counts_i,2)-1)
            if counts_i(j) <= threshold & counts_i(j+1) > threshold
                diameter = j-1 + (threshold - counts_i(j)) / (counts_i(j+1) - counts_i(j)); 
                break; 
            end; 
        end

        if diameter_last == diameter_last & i >= iteration_count_min

            stddev = i^-.5; 
            rel_err = stddev / diameter; 

            fprintf(1, '  diameter(%d) = %g [%g]\n', i, diameter, rel_err); 
            if rel_err < epsi
                ret = 2 * diameter; 			     
                return; 
            end
        else
            fprintf(1, '  diameter(%d) = %g\n', i, diameter); 
        end
        
        diameter_last = diameter; 
    end
end

for j = 1:(size(counts_i,2)-1)
    if counts_i(j) <= threshold & counts_i(j+1) > threshold
	diameter = j-1 + (threshold - counts_i(j)) / (counts_i(j+1) - counts_i(j)); 
	break; 
    end; 
end

ret = 2 * diameter; 
