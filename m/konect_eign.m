%
% Compute the eigenvalue decomposition of a normalized matrix. By a
% normalized matrix, we mean a matrix whose eigenvalues are in the
% range [-1, +1].  This implementation uses a special decomposition
% method that is faster than just using eigs().  
%
% Two methods are supported; see below. 
%
% ARGUMENTS 
%	A	Normalized matrix
%	r	Rank
%	method	(optional) The method to use
%		0	[power iteration] eigs('lm'); uses less memory but is slower
%		1	[inverse iteration] eigs(1+epsilon); faster but uses more memory
% 			There is a subtle difference between the two
% 			methods:  the LM method returns the R largest
% 			eigenvalues by absolute values, while the
% 			EPSILON method returns the R/2 largest and
% 			R-R/2 smallest eigenvalues. 
%
% RESULT 
%	u,d	Eigenvector decomposition
%	
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function [u d] = konect_eign(A, r, varargin)

METHOD_LM = 0;
METHOD_EPSILON = 1;

if (nargin > 2)
    method = varargin{1}; 
else
    if nnz(A) < 1000000
        method = METHOD_EPSILON;
    else
        method = METHOD_LM; 
    end
end

opts.disp = 2; 

if method == METHOD_LM

    [u,d] = eigs(A, r, 'lm', opts); 
    dd = diag(d); 

else

    r_pos = round(r/2);
    r_neg = r - r_pos; 

    epsilon = 1e-3;

    [u_pos,d_pos] = eigs(A, r_pos, 1+epsilon, opts); 
    dd_pos = diag(d_pos); 

    if r_neg > 0
        [u_neg,d_neg] = eigs(A, r_neg, -1-epsilon, opts); 
        dd_neg = diag(d_neg); 
    else
        u_neg = zeros(size(A,1), 0);
        d_neg = zeros(0, 0); 
        dd_neg = zeros(1, 0); 
    end

    u = [u_pos u_neg];
    dd = [dd_pos; dd_neg]; 
    [x,i] = sort(-abs(dd));
    u = u(:,i);
    d = diag(dd(i));

    diag_d = diag(d);
    
end
