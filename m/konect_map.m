%
% Compute the mean average precision (MAP).
%
% PARAMETERS 
%	prediction	(e*1)	Ranking scores; may be any real numbers
%	T_test		(e*3)
%		First column:  row indexes
%		Second column: column indexes
%		Third column: target values
%
% RESULT 
%	precision		The MAP value 
%

function precision = konect_map(prediction, T_test)

e = size(prediction,1); 

%
% Round target values
% 
T_test(:,3) = T_test(:,3) > 0; 

%
% Randomize order 
%
p = randperm(e);
prediction = prediction(p); 
T_test = T_test(p,:); 

%
% Sort all by prediction
%
[b,x] = sort(-prediction);
prediction = prediction(x); 
T_test = T_test(x,:); 

%
% Average individual APs
%
uids = unique(T_test(:,1)); 

k = size(uids,1); 

ap_sum = 0; 

count = 0; 

t = konect_timer(k); 

for i = 1:k

    if mod(i,250) == 0
        t = konect_timer_tick(t, i); 
    end

    is = find(T_test(:,1) == uids(i)); 

    n = size(is,1); 

    target_i = T_test(is,3); 

    target_sum = sum(target_i); 

    if target_sum == 0 | target_sum == n
        % noop   
    else
        ap_i = konect_ap_sorted(target_i); 

        ap_sum = ap_sum + ap_i; 
        
        count = count + 1; 
    end

end

konect_timer_end(t); 

precision = ap_sum / count; 
