%
% Denormalize a prediction vector additively.  
%
% Only the first two columns of at are used. 
%
% RESULT 
%	prediction	(e*1)	Denormalized prediction values 
%
% PARAMETERS 
%	T		(e*[2+k])	Row and column indexes
%	prediction	(e*1) 		Prediction vector
% 	means		
%

function prediction = konect_denormalize_additively(T, prediction, means)

if size(means.U)
    prediction = prediction + means.U(T(:,1)) + means.V(T(:,2)); 
end

