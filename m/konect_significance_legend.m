%
% Generate the legend to a significance plot.
%
% PARAMETERS 
%	p_threshold
%	maxdiff
%	label_measure
%

function konect_significance_legend(p_threshold, maxdiff, label_measure)

font_size = 60; 

% Resolution 
r = 70;

% Ranges
range_p = 1.3
range_diff = 1.2

% Range of values 
v_p = linspace(0, range_p * p_threshold, r);
v_d = linspace(range_diff * maxdiff, -range_diff * maxdiff, r); 

I = konect_significance_image(ones(r,1) * v_p, v_d' * ones(1,r), p_threshold, maxdiff); 

image([min(v_p), max(v_p)], [min(v_d), max(v_d)], I);

set(gca, 'FontSize', font_size); 

set(gca, 'XTick', [0 .05], ...
         'XTickLabels', { '0', '0.05' }); 
set(gca, 'YTick', [-0.2, 0, +0.2 ], ...
         'YTickLabels', { '+0.2', '0', '-0.2' }); 
set(gca, 'TickLength', [ 0 0 ]); 

xlabel('p-value', 'FontSize', font_size);
ylabel(sprintf('%s_x - %s_y', label_measure, label_measure), 'FontSize', font_size); 

axis square; 
