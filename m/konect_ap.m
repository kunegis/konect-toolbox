%
% Compute the average precision. 
%
% If target is not a 0/1 vector, its values are rounded to 0 or 1. 
%
% PARAMETERS 
%	prediction	(e*1) Prediction scores
%	target		(e*1) Correct scores
%			
% RESULT 
%	ret		The average precision
%

function ret = konect_ap(prediction, target)

if length(prediction) ~= length(target), error('*** both vectors must have same length'); end; 

e = length(prediction); 

% Round target to 0/1
target = target > 0; 

% Randomize order 
p = randperm(e);
prediction = prediction(p); 
target = target(p); 

% Compte MAP
[tmp,i] = sort(-prediction);
a = target(i); 
p_sum = 0;  
nz = 0;

for j = 1 : e
    if a(j) ~= 0
        nz = nz + a(j);  
        p_sum = p_sum + a(j) * nz / j;
    end;
end;

ret = p_sum / nz;
