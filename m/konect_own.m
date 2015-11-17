%
% Compute the Balanced Inequality ratio as defined in [1].
%
% [1] Fairness on the Web: Alternatives to the Power Law, Jérôme
%     Kunegis and Julia Preusse, Proc. Web Science Conf., 2012,
%     pp. 175--184.   
%
% RESULT 
%	own	The balanced inequality ratio 
%
% PARAMETERS 
%	p	(e*1) Indexes
%	q	(e*1) Multiplicities or [] for uniform weights 
%

function [own] = konect_own(p, q)

[gini r_x r_y] = konect_gini(p, q); 

r_x_inv = flipud(r_x); 

v = r_x_inv - r_y; 

i = max(find(v > 0)); 

own = r_y(i); 
