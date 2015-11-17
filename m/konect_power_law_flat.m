%
% Estimate the power-law exponent of an adjacency matrix.
%
% For asymmetric matrices, this function computes the left
% distribution, i.e. based on row sums. 
%
% Use konect_power_law_flat_vector() to estimate the power-law
% exponent of a given vector. 
%
% RESULT 
%	gamma	Power-law exponent
%	sigma	Expected statistical error on gamma
%
% PARAMETERS 
%	A	Adjacency matrix; weights are ignored by
%		default.  Note: a column vector may be passed, too. 
%	weights (optional) How to interpret weights in A:
%		UNWEIGHTED: 	weights are ignored (default) 
%		POSITIVE:	weights are interpreted as multiple
%				edges (they must be positive) 
%		others:		weights are ignored
%

function [gamma sigma] = konect_power_law_flat(A, weights)

consts = konect_consts(); 

if ~exist('weights', 'var')
    weights = consts.UNWEIGHTED; 
end

if weights ~= consts.POSITIVE 
    A = A ~= 0; 
end

degrees = sum(A,2);

assert(sum(degrees < 0) == 0);

[gamma sigma] = konect_power_law_flat_vector(degrees); 

assert(imag(gamma) == 0);
assert(imag(sigma) == 0);
