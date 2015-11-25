%
% Convert a field name back to a string.  Used in conjunction with
% konect_tofieldname(). 
%

function ret = konect_fromfieldname(s)

ret = regexprep(s, '_', '-'); 
