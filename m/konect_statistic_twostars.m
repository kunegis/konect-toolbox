%
% Compute the number of 2-stars in a graphs, i.e., the number of
% pairs of incident edges, or the number of 2-paths.
%
% Multiple edges and loops are ignored.  
%
% For directed graphs, the following patterns are recognized:
%
%      * <-- * --> *    Outgoing 2-star
%
%      * --> * <-- *    Ingoing 2-star
%
%      * --> * --> *    Mixed 2-star
%
% For bipartite graphs a left 2-star has a single left node with
% degree two.  Right 2-stars are defined analogously. 
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
%		[2] Number of left 2-stars (BIP only)
%		[2] Number of outgoing 2-stars (ASYM only)
%		[3] Number of right 2-stars (BIP only)
%		[3] Number of ingoing 2-stars (ASYM only)
%		[4] Number of mixed 2-stars (ASYM only)
%
%

function values = konect_statistic_twostars(A, format, weights, opts)

consts = konect_consts(); 

% Ignore multiple edges
A = (A ~= 0); 

% Ignore loops
if format == consts.SYM || format == consts.ASYM
    n = size(A, 1); 
    A = A - spdiags(diag(A), [0], n, n); 
end

% Build degree vector

d_1 = sum(A,2);
d_2 = sum(A,1)'; 

if format == consts.BIP

%%    d = [ sum(A,2) ; sum(A, 1)' ]; 
%%    values(1) = 0.5 * (d' * (d-1)); 

    values(2) = 0.5 * sum(d_1 .* (d_1 - 1))
    values(3) = 0.5 * sum(d_2 .* (d_2 - 1))
    values(1) = values(2) + values(3)

elseif format == consts.SYM 

    d = d_1 + d_2;

    values(1) = 0.5 * sum(d .* (d - 1))

elseif format == consts.ASYM

%%    d = sum(A, 2) + sum(A, 1)';
%%    values(1) = 0.5 * (d' * (d-1)); 

%%    d = d_1 + d_2;

%%    values(1) = 0.5 * sum(d .* (d - 1)); 

    values(2) = 0.5 * sum(d_1 .* (d_1 - 1))
    values(3) = 0.5 * sum(d_2 .* (d_2 - 1))
    values(4) = sum(d_1 .* d_2)
    values(1) = values(2) + values(3) + values(4)

else 
    error('*** Invalid format');
end
