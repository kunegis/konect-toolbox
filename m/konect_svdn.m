%
% Singular value decomposition of a normalized matrix.
% 
% A normalized matrix has singular values <= 1.  This implementation uses a
% special decomposition method that is faster than just using svds(). 
%
% RESULT 
%	U,D,V	Singular value decomposition
%	
% PARAMETERS 
%	A	A matrix with all singular values not larger that one
%	r	Rank
%	method	(optional) The method to use
%		0	svds('L'); uses less memory but is slower
%		1	svds(1+epsilon); faster but uses more memory
%

function [U,D,V] = konect_svdn(A, r, varargin)

METHOD_L = 0;
METHOD_EPSILON = 1;

if (nargin > 2)
    method = varargin{1}; 
else
    method = METHOD_L; 
end

opts.disp = 2; 

if method == METHOD_L

    [U,D,V] = svds(A, r, 'L', opts); 
    %    dd = diag(D); 

else

    epsilon = 1e-3;

    [U,D,V] = svds(A, r, 1+epsilon, opts); 
    dd = diag(D); 

    [x,i] = sort(-dd);
    U = U(:,i);
    V = V(:,i);
    D = diag(dd(i));
    
end
