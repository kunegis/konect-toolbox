%
% The area under the ROC curve, i.e. the AUC.
%
% If target is not a 0/1 vector, its values are rounded to 0 or 1. 
%
% PARAMETERS 
%	prediction	(e*1) vector of predicted scores
%	target		(e*1) vector of values to be predicted 
%
% RESULT 
%	ret		The AUC
%

function ret = konect_auc(prediction, target)

assert(length(prediction) == length(target)); 

% All values passed are finite 
assert(sum(~isfinite(prediction)) == 0);
assert(sum(~isfinite(target)) == 0);

target = target > 0; 

e = length(prediction);
k = sum(target);

if k == e | k == 0
    ret = 0;  
    return; 
end 

% Randomize order 
p = randperm(e);
prediction = prediction(p);
target = target(p); 

[tmp,x] = sort(prediction, 'descend');
a = target(x);

s = 0;
c = e-k;
for i = 1 : e
    if a(i) == 0
        c = c - 1;
    else
        s = s + c;
    end
end

ret = s / (k * (e-k));
