%
% Decompose an adjacency or biadjacency matrix.
%
% This is a hub for all decomposition algorithms of the form
%
%    A = U D V'.
%
% A decomposition is characterized by
%	* A matrix which is decomposed
%	* A matrix decomposition
%
% The following suffixes are used in the names of decompositions:
%	n - Normalization
%	abs - Ignore edge weights and multiplicities
%	c - Work on largest connected component
%
% There are no other constraints (such as U/V orthogonal or D diagonal
% or nonnegative).  D has size r*r and U and V both have size n*r, in
% which r is the size of the decomposition. 
%
% For the symmetric variants 'sym' 'sym-n', etc., the matrix A
% does not have to be symmetric, A+A' is used automatically. (This is
% the right thing to do even for undirected networks, because in
% undirected networks each edge is only stored once.  In other words,
% the matrix A to pass for undirected networks should *not* be
% symmetric.) 
%
% The returned decomposition may have rank less than the given rank.
% This happens when the given matrices have too low rank.  It also
% happens for decompositions that only work with some R, e.g. the skew
% decomposition needs an even R. 
%
% RESULT 
%	U		(n1*r) The eigenvectors or equivalent (the
%			interpretation depends on the decomposition.)
%			Dominant latent dimensions are returned first.  
%	D		(r*r) The "eigenvalues", or equivalent. 
%	V		(n2*r) The right eigenvectors.  May be [] to denote
%			that it is equal to U. 
%	d_u, d_v	Decomposition factors as returned by
%			normalize(); may be []. 
%	n		Number of nodes considered in the decomposition
%			(e.g., when it is only computed on the largest
%			connected component)
%
% PARAMETERS 
%	decomposition	Decomposition type; in addition to all
%			decomposition as described in the Handbook,
%			this function also supports:
%			symabs:  Same as "sym", but on \bar G,
%			i.e. using the unweighted graph 
%	A		(n1*n2) Half-adjacency or biadjacency matrix, may be logical
%	r		(optional) Rank; default is 6, as in eigs()
%	format		(optional) How to interpret the matrix A;
%			default is ASYM for square matrices 
%			and BIP for nonsquare matrices
%	weights		(optional) How to interpret values in A; default is POSITIVE
%	opts		(optional) Options; all are optional
%	.disp		Passed directly to eigs() and svds() 
%

function [U D V d_u d_v n] = konect_decomposition(decomposition, A, r, format, weights, opts)

consts = konect_consts(); 

% To show more significant digits when opts.disp = 2.
set_format();

if ~exist('r', 'var')
    % The default rank.  We use 6 because Matlab also uses 6 in
    % eigs(). 
    r = 6; 
end 

if ~exist('format', 'var')
    if size(A,1) == size(A,2)
        format = consts.ASYM; 
    else
        format = consts.BIP; 
    end
end
if ~exist('weights', 'var')
    weights = consts.POSITIVE; 
end

if ~exist('opts', 'var'),    
    opts = struct();     
end

[negative] = konect_data_weights();

d_u = [];
d_v = []; 
V = []; 

% Default value of n, may be changed for specific decompositions. 
if format ~= consts.BIP
    n = size(A,1);
else
    n = sum(size(A)); 
end

%
% Decomposition
%

if strcmp(decomposition, 'quantum') | length(regexp(decomposition, '^quantum[0-9]+$', 'start'))

    if format ~= consts.ASYM, error('*** Only applies to directed networks'); end; 
    b = konect_matrix(decomposition, A, format, weights);
    r = min(r, size(b,1)-2); 
    [U D] = eigs(b, r, 'lm', opts);
    % eigs returns the decomposition ordered by decreasing eigenvalue.
    % Change it to be ordered by decreasing absolute eigenvalue. 
    D = real(D); 
    [x i] = sort(-abs(diag(D)));
    U = U(:,i);
    D = D(i,i); 

    return; 
end

switch decomposition

  case 'sym'

    % The eigenvalue decomposition of the underlying undirected
    % network. 

    if format ~= consts.BIP
        r = min(r, size(A,1)); 

        [U D] = eigs(@(x)(A * x + A' * x), size(A, 1), r, 'lm', opts); 

        % eigs returns the decomposition ordered by decreasing eigenvalue.
        % Change it to be ordered by decreasing absolute eigenvalue. 
        [x i] = sort(-abs(diag(D)));
        U = U(:,i);
        D = D(i,i); 
    else % BIP
        r = min(r, size(A,1)-2);     
        [U D V] = svds(double(A), r, 'L', opts); 
    end

  case 'symtop'

    % 'sym', but get only eigenvalues from the top 

    if format ~= consts.BIP
        r = min(r, size(A,1)); 

        [U D] = eigs(@(x)(A * x + A' * x), size(A, 1), r, 'lr', opts); 

        % eigs returns the decomposition ordered by decreasing eigenvalue.
        % Change it to be ordered by decreasing absolute eigenvalue. 
        [x i] = sort(diag(D), 'descend');
        U = U(:,i);
        D = D(i,i); 
    else % BIP
        r = min(r, size(A,1)-2);     
        [U D V] = svds(double(A), r, 'L', opts); 
    end

  case 'sym-n'

    if format ~= consts.BIP
        [A cc n] = konect_connect_matrix_square(A); 
        [a_n, d_u, d_v] = konect_matrix(decomposition, A, format, weights, opts); 
        r = min(r, size(A,1)); 
        [U,D] = konect_eign(a_n, r); 
        U = konect_connect_back(cc, U); 
    else
        [A cc1 cc2 n] = konect_connect_matrix_bipartite(A);   

        [a_n, d_u, d_v] = konect_matrix('svd-n', A, format, weights, opts); 
        r = min([r size(A)]); 
        [U,D,V] = konect_svdn(a_n, r); 

        U = konect_connect_back(cc1, U);
        V = konect_connect_back(cc2, V); 
    end

  case 'svd'
    if format ~= consts.ASYM, error('*** SVD only applies to directed networks'); end; 
    r = min([r size(A)]); 
    [U,D,V] = svds(double(A), r, 'L', opts); 

  case 'svd-n'

    if format ~= consts.ASYM, error('*** SVD-N only applies to directed networks'); end; 

    % Use the bipartite connected component even though the network is
    % unipartite-- this will give the largest connected component in the
    % bipartite double cover.  This is necessary to make sure the
    % eigenvalue 1 has multiplicity at most one. 
    [A cc1 cc2 n] = konect_connect_matrix_bipartite(A);   

    [a_n, d_u, d_v] = konect_matrix(decomposition, A, format, weights, opts); 
    r = min([r size(A)]); 
    [U,D,V] = konect_svdn(a_n, r); 

    U = konect_connect_back(cc1, U);
    V = konect_connect_back(cc2, V); 

  case 'lap'

    [U D V] = konect_decomposition_lap(A, r, format, weights, opts); 

  case 'lapc'

    if format ~= consts.BIP 
        [A cc n] = konect_connect_matrix_square(A);
        l = konect_matrix(decomposition, A, format, weights, opts); 
        r = min(r, size(A,1)); 
        [U,D] = konect_eigl(l, r, opts);
        U = konect_normalize_rows(U); 
        U = konect_connect_back(cc, U); 
    else % bipartite 
        [A cc1 cc2 n] = konect_connect_matrix_bipartite(A); 
        [n1,n2] = size(A); 
        L = konect_matrix(decomposition, A, format, weights, opts); 
        r = min([r n1 n2]); 
        [uu,D] = konect_eigl(L, r, opts);
        U = uu(1:n1, :);
        V = uu((n1+1):(n1+n2), :);
        U = konect_normalize_rows(U); 
        V = konect_normalize_rows(V); 
        U = konect_connect_back(cc1, U);
        V = konect_connect_back(cc2, V); 
    end

    f = diag(D) < 0;
    D(f,f) = 0; 

  case 'diag'
    if format ~= consts.ASYM, error('*** Only applies to directed networks'); end; 

    n = size(A,1);  
    r = min(r, n-1); 

    % Note:  Even though a graph which is not strongly connected will not
    % have a decomposition of this form, it is not necessary to restrict
    % the decomposition to the largest strongly connected component,
    % because the full decomposition will be faithfull on the restriction
    % of the adjacency matrix to the largest strongly connected
    % components. 

    try
        [U D] = eigs(@(x)(A * x), size(A,1), r, 'lm', opts); 
        % V = pinv(U)'; do it using the economic full SVD
        [uu dd vv] = svd(U, 'econ');
        V = uu * pinv(dd) * vv'; 

        [tmp, i] = sort(-abs(diag(D)));
        U = U(:,i);
        D = D(i,i);
        V = V(:,i);   
    catch err
        err.message
        err.stack
        U = zeros(n,r);
        V = zeros(n,r);
        D = zeros(r,r); 
    end

  case 'skew1'
    b = konect_matrix(decomposition, A, format, weights, opts); 
    r = min(r, size(b,1));

    % Because eigenvalue come in conjugate imaginary pairs, we always
    % return an even number of latent dimensions.   
    r = 2 * floor(r/2); 
    [U D] = eigs(b, r, 'lm', opts); 

  case 'skew'

    b = konect_matrix(decomposition, A, format, weights, opts);   
    [U D V] = konect_eigskew(b, r, opts); 

  case 'skewi'
    
    b = konect_matrix(decomposition, A, format, weights, opts); 
    r = min(r, size(b,1)); 
    [U D] = eigs(b, r, 'lm', opts); 
    [tmp, i] = sort(-abs(diag(D)));
    U = U(:,i);
    D = D(i,i); 

  case 'skewn'
    [A cc n] = konect_connect_matrix_square(A); 
    b = konect_matrix(decomposition, A, format, weights, opts); 
    [U D V] = konect_eigskew(b, r, opts); 
    U = konect_connect_back(cc, U); 
    V = konect_connect_back(cc, V); 

  case {'herm', 'hermi'}
    if format ~= consts.ASYM, error('*** HERM only applies to directed networks'); end; 
    b = konect_matrix(decomposition, A, format, weights, opts); 
    r = min(r, size(b,1)); 
    [U D] = eigs(b, r, 'lm', opts); 
    D = real(D);
    [tmp, i] = sort(-abs(diag(D)));
    U = U(:,i);
    D = D(i,i); 

  case 'hermn'
    if format ~= consts.ASYM, error('*** HERMN only applies to directed networks'); end; 
    [A cc n] = konect_connect_matrix_square(A); 
    B = konect_matrix(decomposition, A, format, weights, opts); 
    r = min(r, size(B,1));
    [U D] = konect_eign(B, r); 
    U = konect_connect_back(cc, U); 
    D = real(D); 

  case 'lapd'
    if format ~= consts.ASYM, error('*** LAPD only applies to directed networks'); end; 
    [A cc n] = konect_connect_matrix_strong(A);
    if n <= 1
        U = zeros(n,r);
        D = zeros(r,r);
    else  
        b = konect_matrix(decomposition, A, weights, opts); 
        r = min(r, size(b,1)); 
        [U D] = eigs(b, r, -1e-5, opts); 
        [x i] = sort(diag(D));
        U = U(:,i);
        D = D(i,i);
        
        % Round negative eigenvalue to 0 (they are numerically zero) 
        f = diag(D) < 0; D(f,f) = 0; 
    end
    U = konect_connect_back(cc, U); 

  case 'lapd-n'

    if format ~= consts.ASYM, error('*** LAPD-N only applies to directed networks'); end; 

    [A cc n] = konect_connect_matrix_strong(A);   

    if n <= 1
        U = zeros(n, r);
        D = zeros(r, r); 
    else
        b = konect_matrix(decomposition, A, format, weights, opts);
        r = min(r, size(b,1)); 
        [U D] = eigs(b, r, -0.01, opts); 
        [x i] = sort(diag(D));
        U = U(:,i);
        D = D(i,i);
    end
    U = konect_connect_back(cc, U); 

  case 'stoch'
    % This is the undirected, unweighted stochastic decomposition;
    % ideal for graph drawing 
    if format == consts.SYM
        A = konect_absx(A); 
        [U D V] = konect_decomposition_stoch1(A, r, format, weights, opts); 
        %        U = V;
        V = []; 
    elseif format == consts.ASYM
        A = konect_absx(A);
        A = A + A';
        A = triu(A); 
        [U D V] = konect_decomposition_stoch1(A, r, consts.SYM, weights, opts); 
        % U = V;
        V = []; 
    elseif format == consts.BIP
        [m n] = size(A); 
        A = konect_absx(A); 
        A = [ sparse(m,m), A ; sparse(n,m+n) ]; 
        [U D V] = konect_decomposition_stoch1(A, r, consts.SYM, weights, opts); 
        V = U(m+1:m+n,:); 
        U = U(1:m,:);
    else assert(0);  end;
    D = real(D);
    U = real(U); 

  case 'stoch1'

    [U D V] = konect_decomposition_stoch1(A, r, format, weights, opts); 

  case 'stoch2'

    if format ~= consts.ASYM, error('*** STOCH2 is only defined for directed networks; for other matrices, use STOCH1'); end; 

    [A cc n] = konect_connect_matrix_strong(A); 

    if n <= 1
        U = zeros(n,r);
        V = zeros(n,r);
        D = zeros(r, r); 
    else
        [b] = konect_matrix(decomposition, A, format, weights, opts); 
        r = min(r, size(b,1) - 2); 
        if r >= 3
            try
                opts.maxit = 3000; 
                [U D] = eigs(b, r, 'lm', opts); 

                % do V = pinv(U)' using the economic full SVD
                [uu dd vv] = svd(U, 'econ');  
                V = uu * pinv(dd) * vv'; 

                [tmp, i] = sort(-abs(diag(D)));
                U = U(:,i);
                D = D(i,i);
                V = V(:,i); 
            catch err
                err.message
                err.stack
                U = zeros(n,r);
                V = zeros(n,r);
                D = zeros(r,r); 
            end
        else
            U = zeros(n,3);
            V = zeros(n,3);
            D = zeros(r,r); 
        end
    end
    U = konect_connect_back(cc, U); 
    V = konect_connect_back(cc, V); 

  case 'diag-n'
    if format ~= consts.ASYM, error('*** Only applies to directed networks'); end; 

    [A cc n] = konect_connect_matrix_square(A); 

    [B d_u d_v] = konect_matrix('svd-n', A); 

    try 
        size_B = size(B)
        r
        r = min(r, size(B, 1) - 2)
        [U D] = eigs(B, r, 'lm', opts); 

        [x i] = sort(-abs(diag(D))); 
        U = U(:,i);
        D = D(i,i); 

        % do V = pinv(U)' using the economic full SVD
        [uu dd vv] = svd(U, 'econ');
        V = uu * pinv(dd) * vv'; 

        U = konect_connect_back(cc, U);
        V = konect_connect_back(cc, V); 

    catch err
        err.message
        err.stack
        U = [];   
        D= [];
        V = []; 
        error(); 
    end

  case 'back'

    if format ~= consts.ASYM, error('*** Only applies to directed networks'); end; 
    b = konect_matrix(decomposition, A, format, weights); 
    r = min(r, size(A,1)); 
    [U D V] = svds(b, r, 'L', opts); 

  case 'dedicom1u'

    if format ~= consts.ASYM, error('*** Only applies to directed networks'); end; 
    r = min([r, size(A,1), size(A,2)]); 
    [uu dd vv] = svds(double(A), r, 'L', opts); 
    U = uu;
    D = dd * (vv' * uu);
    [U D] = konect_order_dedicom(U, D); 

  case 'dedicom1v'

    if format ~= consts.ASYM, error('*** Only applies to directed networks'); end; 
    r = min([r, size(A,1), size(A,2)]); 
    [uu dd vv] = svds(double(A), r, 'L', opts); 
    U = vv;
    D = (vv' * uu) * dd;
    [U D] = konect_order_dedicom(U, D); 

  case 'dedicom2'

    if format ~= consts.ASYM, error('*** Only applies to directed networks'); end; 
    r = min([r, size(A,1), size(A,2)]); 
    [uu dd vv] = svds(double(A), r, 'L', opts); 
    
    % The following is equivalent to 
    %   w = uu * dd * uu' + vv * dd * vv';
    %   [U tmp] = eigs(w); 
    dduu = dd * uu'; 
    ddvv = dd * vv'; 

    opts_eigs.disp = opts.disp;
    opts_eigs.issym = 1; 
    [U tmp] = eigs(@(x)(uu * (dduu * x) + vv * (ddvv * x)), size(A, 1), r, 'lm', opts_eigs);

    D = U' * A * U; 
    [U D] = konect_order_dedicom(U, D); 

  case 'dedicom2s'

    if format ~= consts.ASYM, error('*** Only applies to directed networks'); end; 
    r = min([r, size(A,1), size(A,2)]); 
    [uu dd vv] = svds(double(A), r, 'L', opts); 
    
    % The following is equivalent to 
    %   w = uu * dd * uu' + vv * dd * vv';
    %   [U tmp] = eigs(w); 
    dduu = dd^2 * uu'; 
    ddvv = dd^2 * vv'; 
    opts_eigs.disp = opts.disp;
    opts_eigs.issym = 1; 
    [U tmp] = eigs(@(x)(uu * (dduu * x) + vv * (ddvv * x)), size(A, 1), r, 'lm', opts_eigs);

    D = U' * A * U; 
    [U D] = konect_order_dedicom(U, D); 

  case 'dedicom3'

    if format ~= consts.ASYM, error('*** Only applies to directed networks'); end; 

    [U D] = konect_decomposition_dedicom3(A, r, 1, opts); 

  case 'dedicom3-0'

    if format ~= consts.ASYM, error('*** Only applies to directed networks'); end; 
    [U D] = konect_decomposition_dedicom3(A, r, 0, opts); 

  case 'takane'

    if format ~= consts.ASYM, error('*** Only applies to directed networks'); end; 
    [U D] = konect_decomposition_takane(A, r, opts); 

  case 'lapdiag'

    if format ~= consts.ASYM, error('*** Only applies to directed networks'); end; 

    [A cc n] = konect_connect_matrix_square(A); 

    a_abs = konect_absx(A); 
    
    l = spdiags(sum(a_abs,2) + sum(a_abs,1)', [0], n, n) - A; 

    [U D] = konect_eigl(l, r, opts);

    % do V = pinv(U)' it using the economic full SVD
    [uu dd vv] = svd(U, 'econ');
    V = uu * pinv(dd) * vv'; 

    U = konect_connect_back(cc, U); 

  case 'lapherm'

    if format ~= consts.ASYM, error('*** Only applies to directed networks'); end; 
    [A cc n] = konect_connect_matrix_square(A); 
    l = konect_matrix(decomposition, A, format, weights, opts);
    [U D] = konect_eigl(l, min(r, n-1), opts); 
    U = konect_connect_back(cc, U); 

  case 'lapherm2'

    if format ~= consts.ASYM, error('*** Only applies to directed networks'); end; 
    [A cc n] = konect_connect_matrix_square(A); 
    l = konect_matrix(decomposition, A, format, weights, opts);
    [U D] = konect_eigl(l, min(r, n-1), opts); 
    U = konect_connect_back(cc, U); 

  case 'lapskew'

    % For many networks, there are multiple zero eigenvalues returned.
    % Using the strongly connected component instead of only the connected
    % component makes this worse.

    if format ~= consts.ASYM, error('*** Only applies to directed networks'); end; 

    [A cc n] = konect_connect_matrix_square(A); 
    l = konect_matrix(decomposition, A, format, weights, opts);
    r = min(r,n-1)
    if r > 0
        [U D] = konect_eigl(l, r, opts); 
    else
        U = zeros(n,1);
        D = 0; 
    end

    % Round negative values to 0; we know the matrix is positive semidefinite. 

    dd = diag(D);  dd(dd < 0) = 0;  D = diag(dd); 
    
    U = konect_connect_back(cc, U); 

  case 'mskew'

    if format ~= consts.ASYM, error('*** Only applies to directed networks'); end; 
    b = konect_matrix(decomposition, A, format, weights);
    r = min(r, size(b,1)-2); 
    [U D] = eigs(@(x)(b * x), size(b,1), r, 'lm', opts); 
    % do V = pinv(U)' using the economic full SVD
    [uu dd vv] = svd(U, 'econ');
    V = uu * pinv(dd) * vv'; 
    [x i] = sort(-abs(diag(D)));
    U = U(:,i);
    D = D(i,i); 

  case 'lapquantum'

    % In many networks there are multiple zero eigenvalues.  

    if format ~= consts.ASYM, error('*** Only applies to directed networks'); end; 
    [A cc n] = konect_connect_matrix_strong(A); 
    l = konect_matrix(decomposition, A, format, weights);
    [U D] = konect_eigl(l, min(r, n-1), opts); 
    dd = diag(D);
    dd = real(dd);
    dd(dd < 0) = 0;
    D = diag(dd);
    U = konect_connect_back(cc, U); 

  case 'lapq'

    if format ~= consts.BIP 
        [A cc n] = konect_connect_matrix_square(A);
        k = konect_matrix(decomposition, A, format, weights, opts); 
        r = min(r, size(A,1)); 
        [U,D] = konect_eigl(k, r, opts);
        U = konect_connect_back(cc, U); 
    else % BIP
        [A cc1 cc2 n] = konect_connect_matrix_bipartite(A); 
        [m,n] = size(A); 
        k = konect_matrix(decomposition, A, format, weights, opts);
        r = min([r m n]); 
        [uu,D] = konect_eigl(k, r, opts);
        U = uu(1:m, :);
        V = uu((m+1):(m+n), :);
        U = konect_connect_back(cc1, U);
        V = konect_connect_back(cc2, V); 
    end

    % We know LAPQ to be positive-definite, so round all negative eigenvalues to zero.
    dd = diag(D);
    dd(dd < 0) = 0;
    D = diag(dd); 

  case 'lap-n'

    if format ~= consts.BIP 
        [A cc n] = konect_connect_matrix_square(A);
        Z = konect_matrix(decomposition, A, format, weights, opts); 
        Z = 2 * speye(n) - Z; 
        r = min(r, size(A,1)); 
        [U,D,dd] = eigs(Z, r, 'lm', opts);
        D = 2 * speye(r) - D;
        U = konect_connect_back(cc, U); 
    else % BIP
        [A cc1 cc2 n] = konect_connect_matrix_bipartite(A); 
        [m,n] = size(A); 
        Z = konect_matrix(decomposition, A, format, weights, opts); 
        Z = 2 * speye(size(Z,1)) - Z; 
        r = min([r m n]); 
        [uu,D,dd] = eigs(Z, r, 'lm', opts);
        D = 2 * speye(r) - D;
        U = uu(1:m, :);
        V = uu((m+1):(m+n), :);
        U = konect_connect_back(cc1, U);
        V = konect_connect_back(cc2, V); 
    end

    if ~negative(weights)
    %    if weights == consts.UNWEIGHTED | weights == consts.POSITIVE | weights == consts.POSWEIGHTED
        % Numerically, eigs() may return values as high as 1e-15, although
        % we know it is exactly zero.  
        D(1,1) = 0; 
    end

    f = diag(D) < 0;
    D(f,f) = 0; 

  case 'stochbip'

    if format ~= consts.ASYM, error('*** Only applies to directed networks'); end; 

    [A cc1 cc2 n] = konect_connect_matrix_bipartite(A); 

    [mm nn] = size(A); 

    A = konect_matrix('bip', A); 
    A = konect_matrix('stoch2', A, consts.BIP); 

    [UV D] = eigs(A', r, 'lm', opts);

    U = UV(1:mm, :);
    V = UV(mm+1:mm+nn, :); 

    U = konect_connect_back(cc1, U);
    V = konect_connect_back(cc2, V); 

  case 'symabs'

    A = A ~= 0; 

    % The following code is identical to that for SYM. 

    if format ~= consts.BIP
        r = min(r, size(A,1)); 

        [U D] = eigs(@(x)(A * x + A' * x), size(A, 1), r, 'lm', opts); 

        % eigs returns the decomposition ordered by decreasing eigenvalue.
        % Change it to be ordered by decreasing absolute eigenvalue. 
        [x i] = sort(-abs(diag(D)));
        U = U(:,i);
        D = D(i,i); 
    else % BIP
        r = min(r, size(A,1)-2);     
        [U D V] = svds(double(A), r, 'L', opts); 
    end

  case 'symc'

    % Like 'sym', but apply only to the network's largest connected
    % component
    
    if format ~= consts.BIP

        [A cc n] = konect_connect_matrix_square(A);
        r = min(r, size(A,1)); 

        [U D] = eigs(@(x)(A * x + A' * x), n, r, 'lm', opts); 

        % eigs returns the decomposition ordered by decreasing eigenvalue.
        % Change it to be ordered by decreasing absolute eigenvalue. 
        [x i] = sort(-abs(diag(D)));
        U = U(:,i);
        D = D(i,i); 

        U = konect_connect_back(cc, U); 
        
    else % BIP
        [A cc1 cc2 n] = konect_connect_matrix_bipartite(A); 
        r = min(r, size(A,1)-2);     
        [U D V] = svds(double(A), r, 'L', opts); 
        U = konect_connect_back(cc1, U);
        V = konect_connect_back(cc2, V); 
    end

otherwise
    error(sprintf('*** Invalid decomposition type %s', decomposition)); 
end


end

function set_format()

format long; 

end

