%
% Compute the edge distribution entropy "dentropy"/"dentropyn". 
%
% RESULTS 
%	ret	The edge distribution entropy in nats
%
% PARAMETER 
%	d	Column vector of degrees
%	type	(optional) Type: 'a'/'n' corresponding to [dentropy] and [dentropyn]. Default is 'a'. 
%

function ret = konect_dentropy(d, type)

if ~exist('type', 'var')
    type = 'a'; 
end

d = full(d(find(d)));
d = d / sum(d); 
ret = - sum(d .* log(d));

if strcmp(type, 'n')
    ret = ret / log(prod(size(d))); 
end
