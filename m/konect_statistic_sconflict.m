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

function values = konect_statistic_sconflict(A, format, weights)

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

l_max     = eigs(A,     1, 'la', opts)
l_min     = eigs(A,     1, 'sa', opts)
l_abs_max = eigs(A_abs, 1, 'la', opts)
l_abs_min = eigs(A_abs, 1, 'sa', opts)

values = (l_max / l_min) / (l_abs_max / l_abs_min)

