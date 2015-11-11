%
% Compute the Laplacian eigenvalue separation [separationl].
%
% RESULT 
%	value	lambda_3[L] / lambda_2[L] 
%
% PARAMETERS 
%	A	Adjacency or biadjacency matrix
%	format
%	weights
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function value = konect_statistic_separationl(A, format, weights)

opts.disp = 2;

[U D] = konect_decomposition('lap', A, 3, format, weights, opts);

if size(D,1) < 3
    value = NaN;
    return;
end

value = D(3,3) / D(2,2);

