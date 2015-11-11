%
% Compute the absolute network rank.  The absolute network rank (formerly called
% "effective rank") equals the sum of absolute eigenvalues divided by
% the absolute value of the largest eigenvalue (in absolute value). 
%
% For Laplacian decomposition types, the inverse nonzero eigenvalues are
% used, and zero eigenvalues are ignored.  For asymmetric cases, the
% singular values are used.  
%
% The parameter DECOMPOSITION is only used to distinguish between
% adjacency and Laplacian decompositions. 
%
% PARAMETERS 
%	dd		(r*1) Eigenvalue/singular values
%	decomposition	(optional) Decomposition type, as in
%			decompose.m; default is 'svd'
% 
% RESULT 
%	rank	The network rank
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function rank = konect_network_rank_abs(dd, decomposition)

if nargin < 2
    decomposition = 'svd'; 
end

if sum(size(dd)) == 0
    rank = NaN;
else

    dd = abs(dd); 

    if size(regexp(decomposition, '^lap'))
        dd(dd < 1e-8) = 0; 
        dd = dd .^ -1
        dd(dd ~= dd) = 0;
        dd(dd == Inf) = 0; 
    end

    rank = sum(dd) / max(dd); 

end
