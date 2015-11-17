%
% Estimate the power-law exponent of the components of a vector. 
%
% This uses the simple, fast and robust method from [1] Equations (5-6).
% It will give skewed results if the distribution is not a power law, or
% only a power law in a specific range. 
%
% [1] Power laws, Pareto distributions and Zipf's law, M. E. J. Newman,
% 2006. 
%
% PARAMETERS 
%	values	Vector of values; zeroes are ignored
%
% RESULT 
%	gamma	Power-law exponent
%	sigma	Expected statistical error on gamma
%

function [gamma sigma] = konect_power_law_flat_vector(values)

values = values(values ~= 0); 

n = length(values); 

v = sum(log(values / min(values)));

gamma = 1 + n / v; 

sigma = sqrt(n) / v; 

