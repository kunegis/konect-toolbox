%
% Wrapper for sign() that also accepts sparse logical matrices and just
% returns them, as opposed to sign() which does not work for logical
% matrices. 
%
% RESULT 
%	ret	Sign of the argument matrix 
%
% PARAMETERS 
%	A	Matrix of which the sign is to be computed;
%		may be a logical matrix
%

function ret = konect_signx(A)

if islogical(A)
    ret = A;
else
    ret = sign(A);
end
