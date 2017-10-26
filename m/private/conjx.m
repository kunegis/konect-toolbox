%
% Replacement for conj() that also works with logical matrices, which
% conj() does not. 
%
% RESULT 
%	B	Complex conjugate of the parameter
%
% PARAMETERS 
%	A 	Input matrix of which to compute the complex
%		conjugate; may be logical 
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.cc
%	(c) Jerome Kunegis 2017; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function B = conjx(A)

if islogical(A)
    B = A;
else
    B = conj(A); 
end
