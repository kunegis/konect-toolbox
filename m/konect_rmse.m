%
% The root-mean-square error.
%
% RESULT 
%	ret	The root-mean-square error
%
% PARAMETERS 
%	target, prediction	Actual and predicted values 
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function [ret] = konect_rmse(target, prediction)

ret = mean((target - prediction) .^ 2) ^ .5; 
