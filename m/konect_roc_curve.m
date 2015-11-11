%
% Plot one ROC curve.  This calls "plot", so "hold" must be used when
% aggregating multiple ROC curves.  
%
% The ROC curve is plotted in the square [0 1]^2.  No axes are set. 
%
% PARAMETERS 
%	target		(n*1) 0/1 vector of true values
%	score		(n*1) Predicted scores to evaluate
%
% RESULT 
%	h		Handle of the plot 
%	m		Number of 1s in TARGET
%	n		length of both input vectors
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function [h m n] =  konect_roc_curve(target, score, color, line_style, line_width)

resolution = 150; % Number of points on the plot; determines the
                  % resolution 

n = size(target,1); % Number of results
m = sum(target); % Number of true results 

% Randomize order to avoid effects of pre-ordered vectors 
ii = randperm(n);
target = target(ii);
score = score(ii); 

% True/false vector of results 
[s i] = sort(-score);
r = target(i);

range = 1:round(n/resolution):n; 
vals  = cumsum(r); 

x = [0 range] / n; 
y = [0; vals(range)] / m; 

h = plot(x, y, line_style, 'LineWidth', line_width, 'Color', color);
