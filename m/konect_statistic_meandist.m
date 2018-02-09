%
% The average distance between nodes of the graph. 
%

function values = konect_statistic_meandist(A, format, weights)

d = konect_hopdistr(A, format, [], 1);

values = konect_diammean(d, size(A,1), 1);
