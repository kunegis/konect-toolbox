%
% Find the biggest weakly connected component of a unipartite graph. 
%
% PARAMETERS 
%	A	Square adjacency matrix of unipartite graph; doesn't
%		have to be symmetric
%
% RESULT 
%	v	0/1 vector of nodes in the connected component or
%		[] when there is no large connected component
%

function [v] = konect_connect_square_nobgl(A)

ite_max = 15; 

[n,nx] = size(A);

Al = (A~=0) | (A'~=0);
ite = 0;

while ite < ite_max
  ite = ite + 1;

  v = zeros(n,1);
  v(1+floor(rand * n)) = 1;
  count_last = 0;
  count = 1;
  rad = 0;

  while count ~= count_last
    count_last = count;
    Alv = Al * double(v);
    v = logical(Alv + v);
    count = sum(v); 
    rad = rad + 1; 
    fprintf(1, '%4d %10d\n', rad, count); 
  end;

  if count >= .1 * n, return; end; 

end;

% error '*** No big connected component' 
v = []; 
