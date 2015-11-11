%
% Scalable pseudoinverse.  In particular, this can be applied to n*r
% matrices, with n>>r, in which case pinv() will take too much memory. 
%
% PARAMETERS 
%	a	Matrix to pseudoinvert
%
% RESULT 
%	a_i	Pseudoinverse
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function a_i = konect_xpinv(a)

[u d v] = svd(a, 'econ');
a_i = v * konect_xinv(d) * u'; 
