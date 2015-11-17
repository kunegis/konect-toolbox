%
% Wrapper for abs() that also accepts sparse logical matrices and just
% returns them, as opposed to abs() which does not work for logical
% matrices. 
%
% RESULT 
%	ret	Absolute value of the argument matrix 
%
% PARAMETERS 
%	A	Matrix of which the absolute value is to be computed;
%		may be a logical matrix
%

function ret = konect_absx(A)

if islogical(A)
    ret = A;
else
    ret = abs(A);
end
