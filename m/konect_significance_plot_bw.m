%
% Same as konect_significance_plot() but in black-and-white. 
%
% PARAMETERS 
%	values	(m*n) Matrix of values; there are n methods with m
%		values each 
%	p_threshold
%	maxdiff
%	labels
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function konect_significance_plot_bw(values, p_threshold, maxdiff, labels)

font_size = 13; 
displacement_x = 0.3; % Of Y axis labels (sic) left of plot
displacement_y = 0.3; % Of X axis labels (sic) below the plot
rotation_y = 27; % Rotation of X axis labels
len = 0.9; % Length of bars relative to cell width
line_width = 8;

[m n] = size(values);

% Pairwise p-values 
P = zeros(m, m); 

% Pairwise differences
D = zeros(m, m); 

for i = 1 : m
    for j = 1 : m
        [h p] = ttest(values(i, :), values(j, :)); 
        P(i, j) = p; 
        D(i, j) = mean(values(i,:) - values(j,:)); 
    end
end

hold on;
axis([0 m 0 m]); 
axis square;

for i = 1 : m
    for jj = 1 : m
        j = m + 1 - jj;
        p = P(i,jj);
        d = D(i,jj);
        if p >= p_threshold,  continue;  end;

        theta = (atan(d / maxdiff * pi / 2) + pi / 2) / 2;
        
        line(...
            [ (i - 1/2 + (1/2) * len * cos(theta)) ...
              (  i - 1/2 - (1/2) * len * cos(theta))], ...
            [ (j - 1/2 - (1/2) * len * sin(theta)) ...
              (  j - 1/2 + (1/2) * len * sin(theta))], ...
             'Color', [1 1 1] * min(1, p / p_threshold), ...
             'LineWidth', line_width);
    end
end

%I = konect_significance_image(P, D, p_threshold, maxdiff);

%image(I);

% Labels
for i = 1 : m
    text(-displacement_x, m + 1 - i - 1/2  , labels(i), 'HorizontalAlignment', 'Right', 'VerticalAlignment', 'Middle', 'FontSize', font_size); 
    text(i-1/2, -displacement_y, labels(i), 'HorizontalAlignment', 'Right', 'VerticalAlignment', 'Middle', 'FontSize', font_size, 'Rotation', rotation_y); 
end

set(gca, 'XTick', []); 
set(gca, 'YTick', []); 

axis square; 
