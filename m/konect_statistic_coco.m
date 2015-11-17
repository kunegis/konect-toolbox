%
% Compute the size of the largest connected component [coco].
%
% PARAMETERS 
%	A	Half-adjacency/biadjacency matrix
%	format
%	weights
%
% RESULT 
%	values 	Column vector of results
%		[1]	Size of largest connected component
%		[2]	Relative size, i.e., [1] divided by size of network
%		[3,5]	Left/right numbers (BIP only)
%		[4,6]	Left/right relative cocos (BIP only) 
%

function values = konect_statistic_coco(A, format, weights)

consts = konect_consts();

if format == consts.BIP

    [v w] = konect_connect_bipartite(A);

    vs = sum(v);
    ws = sum(w);
    
    values = [ vs + ws ; (vs + ws) / sum(size(A)) ; vs ; vs / size(A,1) ; ws ; ws / size(A,2) ]; 

else

    v = konect_connect_square(A);

    coco = sum(v); 
    
    values = [ coco ; coco / size(A,1) ]; 

end

