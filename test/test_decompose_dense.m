
DEPRECATED -- covered by test_decompose() 

cd ..

%
% Small directed graph 
% 

% A directed graph

%% 1 --> 2 ---> 3
%%       A     A
%%       |    /
%%       V  <-
%%       4============> 5

a = [0 1 0 0 0; 0 0 1 1 0; 0 0 0 1 0; 0 1 1 0 2; 0 0 0 0 0];


[u x] = decompose_dense(a, 3, 'dedicom1u');
[u x] = decompose_dense(a, 3, 'dedicom1v'); 
[u x] = decompose_dense(a, 3, 'dedicom2');
[u x] = decompose_dense(a, 3, 'dedicom2s');
[u x] = decompose_dense(a, 3, 'dedicom3');


%
% Sparse random graph
%

opts.disp = 2; 

n = 1000;
d = 20;
a = sprand(n, n, d/n);

[u x] = decompose_dense(a, 3, 'dedicom1u', opts);
[u x] = decompose_dense(a, 3, 'dedicom1v', opts); 
[u x] = decompose_dense(a, 3, 'dedicom2',  opts);
[u x] = decompose_dense(a, 3, 'dedicom2s', opts);
[u x] = decompose_dense(a, 3, 'dedicom3',  opts);

