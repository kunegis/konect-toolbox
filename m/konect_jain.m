%
% Compute Jain's fairness index.
%
% RESULT 
%	value		Jain's fairness index
%
% PARAMETERS 
%	x		Vector of values
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function [value] = konect_jain(x)

value = sum(x)^2 / length(x) / sum(x .^ 2); 
