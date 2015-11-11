cd ..

addpath ../analysis/lib/matlab_bgl/ 

consts = constants(); 

opts.disp = 2; 

n = 2e4;
d = 5;

a = sprand(n, n, d/n);
a = a~=0;

[a cc n] = connect_matrix_square(a);
l = prepare_matrix_2('lap', a, consts.SYM, consts.UNWEIGHTED); 


[u1 d1] = eigl(l, 5, opts, 1);  

[u2 d2] = eigl(l, 5, opts, 2);  

diag(d1)'
diag(d2)'
cross = u1' * u2

