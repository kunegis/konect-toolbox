
function values = konect_statistic_mediandist(A, format, weights)

d = konect_hopdistr(A, format, [], 1);

values = konect_diammedian(d, size(A, 1)); 
