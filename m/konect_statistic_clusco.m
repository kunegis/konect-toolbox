%
% Compute the clustering coefficients [clusco] and [clusco2].
%
% PARAMETERS 
%	A 	Adjacency matrix
%	format
%	weights
%
% RESULT 
%	values	Column vector of results
%		[1] clustering coefficient [clusco, probability that
%			an edge pair is closed]
%		[2] directed clustering coefficient (ASYM)
%		[3] signed clustering coefficient (SIGNED or WEIGHTED)
%		[4] signed directed clustering coefficient ({SIGNED or WEIGHTED) and ASYM)	
%		[5] relative signed clustering coefficient (SIGNED or WEIGHTED)
%		[6] relative signed directed clustering coefficient ((SIGNED or WEIGHTED) and ASYM)
%		[7-12] same with [clusco2, i.e., mean of local
%			clustering coefficients]
%
% ATTRIBUTE:  square 
%

function values = konect_statistic_clusco(A, format, weights)

consts = konect_consts(); 

if format == consts.BIP
    error '*** Clustering coefficient is trivially zero for bipartite networks'; 
end

% Round all values to -1/0/+1 
A = konect_signx(A);

A_abs = A ~= 0; 

[x c c2] = konect_clusco(A_abs | A_abs'); 
values(1) = c; 
values(7) = c2; 

if weights == consts.SIGNED | weights == consts.WEIGHTED | weights == consts.MULTIWEIGHTED
    % Note:  we must use "+" instead "|" in order to preserves to -1
    % entries in the matrix. 
    [x c c2] = konect_clusco(konect_signx(A + A')); 
    values(3) = c; 
    values(9) = c2;
    values(5)  = values(3) / values(1); 
    values(11) = values(9) / values(7); 
end

if format == consts.ASYM
    [x c c2] = konect_clusco(A_abs); 
    values(2) = c; 
    values(8) = c2; 
    
    if weights == consts.SIGNED | weights == consts.WEIGHTED | weights == consts.MULTIWEIGHTED
        [x c c2] = konect_clusco(A); 
        values(4)  = c; 
        values(10) = c2;
        values(6)  = values(4)  / values(2); 
        values(12) = values(10) / values(8); 
    end
end

values = values';
