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

function a_i = konect_xpinv(a)

[u d v] = svd(a, 'econ');
a_i = v * konect_xinv(d) * u'; 
