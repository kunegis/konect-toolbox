%
% Compute the mean path length, based on the result of konect_diameff().
%
% RESULT 
%	value	Mean path length
%
% PARAMETERS 
%	data	Vector of frequency of path lengths, as returned by
%		konect_hopdistr()
%	n	(optional) Number of nodes; if not given, inferred
%		from the data
%	allow_disconnected (default = 0) Whether to allow
%		disconnected networks.  N must be given. 
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function [value] = konect_diammean(data, n, allow_disconnected)

% Make DATA a column vector 
data = data(:)
%if size(data,1) < size(data,2)
%    data = data'; 
%end

if ~exist('allow_disconnected', 'var')
    allow_disconnected = 0; 
end

%if ~exist('n', 'var')
%    n = round(sqrt(data(end))); 
%end

values = (0 : (length(data) - 1))'
counts = data - [0 ; data(1:end-1)]
%values = (0 : (length(data) - 1))'; 
%counts = data - [0; data(1:end-1)]; 

%assert(sum(counts) <= n*n); 

if ~allow_disconnected
    % This is not necessarily true as DATA may be an estimation 
    %    assert(sum(counts) == n*n); 
else
    %% For all unconnected nodes, count their distance as n
    % counts(n+1) = n*n - sum(counts); 
    % values = 0 : n; 
end

value = (values' * counts) / sum(counts)

