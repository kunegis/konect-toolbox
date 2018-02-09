%
% Directed clustering coefficient. 
%
% GROUP:  asym
%

function values = konect_statistic_cluscoasym(A, format, weights)

consts = konect_consts(); 

if format ~= consts.ASYM
  error('***'); 
end

% Round all values to 0/1
A = (A ~= 0);

[x c c2] = konect_clusco(A); 

values(1) = c; 
