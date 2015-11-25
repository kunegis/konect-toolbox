%
% Only the clustering coefficient, without extra variants.
%
% ATTRIBUTE:  square 
%

function values = konect_statistic_clusco(A, format, weights)

consts = konect_consts(); 

if format == consts.BIP
    error '*** Clustering coefficient is trivially zero for bipartite networks'; 
end

A_abs = A ~= 0; 

[x c c2] = konect_clusco(A_abs | A_abs'); 
values(1) = c; 
