
function values = konect_statistic_diam(A, format, weights)

d = konect_hopdistr(A, format, [], 1);

% When the network is disconnected, return the number of
% nodes 

values = length(d);
