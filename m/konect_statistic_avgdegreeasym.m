%
% Directed average degrees:  This is only useful when nodes with zero
% degree are ignored, which is done below.
%
% PARAMETERS 
%	A	Adjacency matrix
%	format	
%	weights
%
% RESULT 
%	values	Column vector of results
%	[1]	average out+in degree (ignoring 0-nodes)
%	[2]	average outdegree (ignoring 0-nodes)
%	[3]	average indegree (ignoring 0-nodes)
%	[4]	average out+in degree (not ignoring 0-nodes)
%	[5]	average outdegree (not ignoring 0-nodes)
%	[6]	average indegree (not ignoring 0-nodes)
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%
% ATTRIBUTE:  asym 
%

function values = konect_statistic_avgdegreeasym(A, format, weights)

consts = konect_consts(); 

assert(format == consts.ASYM); 

assert(size(A,1) == size(A,2));

n = size(A,1)

m = nnz(A)

if weights ~= consts.POSITIVE
    A = (A ~= 0);
end

d_out = sum(A, 2);
d_in  = sum(A, 1)';

d = d_out + d_in;

nz = nnz(d)
nz_out = nnz(d_out)
nz_in  = nnz(d_in)

values = [ 2 * m / nz ; ...
           m / nz_out ; ...
           m / nz_in ; ...
           2 * m / n ; ...
           m / n ; ...
           m / n ]

