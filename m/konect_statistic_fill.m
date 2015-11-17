%
% Compute the fill of the network, i.e., the proportion of possible
% edges that exist.  For networks with multiple edges, edge
% multiplicities are ignored. 
%
% Note: the definition of the fill in KONECT takes into account that
% loops are possible. 
%
% PARAMETERS 
%	A		Adjacency or biadjacency matrix
%	format		Format of the network
%	weights		Weights of the network 
%
% RESULT 
%	values		Column vector of values
%		[1] 	The fill, taking into account loops if they
%			are present
%		[2]	The fill, ignoring loops 
%

function values = konect_statistic_fill(A, format, weights)

consts = konect_consts(); 

if format == consts.SYM | format == consts.ASYM

    % Note:  We assume that it is impossible that a network allows
    % loops when it has no loops; this is checked by check.m. 

    d = (diag(A) ~= 0); 
    count_loops = sum(d);
    has_loops = count_loops > 0; 

end

if format == consts.SYM

    A = ( A ~= 0 ); 

    m = nnz(A); 
    n = nnz(sum(A, 1)' + sum(A, 2)); 
    
    values = [ 2 * m / (n * (n - 1 + 2 * has_loops)); ...
               2 * (m - count_loops) / (n * (n-1)) ];

elseif format == consts.ASYM

    A = ( A ~= 0 ); 

    m = nnz(A); 
    n = nnz(sum(A, 1)' + sum(A, 2)); 

    values = [ m / (n * (n - 1 + has_loops)); ...
               (m - count_loops) / (n * (n-1)) ]; 

elseif format == consts.BIP

    m = nnz(A); 
    [n1 n2] = size(A); 

    p = m / (n1 * n2); 

    values = [ p ; p ]; 

end


