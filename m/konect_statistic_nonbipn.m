%
% Compute the non-bipartivity measure based on the normalized adjacency
% matrix [nonbipn]. It is defined as 
%
% lambda_min[N[\bar G]] + 1
%
% where lambda_min[N] is the smallest eigenvalue of the normalized
% adjacency matrix N = D^-1/2 A D^-1/2. 
%
% ATTRIBUTE:  square
%
% PARAMETERS 
%	A	Adjacency matrix
%	format
%	weights
%
% RESULTS 
%	values 	Column vector of results
%	[1] non-bipartivity value
%	[2] lambda_min[N]
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function values = konect_statistic_nonbipn(A, format, weights)

opts.disp = 2; 
opts.issym = 1; 

consts = konect_consts();

% To show more significant digits when opts.disp = 2.
set_format();

if format == consts.BIP
    error '*** NONBIPN is trivially zero for bipartite networks'; 
end

if weights ~= consts.POSITIVE
    A = A ~= 0; 
end

A = A + A'; 

A = A ~= 0; 

[A cc n] = konect_connect_matrix_square(A);   

N = konect_matrix('svd-n', A, format, weights, opts); 

tmp_2 = norm(N - N', 'fro')

lambda_min = eigs(N, 1, 'sr', opts)

nonbipn = lambda_min + 1

if nonbipn < 0
    fprintf(1, 'Warning:  negative value of NONBIPN, rounding to zero\n'); 
    nonbipn = 0; 
end

values = [ nonbipn; lambda_min ]; 

end

function set_format()

format long; 

end

