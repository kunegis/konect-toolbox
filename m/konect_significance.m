%
% Statistical significance using a t-test.  Return the probability that
% U > V could have arisen from equal distributions.  The absolute
% value of the result indicates the direction of the difference. 
%
% RESULT 
%	p	Probability
%
% PARAMETERS 
%	u,v	(n*1) Vectors to compare
%

function [p] = konect_significance(u, v)

[h p] = ttest(u, v); 

p = 1 - p; 

if sum(u ~= v) == 0
    p = 0;
end

di = u - v;
di = di(~isnan(di) & ~isinf(di)); 
if mean(di) < 0 
    p = -p; 
end

if isnan(p)
    p = 0;
end
