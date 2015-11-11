%
% Compute the spectral distribution of a symmetric matrix. This is an
% internal function that needs explicit bounds values.
%
% PARAMETERS 
%	A	(n*n) Symmetric matrix 
%	lower	Lower bound for eigenvalues
%	upper	Upper bound for eigenvalues
%	k	Number of bins
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function [counts, begins, ends] = konect_spectral_distribution_plain(A, lower, upper, k)

lower 
upper

assert(size(A, 1) == size(A, 2)); 

%ddd = eig(A)

epsi = norm(A - A', 'fro')

if abs(epsi) >= 1e-10, error('*** matrix A is not symmetric'); end

n = size(A,1);

begins = lower + (upper - lower) * (0:(k-1)) / k;
ends   = lower + (upper - lower) * (1:k)     / k;

begins_ends = [ begins' ends' ];

t = konect_timer(k-1); 

%
% Count eigenvalues
% cumul(i) = number of eigenvalues in bin up to I
%
for i = 1 : (k-1)

    i

    t = konect_timer_tick(t, i); 

    threshold = ends(i)
    A_shifted = A - threshold * speye(n); 
    %    ddd = eig(A_shifted)
    [l,u,p] = lu(A_shifted, 1, 'vector');
    %    l_diag = diag(l)
    %    u_diag = diag(u)
    negative_count = full(sum(diag(u) < 0)); 
    cumul(i) = negative_count; 
    fprintf(1, '%d (%g):  %d\n', i, threshold, negative_count); 

    if i > 1
        if cumul(i) < cumul(i-1)
            % lu() seems to return weird values which do not always correspond
            % to actual eigenvalue signs.  Just round the values up. 

            fprintf(2, 'Warning:  ***negative values\n'); 

            cumul(i) = cumul(i-1); 
        end
    end
end

konect_timer_end(t); 

counts = [cumul n] - [0 cumul];

counts = counts'; 
begins = begins'; 
ends = ends'; 
