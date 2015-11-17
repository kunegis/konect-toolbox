%
% Compute the hop distribution, i.e., the distribution of shortest path
% distances between all pairs.  As a side effect, this method also
% computes the exact diameter (as the length of the returned vector D),
% and the result can be used to compute the exact effective diameter,
% mean and median diameters.
%
% For undirected and bipartite graphs, this is the normal undirected hop
% plot.  For directed graphs, this is the directed hop-plot. 
%
% RESULT 
%	d	(1*diam) d(i) equals the number of nodes pairs at
%		distance at most i.  The value for zero is excluded
%		(since d(0) cannot be defined).  The length of this
%		vector is the graph's diameter.  d(end) always equals
%		the squared number of nodes. 
%
% PARAMETERS 
%	A		Adjacency or biadjacency matrix (need not be
%			symmetric for undirected networks); the
%			network must be connected if
%			allow_disconnected in not set
%	format 		(optional) Format using the constants in
%			konect_consts.m; ASYM when not given 
%	size_chunk	(optional) Size of chunks used; the choice of
%			this value only influences the runtime of the
%			function, not the result ; pass [] for the
%			default value 
%	allow_disconnected	(default = 0) If set, allow the
%		network to be disconnected, otherwise not.  If
%		set, the returned distribution contains only the
%		pairs that are connected.  If not set, the function
%		will throw an error when the graph is not
%		connected. 
%

function [d] = konect_hopdistr(A, format, size_chunk, allow_disconnected)

% Size in double variables of the largest number of doubles that is to
% be used as temporary memory.  Used in the calculation of the default
% value of SIZE_CHUNK.  
size_resident = 1e7; 

consts = konect_consts(); 

% Maximum number of iterations
maxit =  intmax; 

if ~exist('format', 'var')
    format = consts.ASYM;
end

if ~exist('allow_disconnected', 'var')
    allow_disconnected = 0; 
end

A = (A ~= 0); 

if format == consts.SYM | format == consts.ASYM
    A = A | A'; 
elseif format == consts.BIP
    [m n] = size(A); 
    A = [ sparse(m,m) A ; A' sparse(n,n) ]; 
end

n = size(A,1);

if ~exist('size_chunk', 'var') | length(size_chunk) == 0
    size_chunk = floor(size_resident / n); 
    if size_chunk < 1, size_chunk = 1; end; 
end

% Add loops, i.e., diagonal elements, and remove edge weights
A = double(((A ~= 0) + speye(n)) ~= 0);

% Return value; the values are added up 
d = []; 

[k from to] = konect_fromto(1, n, size_chunk);

t = konect_timer(n); 

for j = 1 : k

    t = konect_timer_tick(t, to(j)); 

    x = A(:, from(j):to(j)); 

    % The values of D added for this chunk 
    dd = []; 

    for i = 1 : maxit
        dd(i) = nnz(x);     

        x_old = x;
        x = A * x;
        x = x ~= 0;

        if x == x_old, break; end;
    end

    % Add sums to d
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

if ~allow_disconnected
    if d(end) ~= n*n
        error('*** Network is not connected'); 
    end
else
    assert(d(end) <= n*n); 
end 


