%
% Same as konect_significance_legend(), but in black-and-white. 
%
% PARAMETERS 
%	p_threshold
%	maxdiff
%	label_measure
%

function konect_significance_legend_bw(p_threshold, maxdiff, label_measure)

font_size = 59; 
len = 0.9; % Length of bars relative to cell width
line_width = 8;

% Resolution 
r = 10;

% Ranges
range_p = 1.3
range_diff = 1.2

% Range of values 
p_min = 0;
p_max = range_p * p_threshold; 
d_max = 2 * range_diff * maxdiff;
d_min = - d_max; 

hold on;
axis([p_min p_max d_min d_max]); 
axis square; 

for i = 1 : r
    for jj = 1 : r 
        j = r + 1 - jj;
        p = p_min + (i - 1/2) * (p_max - p_min) / r;
        d = d_min + (jj - 1/2) * (d_max - d_min) / r; 
        if p >= p_threshold,  continue;  end;

        theta = (atan(d / maxdiff * pi / 2) + pi / 2) / 2;
        
        line(...
            [ (p_min + (p_max - p_min) / r * (i - 1/2 + (1/2) * len * cos(theta))) ...
              (p_min + (p_max - p_min) / r * (i - 1/2 - (1/2) * len * cos(theta)))], ...
            [ (d_min + (d_max - d_min) / r * (j - 1/2 - (1/2) * len * sin(theta))) ...
              (d_min + (d_max - d_min) / r * (j - 1/2 + (1/2) * len * sin(theta)))], ...
             'Color', [1 1 1] * min(1, p / p_threshold), ...
             'LineWidth', line_width);
    end
end

set(gca, 'FontSize', font_size); 

set(gca, 'XTick', [0 .05], ...
         'XTickLabels', { '0', '0.05' }); 
set(gca, 'YTick', [-0.2, 0, +0.2 ], ...
         'YTickLabels', { '-0.2', '0', '+0.2' }); 
set(gca, 'TickLength', [ 0 0 ]); 

xlabel('p-value', 'FontSize', font_size);
ylabel(sprintf('%s_x - %s_y', label_measure, label_measure), 'FontSize', font_size); 

end

function [x] = to_p(i)

end

function [y] = to_d(j)
end
