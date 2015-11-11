%
% Find the biggest weakly connected component of a unipartite graph. 
%
% PARAMETERS 
%	a	Square adjacency matrix of unipartite graph; doesn't
%		have to be symmetric
%
% RESULT 
%	v	0/1 vector of nodes in the connected component or
%		[] when there is no large connected component
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function [v] = konect_connect_square_nobgl(a)

ite_max = 15; 

[n,nx] = size(a);

al = (a~=0) | (a'~=0);
ite = 1;

while ite < ite_max
  ite = ite + 1; 

  v = zeros(n,1);
  v(floor(rand * n)) = 1;
  count_last = 0;
  count = 1;
  rad = 0;

  while count ~= count_last
    count_last = count;
    alv = al * double(v);
    v = logical(alv + v);
    count = sum(v); 
    rad = rad + 1; 
    fprintf(1, '%4d %10d\n', rad, count); 
  end;

  if count >= .1 * n, return; end; 

end;

% error '*** No big connected component' 
v = []; 
