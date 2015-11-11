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
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function ret = konect_signx(A)

if islogical(A)
    ret = A;
else
    ret = sign(A);
end
