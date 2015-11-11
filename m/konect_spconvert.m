%
% Customized version of spconvert() that also supports the two-column
% format for sparse 0/1 matrices.  If only two columns are given,
% create a sparse logical matrix.  
%
% PARAMETERS 
%	T	The r*(3 or 2) matrix of row indexes, column indexes and
%		(optionally) weights; additional columns beyond the
%		third are ignored
%	n1,n2	(optional) Number of rows and columns.  May be less than
%		actual.  If not passed, the size is inferred from T. 
%
% RESULT 
%	A	(n1*n2) sparse matrix 
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function [A] = konect_spconvert(T, n1, n2)

consts = konect_consts(); 

if ~exist('n1', 'var'), n1 = 0; end;
if ~exist('n2', 'var'), n2 = 0; end; 

if size(T,2) == 2

    % The matrix is a 0/1 matrix.  However if there are multiple entries
    % this doesn't work, so we use try-catch. 

    if n1 ~= 0 & n2 ~= 0
        try
            A = sparse(T(:,1), T(:,2), logical(1), n1, n2);
        catch exception
            A = sparse(T(:,1), T(:,2), 1, n1, n2); 
        end
    else
        try
            A = sparse(T(:,1), T(:,2), logical(1));
        catch exception
            A = sparse(T(:,1), T(:,2), 1); 
        end
    end
else
    if n1 ~= 0 & n2 ~= 0
        A = sparse(T(:,1), T(:,2), T(:,3), n1, n2); 
    else
        A = sparse(T(:,1), T(:,2), T(:,3)); 
    end
end
