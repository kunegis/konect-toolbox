%
% Compute the volume of a network, i.e. the number of edges.
%
% PARAMETERS 
%	A	Adjacency of biadjacency matrix
%	format
%	weights
%	opts
%
% RESULT 
%	values	Column vectors of values
%		[1]	Number of edges
%		[2]	Sum of absolute edge weights (only WEIGHTED,
%			SIGNED) (note that for POSITIVE networks,
%			multiple edges counted multiple times in
%			statistic [1])
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function values = konect_statistic_volume(A, format, weights, opts)

consts = konect_consts();

if weights == consts.UNWEIGHTED | weights == consts.POSWEIGHTED

    values = nnz(A); 

elseif weights == consts.POSITIVE | weights == consts.DYNAMIC

    values = full(sum(sum(A))); 

elseif weights == consts.SIGNED | weights == consts.WEIGHTED | weights ...
        == consts.MULTIWEIGHTED

    values = [ nnz(A) ;
               full(sum(sum(abs(A)))) ]; 

else
    error('*** Invalid weights'); 
end

