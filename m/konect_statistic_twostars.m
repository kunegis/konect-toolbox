%
% Compute the number of 2-stars in a graphs, i.e., the number of
% pairs of incident edges, or the number of 2-paths.
%
% Multiple edges are ignored.  
%
% Loops are ignored. 
%
% PARAMETERS 
%	A	Adjacency/biadjacency matrix
%	format
%	weights
%	opts	(optional) 
%
% RESULT 
%	values	Column vector of results
%		[1] Number of 2-stars
%

function values = konect_statistic_twostars(A, format, weights, opts)

consts = konect_consts(); 

A = (A ~= 0); 

% Build degree vector

if format == consts.BIP

    d = [ sum(A,2) ; sum(A, 1)' ]; 

elseif format == consts.SYM || format == consts.ASYM

    n = size(A, 1); 

    % Set diagonal elements to zero to exclude loops
    A = A - spdiags(diag(A), [0], n, n); 

    d = sum(A, 2) + sum(A, 1)';

else 
    error('*** Invalid format');
end

values(1) = 0.5 * (d' * (d-1)); 

