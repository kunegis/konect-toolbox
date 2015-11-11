%
% Mean area under the curve (MAUC). 
%
% PARAMETERS 
%	prediction	(e*1)
%	T_test		(e*3)
%		First column:  row indexes
%		Second column: column indexes
%		Third column: target values
%
% RESULT 
%	precision	The MAUC value
% 
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function precision = konect_mauc(prediction, T_test)

r = size(prediction,1); 

%
% Scale target values
% 
T_test(:,3) = T_test(:,3) > 0; 

%
% Randomize order 
%
p = randperm(r);
prediction = prediction(p); 
T_test = T_test(p,:); 

%
% Sort all by prediction
%
[b,x] = sort(-prediction);
prediction = prediction(x); 
T_test = T_test(x,:); 

%
% Average individual AUCs
%
uids = unique(T_test(:,1)); 

k = size(uids,1); 

auc_sum = 0; 

count = 0; 

t = konect_timer(k); 

for i = 1:k

    if mod(i, 100) == 0
        t = konect_timer_tick(t, i); 
    end; 

    is = find(T_test(:,1) == uids(i)); 

    n = size(is,1); 

    prediction_i = prediction(is); 
    target_i = T_test(is,3); 

    target_sum = sum(target_i); 

    if target_sum == 0 | target_sum == n

    else

        s = 0;
        c = n - target_sum;
        for j = 1:n
            if target_i(j) == 0
                c = c - 1;
            else
                s = s + c;
            end
        end

        auc_i = s / (target_sum * (n - target_sum)); 
        auc_sum = auc_sum + auc_i; 
        count = count + 1; 
    end
    

end

konect_timer_end(t); 

precision = auc_sum / count; 
