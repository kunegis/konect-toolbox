

function values = konect_statistic_twostars_norm2(A, format, weight)

s = konect_statistic_twostars(A, format, weight);
n = konect_statistic_size(A, format, weight);

mu = n*(n-1)*(n-2)/8;
sigma_square = (1/8)*n^4 - (19/32)*n^3 + (29/32)*n^2 - (7/16)*n;

values = (s - mu) / sqrt(sigma_square);
