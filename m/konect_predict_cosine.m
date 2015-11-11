%
% Cosine similarity prediction.  This function support complex matrices
% A as input.  The file konect_predict_neib.m also includes the cosine
% similarity, but does not support complex vectors. 
%
% RESULT 
%	prediction	(e*1) Prediction scores
% 
% PARAMETERS 
%	A		(n*n) The adjacency matrix
%	T		(e*2) Indexes of vertex pairs to compute
%	format		Format
%			Pass consts.BIP to not perform any preprocessing 
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function [prediction] = konect_predict_cosine(A, T, format)

consts = konect_consts(); 

if format == consts.SYM
    A = A + A'; 
elseif format == consts.ASYM
    [ m n ] = size(A); 
    A = [ A ; A' ]; 
end

[m n] = size(A); 

w = sum(conjx(A) .* A, 2) .^ -0.5;
w(isinf(w)) = 0;
A = spdiags(w, [0], m,m) * A; 

e = size(T, 1)

prediction = zeros(e, 1); 

[k, from, to] = konect_fromto(1, e, 1000); 

for i = 1:k

    range = from(i) : to(i); 
    fprintf(1, 'range(1) = %d\n', range(1));  

    i = T(range, 1);
    j = T(range, 2); 

    prediction_i = real(sum(conjx(A(i,:)) .* A(j,:), 2)); 

    prediction(range, 1) = prediction_i; 
end

