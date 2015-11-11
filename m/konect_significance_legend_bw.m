%
% Same as konect_significance_legend(), but in black-and-white. 
%
% PARAMETERS 
%	p_threshold
%	maxdiff
%	label_measure
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
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

%I = konect_significance_image(ones(r,1) * v_p, v_d' * ones(1,r), p_threshold, maxdiff); 

%image([min(v_p), max(v_p)], [min(v_d), max(v_d)], I);

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

        % d = sign(d) * min(abs(d), maxdiff); 
        % x = d / maxdiff / 2;
        % line([(p_min + (i-1) * (p_max - p_min) / r) ...
        %       (p_min + (i) * (p_max - p_min) / r)], ...
        %      [(d_min + (j-1/2-x) * (d_max - d_min) / r) ...
        %       (d_min + (j-1/2+x) * (d_max - d_min) / r)], ...
        %      'Color', [1 1 1] * min(1, p / p_threshold), ...
        %      'LineWidth', 2);
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
