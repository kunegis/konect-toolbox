%
% Determine whether GNU Octave is running.
%
% RESULTS
%	ret	1 when GNU Octave is running; 0 otherwise
%

function ret = konect_usingoctave ()

persistent isoct
if (isempty (isoct))
    isoct = exist('OCTAVE_VERSION') ~= 0;
end
ret = isoct;
