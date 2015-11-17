%
% Reorder a DEDICOM, in a way that important latent dimensions come first. 
%
% PARAMETERS 
%	U,D
%
% RESULT 
%	U,D
%

function [U D] = konect_order_dedicom(U, D)

weights = diag(D * D' + D' * D);

[w i] = sort(-abs(weights)); 

U = U(:,i);
D = D(i,i); 

