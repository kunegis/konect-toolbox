% 
% The assortativity \rho of a network.
% 
% Ignore multiplicities, loops and edge directions. 
%
% PARAMETERS 
%	A	
%	format
%	weights
%	opts	(optional)
%
% RESULT 
%	values 	Columns vector of results
%		[1] assortativity \rho
%		[2] p-value 
%

function values = konect_statistic_assortativity(A, format, weights, opts)

consts = konect_consts(); 

if format == consts.SYM | format == consts.ASYM

    n = size(A, 1); 

    A = A ~= 0;
    A = A | A';
    A = A - spdiags(diag(A), [0], n, n); 

    d = sum(A,2);

    [x y z] = find(A); 
    
    p = d(x); 
    q = d(y); 

    [rho pvalue] = corr(p, q)

elseif format == consts.BIP

    A = A ~= 0; 

    d1 = sum(A, 2); 
    d2 = sum(A, 1)'; 

    [x y z] = find(A);

    p = d1(x);
    q = d2(y); 

    [rho pvalue] = corr(p, q)

end

assert(isfinite(rho)); 

values = [ rho; pvalue ]; 
