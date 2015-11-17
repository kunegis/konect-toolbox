%
% Compute the number of 4-stars in a graphs, i.e., the number of
% triples of incident edges. 
%
% Multiple edges in the input graph are ignored.  Loops are
% ignored.  
%
% PARAMETERS 
%	A	Adjacency/biadjacency matrix
%	format
%	weights
%	opts	(optional) 
%
% RESULT 
%	values	Column vector of results
%		[1] Number of 4-stars
%

function values = konect_statistic_fourstars(A, format, weights, opts)

consts = konect_consts(); 

% Ignore edge weights and multiplicities
A = (A ~= 0); 

%
% Build degree vector
%
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

z = sum(d .* (d-1) .* (d-2) .* (d-3)) / 24;
assert(z == floor(z));
values(1) = z;
