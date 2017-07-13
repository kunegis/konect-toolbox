%
% [experimental]
%
% PARAMETERS 
%	A	Adjacency or biadjacency matrix
%	format
%	weights
%
% RESULT 
%	value	
%
% GROUP:  negative
%

function values = konect_statistic_lconflict(A, format, weights)

opts.disp = 2; 

consts = konect_consts(); 

if ~(weights == consts.SIGNED | weights == consts.MULTISIGNED | ...
     weights == consts.WEIGHTED | weights == consts.MULTIWEIGHTED)
    error
end

% Make A symmetric 
if format == consts.SYM
    A = A + A';
elseif format == consts.ASYM
    A = A + A';
elseif format == consts.BIP
    [n1 n2] = size(A);
    A = [ sparse(n1, n1), A; A', sparse(n2, n2) ];
else
    error
end

% Round to +1/-1
A = (A > 0) - (A < 0); 

% Absolute value
A_abs = double(A ~= 0); 

[n n2] = size(A)

% Laplacians
D     = spdiags(sum(A_abs)', [0], n, n);
L     = D - A;
L_abs = D - A_abs;

l_max     = eigs(L,     1, 'lm', opts);
l_abs_max = eigs(L_abs, 1, 'lm', opts); 

values = l_abs_max / l_max; 


