% GROUP:  negative

function [value] = konect_statistic_fconflict(A, format, weights)

values = konect_statistic_conflict(A, format, weights);
value = values(2);
