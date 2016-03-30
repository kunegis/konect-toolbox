%
% Test decompositions. 
%

cd ..; 

addpath ../analysis/lib/matlab_bgl/ 


decompositions = { ...
    'sym', 'sym-n', 'lap', 'stoch2', ...
    'svd', 'svd-n', ...
    'diag', 'skew', 'herm', ...
    'lapd', 'lapd-n', 'lapherm', ...
    'stoch1', 'diag-n', 'back', ...
    'dedicom1u', 'dedicom1v', 'dedicom2', 'dedicom3', 'dedicom3-0', 'takane', ...
 }; 


opts.disp = 2; 

consts = konect_consts(); 

% This is directed and strongly connected
A = [0 1 0 0 0; 0 0 1 1 0; 0 0 0 1 0; 0 1 1 0 2; 1 0 0 0 0];
r = 3; 

for i = 1 : length(decompositions)
    decomposition = decompositions{i}; 

    [u d v d_u d_v] = konect_decomposition(decomposition, A, r, consts.ASYM, consts.POSITIVE, opts); 
end 

%
% Sparse random graph
%
n = 1000; d = 20; A = sprand(n, n, d/n);
r = 7; 

for i = 1 : length(decompositions)

    decomposition = decompositions{i}; 

    [u d v d_u d_v] = konect_decomposition(decomposition, A, r, consts.ASYM, ...
                                       consts.POSITIVE, opts); 
end
