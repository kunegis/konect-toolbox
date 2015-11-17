%
% The proportion of nodes with degree one. 
%

function values = konect_statistic_degone(A, format, weights, opts)

consts = konect_consts();

if format == consts.SYM || format == consts.ASYM

    n = size(A, 1);
    assert(size(A, 2) == n);
    values = [ sum(sum(double((A ~= 0) | (A ~= 0))) == 1) / n ];

elseif format == consts.BIP

    A = double(A ~= 0); 
    values = [ (sum(sum(A, 1) == 1) + sum(sum(A, 2) == 1)) / sum(size(A)) ];

else
    assert(0);
end
