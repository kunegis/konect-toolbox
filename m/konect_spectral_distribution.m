%
% Compute the spectral distribution of a sparse matrix, i.e., the
% distribution of the eigenvalues or singular values.  
%
% Splits the spectrum of the matrix A into K bins. 
%
% PARAMETERS 
% 	A		Sparse adjacency or biadjacency matrix 
%	decomposition	The decomposition to perform.  Only 'sym',
%			'sym-n' and 'lap' are supported
%	format
% 	k		Number of bins
%
% RESULT 
% 	counts	(k*1) The number of eigenvalues in each bin
% 	begins	(k*1) The starts of each bin
% 	ends	(k*1) The ends of each bin 
%

function [counts, begins, ends] = konect_spectral_distribution(A, decomposition, format, k, varargin)

consts = konect_consts(); 

bounds = []; 

set_format();
opts.disp = 2; 
opts.issym = 1; 

% 
% Transform A to square and symmetric 
%
'transform to square and symmetric matrix'
if strcmp(decomposition, 'sym')

    A = konect_matrix('symfull', A, format); 

elseif strcmp(decomposition, 'sym-n')
    
    A = konect_matrix('sym-nfull', A, format);

    bounds = [ -1, +1 ]; 

elseif strcmp(decomposition, 'lap')
    A = konect_matrix(decomposition, A, format); 
    bounds = [0]; 
else
    error('*** Invalid decomposition'); 
end

size_A = size(A)

n = size(A,1)

%
% Default bounds:  +/- spectral norm
%
if length(bounds) == 0
    'calling eigs() in konect_spectral_distribution()'
    d = eigs(@(x)(A * x), n, 1, 'lm', opts); 
    upper = abs(diag(d))
    lower = - upper
elseif length(bounds) == 1
    'calling eigs() for only the maximum eigenvalue'
    d = eigs(@(x)(A * x), n, 1, 'la', opts);
    lower = bounds(1)
    upper = d
else
    'fixed bounds'
    lower = bounds(1)
    upper = bounds(2)
end

data_decomposition = konect_data_decomposition(decomposition); 

if data_decomposition.posdef
    lower = 0; 
end

[counts begins ends] = konect_spectral_distribution_plain2(A, lower, upper, k); 

end

function set_format()

    format long; 

end
