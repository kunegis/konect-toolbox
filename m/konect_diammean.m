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

function [value] = konect_diammean(data, n, allow_disconnected)

% Make DATA a column vector 
data = data(:)

if ~exist('allow_disconnected', 'var')
    allow_disconnected = 0; 
end

values = (0 : (length(data) - 1))'
counts = data - [0 ; data(1:end-1)]

if ~allow_disconnected
    % This is not necessarily true as DATA may be an estimation 
    %    assert(sum(counts) == n*n); 
else
    %% For all unconnected nodes, count their distance as n
    % counts(n+1) = n*n - sum(counts); 
    % values = 0 : n; 
end

value = (values' * counts) / sum(counts)

