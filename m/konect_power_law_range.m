%
% Fit a power law using the method from Aaron Clauset [1], using the
% implementation from [2].  This method is very slow, but gives
% correct results when the distribution is a power law only beginning
% at a certain degree.  
%
% This function has the same API as konect_power_law_flat(). 
%
% PARAMETERS 
%	A		Adjacency matrix or weight vector
%	weights		(optional) Weight types; pass POSITIVE or UNWEIGHTED for
%			weight vectors; defaults to WEIGHTED 
%	enable_p	(optional) Enable computation of p-values
%			(VERY slow, disabled by default) 
%
% RESULT 
%	values	Column vector of values as returned by the pl*
%		functions from Aaron Clauset.  
%		(1) gamma	The exponent (positive)
%		(2) xmin	The minimal degree
%		(3) L		Log-likelihood of the data x >= xmin
%				under the fitted power law 
%		(4) p		p-value, i.e. small denotes better fit 
%		(5) gof		Goodness-of-fit value 
%
% REFERENCES 
%
% [1] Power-law distributions in empirical data, Aaron Clauset, Cosma
%     Rohilla Shalizi, M. E. J. Newman.   
%
% [2] http://tuvalu.santafe.edu/~aaronc/powerlaws/
%     Visited on 2014-10-16
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function [values] = konect_power_law_range(A, weights, enable_p)

consts = konect_consts(); 

if nargin < 2
    weights = consts.WEIGHTED; 
end

if ~exist('enable_p', 'var')
    enable_p = 0; 
end

if weights == consts.SIGNED | weights == consts.WEIGHTED | ...
            weights == consts.MULTIWEIGHTED
    A = A ~= 0; 
end

degrees = sum(A,2);

degrees = degrees(degrees ~= 0); 

range = [ 1.001 : 0.01 : 9 ]; 

[gamma, xmin, L] = plfit(degrees, 'range', range)

values = [gamma xmin L]';  

if enable_p
    [p, gof] = plpva(degrees, xmin, 'range', range)
    values = [ values ; p ; gof ]; 
end
