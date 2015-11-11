%
% Compute the hop distribution and all nodes' eccentricities.  Due to
% the computation of eccentricities, this function is slower than
% konect_hopdistr(). In all other regards, the two functions do the same,
% except that this function returns the additional value
% "eccentricities".  Another difference is the argument a for undirected
% networks, which is not symmetric in this function. 
%
% For undirected and bipartite graphs, this is the normal undirected hop
% distribution.  For directed graphs, edge directions are ignored. 
%
% RESULT 
%	d	(1*diam) Number of distances by distance (zero is excluded); the
%		length of this vector is the graph's diameter. 
%	eccentricities	Node vector of eccentricity values
%
% PARAMETERS 
%	A		Adjacency or biadjacency matrix (FOR UNDIRECTED
%			NETWORKS, this need not be symmetric).
%	format 		(optional) Format using the constants in
%			konect_consts.m; ASYM when not given 
%	size_chunk	(optional) Size of chunks used; the choice of
%			this value only influences the runtime of the
%			function, not the result 
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function [d eccentricities] = konect_hopdistr_ex(A, format, size_chunk)

% Size in double variables of the largest number of doubles that is to
% be used as temporary memory.  Used in the calculation of the default
% value of SIZE_CHUNK.  
size_resident = 1e7; 

consts = konect_consts(); 

maxit =  intmax; 

if ~exist('format', 'var')
    format = consts.ASYM;
end

if format == consts.BIP
    [m n] = size(A); 
    A = [ sparse(m,m) A ; sparse(m,n) sparse(n,n) ]; 
end

n = size(A,1);

if ~exist('size_chunk', 'var')
    size_chunk = floor(size_resident / n); 
    if size_chunk < 1, size_chunk = 1; end; 
end

% Add loops, i.e. diagonal elements
A = double(((A ~= 0) + speye(n)) ~= 0);

d = []; 

eccentricities = zeros(n, 1); 

t = konect_timer(n); 

for j = 1 : n

    t = konect_timer_tick(t, j); 

    x = A(:, j); 

    dd = []; 

    for i = 1 : maxit
        dd(i) = nnz(x);     

        x_old = x;
        x = A * x + A' * x;
        x = x ~= 0;

        if norm(x - x_old, 'fro') == 0, break; end;
    end

    % Eccentricities
    eccentricities(j) = length(dd) - 1;

    % Add sums
    if length(d) < length(dd)
        if length(d) > 0
            d((end+1) : length(dd)) = d(end);
        else
            d(length(dd)) = 0; 
        end
    else
        dd((end+1) : length(d)) = dd(end);
    end
    d = d + dd; 
end

konect_timer_end(t); 

eccentricities = 1 + eccentricities;
