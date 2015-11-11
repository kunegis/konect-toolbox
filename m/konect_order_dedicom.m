%
% Reorder a DEDICOM, in a way that important latent dimensions come first. 
%
% PARAMETERS 
%	U,D
%
% RESULT 
%	U,D
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function [U D] = konect_order_dedicom(U, D)

weights = diag(D * D' + D' * D);

[w i] = sort(-abs(weights)); 

U = U(:,i);
D = D(i,i); 

