%
% Compute the preferential attachment exponent [1].
%
% In short, this takes a set of old and new edges, and computes a number
% β ≥ 0 that characterizes to what extent preferential attachment is
% present in the network.  Zero denotes no preferential attachment and one
% denotes linear preferential attachment (as usually defined). 
%
% PARAMETERS 
%   T1  (m1×{2,3}) all old edges (with optional weights)
%   T2  (m2×{2,3}) all new edges (with optional weights)
%
% If T2 is not given, T1 is understood to contain all edges, from oldest
% to newest, and is split in a 2/3+1/3 fashion. 
%
% RETURN VALUE 
%   beta	The preferential attachment exponent β
%
% REFERENCES 
%   [1] Preferential Attachment in Online Networks:  Measurement and
%       Explanations; Jérôme Kunegis, Marcel Blattner and Christine Moser;
%       Proc. Web Science Conf., 2013, pp. 205--214. 
%

function [beta] = konect_pa(T1, T2)

if ~exist('T2', 'var')
   assert(size(T1,2) == 2 | size(T1,2) == 3); 
   m = size(T1,1)
   m_split = floor((2/3) * m)
   T2 = T1(m_split:end, :);
   T1 = T1(1:(m_split-1), :); 
end

assert(size(T1,2) == 2 | size(T1,2) == 3); 
assert(size(T2,2) == 2 | size(T2,2) == 3); 

i_1 = [T1(:,1); T1(:,2)];
if size(T1,2) == 3
  w_1 = [T1(:,3); T1(:,3)];
else 
  w_1 = 1;
end
i_2 = [T2(:,1); T2(:,2)];
if size(T2,2) == 3
  w_2 = [T2(:,3); T2(:,3)];
else 
  w_2 = 1;
end

[ret ret_data] = konect_pa_full(i_1, w_1, i_2, w_2); 

beta = ret.a(1)

