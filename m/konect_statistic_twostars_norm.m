
UNUSED -- the correct uniformization is in twostars_normuni

function values = konect_statistic_twostars_norm(A, format, weight)

s = konect_statistic_twostars(A, format, weight);

p = 1/2;

n = konect_statistic_size(A, format, weight);

mu = p * p * n * (n-1) * (n-2) / 2;

sigma = n * n;

values = (s - mu) / sigma;
