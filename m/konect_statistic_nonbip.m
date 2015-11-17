%
% Compute the non-bipartivity measure [nonbip]. It is defined as
%
% 1 - | lambda_min[\bar A] / lambda_max[\bar A] |,
%
% where lambda_min and lambda_max are the smallest and largest
% eigenvalue of the unweighted adjacency matrix \bar A. 
%
% ATTRIBUTE:  square
%
% PARAMETERS 
%	A		Half-adjacency matrix
%	format		Format of the network
%	weights		Weights in the network 
%
% RESULTS 
%	values 	Column vector of results
%	[1] non-bipartivity value
%	[2] lambda_min
%	[3] lambda_max
%

function values = konect_statistic_nonbip(A, format, weights)

opts.disp = 2; 
opts.issym = 1; 

consts = konect_consts();

if format == consts.BIP
    error '*** NONBIP is trivially zero for bipartite networks'; 
end

n = size(A, 1); 

if weights ~= consts.POSITIVE
    A = A ~= 0; 
end

lambda_max = eigs(@(x)(A * x + A' * x), n, 1, 'la', opts)
lambda_min = eigs(@(x)(A * x + A' * x), n, 1, 'sa', opts)

nonbip = 1 - abs( lambda_min / lambda_max ) 

if nonbip < 0
    fprintf(1, 'Warning:  negative value of NONBIP, rounding to zero\n'); 
    nonbip = 0; 
end

values = [ nonbip; lambda_min; lambda_max ]; 
