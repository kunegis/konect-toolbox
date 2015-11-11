
addpath ../ 

n = 408; 
d = 10;
r = 7; 

A = sprand(n, n, d/n);
A = A+A';
u = sprand(n, 1, d/n);
A = A + 100 * u * u'; 
A = A ~= 0;

L = spdiags(sum(A)', [0], n, n) - A;

opts.disp = 2; 

%
% Method 'sa'
% 

tic
[U0 D0] = eigl(L, r, opts, 0);
time_0 = toc

%
% Without inverse iteration
%

tic 
[U2 D2] = eigl(L, r, opts, 2);
time_2 = toc

%
% Compare
%

diag(D0)'
diag(D2)'
time_0
time_2

if norm(D0 - D2) > 1e-10, error('***'); end
