%
% Convert p-value and difference matrices to an image.  
%
% PARAMETERS 
%	P	(m*m) Pairwise p-values
%	D	(m*m) Pairwise differences
%	p_threshold	Threshold under which to show p-values (e.g., 0.05) 
%	maxdiff		Difference to show in maximal style
%
% RESULT 
%	I	(m*m*3)	Image matrix/tensor 
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function I = konect_significance_image(P, D, p_threshold, maxdiff)

m = size(P,1); 

% The larger the values, the more detail is visible
gamma_D = 0.6;
gamma_P = 1.3; 

% Hue (m*m) 
% Use red for "AUC(i) < AUC(j)", green for "AUC(i) > AUC(j)" and
% yellow for equal AUCs.  
D_norm = max(-1, min(+1, D / maxdiff)); % between -1 and +1
D_norm = sign(D_norm) .* (abs(D_norm) .^ gamma_D); 
color_H = (-D_norm + 2) / 3;

% Saturation (m*m)
color_S = (1 - min(1, P / p_threshold)) .^ gamma_P; 

% I (m*m*3) is the image matrix.  For each (i,j), I(i,j,:) is the RGB
% vector for the area representing the relation between methods i and
% j.  
for j = 1 : m % j is the column of all matrices
    C = hsv2rgb([ color_H(:,j) color_S(:,j) ones(m,1) ]);
    I(1:m, j, 1) = C(:,1);
    I(1:m, j, 2) = C(:,2);
    I(1:m, j, 3) = C(:,3);
end

