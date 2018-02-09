%
% The median distance between nodes in the graph.  This is related to
% the 50-percentile effective diameter. 
%

function values = konect_statistic_mediandist(A, format, weights)

d = konect_hopdistr(A, format, [], 1);

values = konect_diammedian(d, size(A, 1)); 
