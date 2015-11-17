%
% Numerically stable pseudoinverse of a diagonal matrix.  This will
% pseudoinvert each diagonal element separately. 
%
% PARAMETERS 
%	d	Diagonal matrix to pseudoinvert
%	
% RESULT 
%	d_i	Pseudoinverse of D
%
% USAGE 
%
% Typically, this is used to compute the pseudoinverse of a n*k matrix,
% where n is large and k is small, in the following way: 
%
%   [u d v] = svd(a, 'econ');
%   a_i = v * konect_xinv(d) * u'; 
%

function d_i = konect_xinv(d)

l = diag(d) .^ -1;
l(isinf(l)) = 0;
l(l ~= l) = 0;

d_i = diag(l); 


