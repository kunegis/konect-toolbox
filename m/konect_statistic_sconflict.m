
function values = konect_statistic_sconflict(A, format, weights, opts)

consts = konect_consts(); 

if ~(weights == consts.SIGNED | weights == consts.MULTISIGNED | ...
     weights == consts.WEIGHTED | weights == consts.MULTIWEIGHTED)
    error
end

