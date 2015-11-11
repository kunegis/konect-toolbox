%
% Compute the algebraic conflict [conflict].
%
% PARAMETERS 
%	A 	Adjacency or biadjacency matrix
%	format
%	weights
%
% RESULT 
%	values	Algebraic conflict of largest connected component; 0 for unweighted networks
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function values = konect_statistic_conflict(A, format, weights)

consts = konect_consts(); 

opts.disp = 2; 



if weights == consts.UNWEIGHTED | weights == consts.POSITIVE | consts.POSWEIGHTED
    % We know it is zero
    values = [ 0 ]; 
    return; 
end

% Build the Laplacian matrix L
if format ~= consts.BIP 
    [A cc n] = konect_connect_matrix_square(A);
    L = konect_matrix('lap', A, format, weights, opts); 
else % BIP
    [A cc1 cc2 n] = konect_connect_matrix_bipartite(A); 
    L = konect_matrix('lap', A, format, weights, opts); 
end

lambda_n = eigs(L, 1, 'lm', opts)

lambda_n_minus_1 = eigs(lambda_n * speye(size(L,1)) - L, 1, 'lm', opts)

conflict = lambda_n - lambda_n_minus_1

values = [ conflict ]; 


