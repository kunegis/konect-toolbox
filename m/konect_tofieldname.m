%
% Convert a string to a valid field name.  This is used whenever
% structs are used in a dynamic way, using generic strings as keys,
% for instance for methods, submethods, decompositions, etc. 
%
% The opposite of konect_fromfieldname(), when S does not contain
% '+'. 
%

function ret = konect_tofieldname(s)

ret = regexprep(s, '-', '_'); 
ret = regexprep(s, '+', '__'); 
