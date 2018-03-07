%
% Compute the power law exponent using the correct and slow method, with p-values [power3].
%
% PARAMETERS 
%	A 	Adjacency/biadjacency matrix
%	format
%	weights
%
% RESULT 
%	values	Column vector of values
%		Each group of five:  power_a, xmin, L, p, gof
%		for undirected graphs:  (all) (...)  (...)   (...) (...)
%		for directed graph:     (all) (...)  (...)   (out) (in)
%		for bipartite graph:    (all) (left) (right) (...) (...)
%		[1-5]  ALL
%		[6-15] BIP
%		[16-25] ASYM
%
% GROUP+6:  BIP
% GROUP+7:  BIP
% GROUP+8:  BIP
% GROUP+9:  BIP
% GROUP+10:  BIP
% GROUP+11:  BIP
% GROUP+12:  BIP
% GROUP+13:  BIP
% GROUP+14:  BIP
% GROUP+15:  BIP
% GROUP+16:  ASYM
% GROUP+17:  ASYM
% GROUP+18:  ASYM
% GROUP+19:  ASYM
% GROUP+20:  ASYM
% GROUP+21:  ASYM
% GROUP+22:  ASYM
% GROUP+23:  ASYM
% GROUP+24:  ASYM
% GROUP+25:  ASYM
%

function values = konect_statistic_power3(A, format, weights)

consts = konect_consts(); 

% Ignore edge weights 
A = (A ~= 0); 

if format == consts.SYM | format == consts.ASYM
    values_all = konect_power_law_range(A | A', weights, 1);
elseif format == consts.BIP
    [m n] = size(A); 
    values_all = konect_power_law_range([sparse(m,m) A; A' sparse(n,n)], weights, 1); 
else
  error(); 
end

if format == consts.ASYM
    nvalues_out = konect_power_law_range(A, weights, 1);
    nvalues_in = konect_power_law_range(A', weights, 1);
    values = [ values_all ; NaN * ones(10,1) ; nvalues_out ; nvalues_in ]
elseif format == consts.BIP    
    nvalues_out = konect_power_law_range(A, weights, 1);
    nvalues_in = konect_power_law_range(A', weights, 1);
    values = [ values_all ; nvalues_out ; nvalues_in ; NaN * ones(10,1) ]
elseif format == consts.SYM
  values = [ values_all ; NaN * ones(20,1) ] 
else
  error(); 
end
