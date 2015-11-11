%
% Compute the rank-reduced eigenvalue decomposition of a sparse
% Laplacian matrix.  This function will compute the r smallest
% eigenvalues and corresponding eigenvectors of a given symmetric
% positive-semidefinite matrix L. The matrix L is typically the
% Laplacian matrix of a graph, but can be any other matrix which is
% square, symmetric, positive-semidefinite, and of which the smallest
% eigenvalues are to be computed. 
%
% All zero eigenvalues are returned.  Eigenvalues are returned in
% nondecreasing order.  
% 
% Note that for every connected component of a graph, one eigenvalue
% of zero exists.  This means that for large networks, this function
% will return only zero eigenvalues, since a large network is likely
% to have at least r connected components. To avoid this, reduce a
% graph to its largest connected component first.  One can use the
% konect_connect_* functions to do that. 
%
% The arguments r and opts, and the return values U and D have the
% same semantics as with the Matlab function eigs(). 
%
% There are several algorithms implemented, as described below.  The
% following decision diagram can be used to choose a method:  
%
%	* Is O(n^2) memory usage acceptable?
%		* YES:  Is 0 an eigenvalue of L?
%			* YES:  Use 'epsilon'
%			* NO:  Use 'sa'
%			* DON'T KNOW:  Use 'epsilon'
%		* NO:  Use 'lm' 
%
% PARAMETERS 
%	L	(n*n) Laplacian matrix, must be symmetric and
%		positive-semidefinite (i.e., all eigenvalues
%		nonnegative) 
%	r	Reduced rank
% 	opts	(optional) Options to eigs 
%	method	(optional, defaults to 'epsilon') 
%		'sa'		eigs('sa'); works only when 0 is not
%				an eigenvalue of L 
%		'epsilon'	special -epsilon method; may be
%				faster, especially if zero is an
%				eigenvalue of L 
%		'lm'		Method without inverse iteration;
%				uses less memory, but is slower  
%		'lsqr'		Use lsqr(); this method is
%				experimental and very slow
% 
% RESULT 
% 	U 	(n*r) eigenvectors
%	D	(r*r) eigenvalues as diagonal matrix
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function [U D] = konect_eigl(L, r, opts, method)

EPSILON_DEFAULT = 1e-3; 

format long; 

if ~exist('method', 'var')
    method = 'epsilon';
    % Disabled because it didn't work - eigs() would always return
    % all zero eigenvalues. 
    if 0 
    %    if length(L) >= 6
    %    if length(L) >= 600000
        method = 'lm';
    end
end

if ~exist('opts', 'var')
    opts = struct(); 
end

if isfield(opts, 'disp')
    disp = opts.disp; 
else
    disp = 0; 
end

if size(L,1) <= 1

    U = zeros(size(L,1), 1);
    D = 0;
        
else

    if strcmp(method, 'sa')

        if disp
            fprintf(1, 'EIGL: using sigma=0\n');
        end
        [U,D] = eigs(L, r, 'sa', opts); 

    elseif strcmp(method, 'epsilon')

        if disp
            fprintf(1, 'EIGL: using sigma = -epsilon\n'); 
        end
            
        epsilon = EPSILON_DEFAULT; 
        [U,D] = eigs(L , r, -epsilon, opts);  
        dd = diag(D); 

        % Sort by increasing eigenvalues
        [s,i] = sort(dd); 
        dd = dd(i); 
        D = diag(dd); 
        U = U(:, i); 

    elseif strcmp(method, 'lm')

        if disp
            fprintf(1, 'EIGL: using sigma= lambda_max method\n'); 
        end

        [U1 D1] = eigs(L, 1, 'lm', opts);
        lambda_max = D1(1,1)     

        n = size(L,1); 
        [U D] = eigs(lambda_max * speye(n) - L, r, 'lm', opts);

        diag_D_1 = diag(D)

        if ~(max(diag_D_1) > 0)
            D = diag(load_eig());
        end

        D = lambda_max * eye(r) - D; 

        diag_D_2 = diag(D)

        [x i] = sort(diag(D)); 
        U = U(:,i);  
        D = D(i,i); 

    elseif strcmp(method, 'lsqr')

        % This method is VERY slow. 
        if disp
            fprintf(1, 'EIGL:  using method LSQR\n'); 
        end

        opts.issym = 1; 
        
        [U D] = eigs(@(x)(mysolve(L,x)), size(L,1), r, 'sa', opts)

    end

end

end

function [x] = mysolve(A,b)

    maxit = 1000; % lsqr() will apparently use a value of 20 instead, and therefore we have to iterate. 

    [x flag] = lsqr(A, b, [], 1000);

    while  flag == 1
        %        fprintf(1, '.\n'); 
        [x flag] = lsqr(A, b, [], 1000, [], [], x); 
    end

end
