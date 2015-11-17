%
% The root-mean-square error.
%
% RESULT 
%	ret	The root-mean-square error
%
% PARAMETERS 
%	target, prediction	Actual and predicted values 
%

function [ret] = konect_rmse(target, prediction)

ret = mean((target - prediction) .^ 2) ^ .5; 
