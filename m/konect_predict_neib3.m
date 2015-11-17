%
% Neighborhood-based link predictions, using paths of length
% 3.  Sensible for all networks, including bipartite ones. 
%
% Always ignore edge direction and weights. 
%
% PARAMETERS 
%	type	'path3'
%	A	(m*n) Adjacency/biadjacency matrix 
%	T	(e*2) Indexes of vertex pairs; typically this is the test set
%	format	How to interpret A 
%
% RESULTS 
%	prediction	(e*1) prediction values
%

function [prediction] = konect_predict_neib3(type, A, T, format)

consts = konect_consts(); 

e = size(T, 1); 

if format == consts.BIP
    T(:,2) = T(:,2) + size(A,1); 
end

A = konect_matrix('symfull', A, format); 

w_i = sum(konect_absx(A), 2); 
w_j = sum(konect_absx(A), 2); 

%
% Prediction
%
prediction = zeros(e, 1); 

[k, from, to] = konect_fromto(1, e, 100); 

t = konect_timer(e); 

for l = 1:k

    t = konect_timer_tick(t, from(l)); 

    range = from(l) : to(l); 

    A_i = A(T(range, 1), :) * A;
    A_j = A(T(range, 2), :);
    prediction(range) = sum(A_i .* A_j, 2);
end

konect_timer_end(t); 

