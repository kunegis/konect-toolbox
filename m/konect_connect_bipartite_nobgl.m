%
% Find biggest connected component of bipartite graph.
%
% PARAMETERS 
%	a	Biadjacency matrix of bipartite graph (i.e., 
% 		[0 a;a' 0] is the actual adjacency matrix.)
%
% RESULT 
%	v	0/1 vector of left nodes in connected component
%	w	0/1 vector of right nodes in conneced component
%	
%	Returns v=[] and w=[] when no largest component is found 
%

function [v, w] = konect_connect_bipartite_nobgl(a)

[mm,nn] = size(a)

% Remove empty rows and columns
al = a ~= 0; 
vv = find(sum(al,2)); 
ww = find(sum(al,1)'); 
al = al(vv,ww); 

[m,n] = size(al); 

if m == 0 | n == 0
  v = []; 
  w = []; 
  return; 
end

count = 0
maxc = .1 * m
ite = 1;

while count < maxc

  if ite > 15
    error 'No big component'; 
  end;

  v = zeros(m,1);
  v(1+floor(rand * m)) = 1;
  count_last = 0;
  count = 1;
  rad = 0;

  while count ~= count_last
    count_last = count;
    v = logical(al * (al' * v) + v);
    count = sum(v); 
    rad = rad + 1; 
  end;
  
  rad
  ite = ite + 1

end;

w = logical(al' * double(v));

vi = vv(v);
wi = ww(w); 

v = zeros(mm,1);
w = zeros(nn,1); 

v(vi,:) = 1;
w(wi,:) = 1; 
