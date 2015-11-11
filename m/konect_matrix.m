%
% Construct a characteristic graph matrix, given the adjacency or
% biadjacency matrix of a graph.  The returned matrix corresponds to the
% matrix used the corresponding decomposition. 
%
% For decompositions which are only applied to the largest connected
% component, this functions does not return a matrix restricted to
% that set of nodes. 
%
% In addition to the usual decompositions, the argument DECOMPOSITION
% can be:
%
%	'bip'		The bipartite double cover, i.e., return 
%			[0 A; A' 0]
%	'svd-n'		Works for all matrices regardless of format,
%			and does binormalization; equivalent to
%			konect_normalize_matrix() 
%	'symfull'	The full symmetric adjacency matrix (even for
%			bipartite matrices) 
%	'sym-nfull'	The full symmetric adjacency matrix
%			corresponding to 'sym-n'
%
% RESULT 
%	B		(n1*n2) The matrix corresponding to the given
%			decomposition; sparse 
%	d_u,d_v		(n1*1, n2*1) Normalization factors; [] if no
%			normalization is performed 
%
% PARAMETERS 
%	decomposition	Decomposition name, e.g., 'lap'
%	A		(n1*n2) Adjacency or biadjacency matrix; sparse
%	format		(optional) The network format.  Default is
%			ASYM when A is square and BIP otherwise  
%	weights		(optional) The network weights type.  Default
%			is WEIGHTED.  This parameter is ignored for
%			most decompositions 
%	opts		(optional) Passed to eigs()/svds()
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function [B d_u d_v] = konect_matrix(decomposition, A, format, weights, opts)

consts = konect_consts(); 

if ~exist('opts', 'var'), opts = struct(); end 

if ~exist('format', 'var')
    if size(A,1) == size(A,2)
        format = consts.ASYM;
    else
        format = consts.BIP; 
    end
end

if ~exist('weights', 'var')
    weights = consts.WEIGHTED; 
end

d_u = [];
d_v = []; 

if strcmp(decomposition, 'quantum') | length(regexp(decomposition, '^quantum[0-9]+$', 'start'))

    t = regexp(decomposition, '^quantum([0-9]+)$', 'tokens');
    
    if length(t)
        xxx = t{1}; 
        xxx = xxx{1}; 
        n = sscanf(xxx, '%u'); 
        epsilon = 1e-3 * n; 
    else
        epsilon = 2e-2; 
    end

    B = exp(i * epsilon) * A + exp(-i * epsilon) * A'; 

    return; 
end

switch decomposition

  case 'sym'

    if format == consts.BIP
        B = A; 
    else
        B = A + A';
    end

  case 'sym-n'

    if format == consts.BIP
        [B d_u d_v] = konect_normalize_matrix(A); 
    else
        [n,tmp] = size(A); 
        A_abs = konect_absx(A); 

        d_u = sum(A_abs + A_abs',2)  .^ -.5;
        d_u(d_u ~= d_u) = 1;
        d_u = spdiags(d_u, [0], n, n);

        B = d_u * (A + A') * d_u; 
    end

  case {'diag', 'diag-n', 'dedicom1u', 'dedicom1v', 'dedicom2', ...
        'dedicom2s', 'dedicom3', 'dedicom3-0', 'takane'} 

    B = A; 

  case 'mskew'

    if format ~= consts.ASYM, error('*** Only applies to directed networks'); end; 
    epsilon = 0.5;
    B = A * (1 + epsilon) + A' / (1 + epsilon); 

  case 'lapquantum'

    if format ~= consts.ASYM, error('*** Only applies to directed networks'); end; 
    n = size(A,1); 
    epsilon = 2e-2;
    A_a = A - A'; 
    [x y z] = find(A_a);
    z = exp(i * epsilon * z);
    q = sparse(x, y, z, n, n); 
    d = spdiags(sum(abs(q), 2), [0], n, n); 
    B = d - q;  

  case {'herm', 'hermi'}
    
    if format ~= consts.ASYM, error('*** Only applies to directed networks'); end; 
    B = sqrt(0.5) * (A + A' + i * (A - A')); 

  case 'skewi'

    if format ~= consts.ASYM, error('*** Only applies to directed networks'); end; 
    B = i * (A - A');   

  case 'lapq'
   
    if format == consts.BIP
        [m,n] = size(A); 
        A_bip = [sparse(m,m) A; A' sparse(n,n)]; 
        B = spdiags(sum(konect_absx(A_bip))', [0], m+n, m+n) + A_bip; 
    else 
        n = size(A,1); 
        A_abs = konect_absx(A); 
        B = spdiags(sum(A_abs + A_abs')', [0], n, n) + (A + A');
    end

  case 'lapqu'

    if weights ~= consts.POSITIVE
        A = A ~= 0; 
    end

    if format == consts.BIP
        [m,n] = size(A); 
        A_bip = [sparse(m,m) A; A' sparse(n,n)]; 
        B = spdiags(sum(konect_absx(A_bip))', [0], m+n, m+n) + A_bip; 
    else 
        n = size(A,1); 
        A_abs = konect_absx(A); 
        B = spdiags(sum(A_abs + A_abs')', [0], n, n) + (A + A');
    end

  case {'lap', 'lapc'}

    if format == consts.BIP
        [m,n] = size(A); 
        ab = [sparse(m,m) A; A' sparse(n,n)]; 
        B = spdiags(sum(konect_absx(ab))', [0], m+n, m+n) - ab; 
    else 
        n = size(A,1); 
        abs_A = konect_absx(A); 
        B = spdiags(sum(abs_A + abs_A')', [0], n, n) - A - A';
    end

  case 'lap-n'

    if format == consts.BIP
        [m,n] = size(A); 
        ab = [sparse(m,m) A; A' sparse(n,n)]; 
        B = spdiags(sum(konect_absx(ab))', [0], m+n, m+n) - ab; 
    else 
        n = size(A,1); 
        abs_A = konect_absx(A); 
        B = spdiags(sum(abs_A + abs_A')', [0], n, n) - A - A';
    end

    B = konect_normalize_matrix(B); 

  case 'lapherm'

    [n nx] = size(A); 
    H = sqrt(0.5) * (A + A' + i * (A - A'));
    B = spdiags(sum(abs(H), 2), [0], n, n) - H; 

  case 'lapherm2'

    [n nx] = size(A); 
    A_abs = konect_absx(A);
    D_1 = spdiags(sum(A_abs, 2) , [0], n, n);
    D_2 = spdiags(sum(A_abs, 1)', [0], n, n);
    B = D_1 - A + D_2 - A' + i * (D_2 - D_1 - A + A'); 

  case 'lapskew'

    [n nx] = size(A); 
    s = i * (A - A');
    B = spdiags(sum(abs(s), 2), [0], n, n) - s; 
    
  case 'lapherms'

    % Alternative definition of the Hermitian Laplacian;  the smallest
    % eigenvalue of this is nonzero even for symmetric networks. 

    [n nx] = size(A); 
    
    h = sqrt(0.5) * (A + A' + i * (A - A'));

    B = spdiags(sum(abs(A),1)'+sum(abs(A),2), [0], n, n) - h; 
    
  case 'laphermt'

    [n nx] = size(A); 
    
    h = sqrt(0.5) * (A + A' + i * (A - A'));

    B = spdiags((sum(abs(A),1)'+sum(abs(A),2))/sqrt(2), [0], n, n) - h; 
    
  case 'laphermu'

    [n nx] = size(A); 
    
    h = sqrt(0.5) * (A + A' + i * (A - A'));

    B = spdiags((sum(abs(A),1)'+sum(abs(A),2))*sqrt(2), [0], n, n) - h; 
    
  case 'lapherm2'

    [n nx] = size(A); 
    
    h = 0.5 * (A + A' + i * (A - A'));

    B = spdiags((sum(abs(A),1)'+sum(abs(A),2))*sqrt(2), [0], n, n) - h; 

  case 'skew'

    B = A - A'; 

  case 'skewn'
   
    A = konect_normalize_matrix(A); 
    B = A - A'; 

  case 'hermn'

    B = A + A' + i * (A - A');
    B = konect_normalize_matrix(B); 

  case 'lapd'

    [m n] = size(A); 
    if islogical(A)
        A_abs = A;
    else
        A_abs = abs(A); 
    end
    dd = sum(A_abs, 2);
    dd_pinv = dd .^ -1;  dd_pinv(isinf(dd_pinv)) = 0;

    % The transition matrix (right stochastic) [264.2]
    P = spdiags(dd_pinv, [0], m, n) * konect_absx(A); 
    [uu dd] = eigs(P', 1, 'lm', opts); 
    
    % The Perron vector [264.2] 
    phi = uu / sum(uu); 

    PHI = spdiags(phi, [0], m, n); 
    B = PHI - 0.5 * (PHI * P + P' * PHI); 

  case 'lapd-n'
    
    [m n] = size(A); 
    A_abs = konect_absx(A); 
    dd = full(sum(A_abs, 2));
    dd_pinv = dd .^ -1;
    dd_pinv(isinf(dd_pinv)) = 0;
    dd_pinv(dd_pinv ~= dd_pinv) = 0;

    % The transition matrix (right stochastic) [264.2]
    P = spdiags(dd_pinv, [0], m, n) * konect_absx(A); 
    [uu dd] = eigs(P', 1, 'lm', opts);

    % The Perron vector [264.2] 
    phi = uu / sum(uu);

    sPHI =  spdiags(phi.^0.5, [0], m, n); 
    PHIzeros = find(abs(phi) < 1e-10);
    msPHI = phi.^-0.5;
    msPHI(PHIzeros) = 0;
    msPHI = spdiags(msPHI, [0], m, n); 
    B = speye(m) - 0.5 * (sPHI * P * msPHI + msPHI * P' * sPHI);

  case {'stoch', 'stoch1', 'stochbip'}
    [m n] = size(A); 
    A_abs = konect_absx(A); 
    d_u = sum(A_abs, 2);
    dd_pinv = d_u .^ -1;  dd_pinv(isinf(dd_pinv)) = 0;
    B = spdiags(dd_pinv, [0], m, m) * A;

  case 'stoch2'
    [m n] = size(A);
    A_abs = konect_absx(A);
    dd = sum(A_abs, 1)'; 
    dd_pinv = dd .^ -1;  
    dd_pinv(isinf(dd_pinv)) = 0; 
    B = A * spdiags(dd_pinv, [0], m, n); 

  case 'back'

    % 0.2 is the traditional KONECT value for that parameter; there is no
    % other reason for it.  
    alpha = 0.2; 
    B = A + alpha * A'; 

  case 'svd-n'

    [B d_u d_v] = konect_normalize_matrix(A); 

  case 'svd'

    B = A; 

  case 'symfull'

    if format == consts.BIP
        [m n] = size(A); 
        B = [ sparse(m,m) A ; A' sparse(n,n) ]; 
    else
        B = A + A'; 
    end

  case 'sym-nfull'

    if format == consts.BIP
        [A d_u d_v] = konect_normalize_matrix(A); 
        [m n] = size(A); 
        B = [ sparse(m,m) A ; A' sparse(n,n) ]; 
    elseif format == consts.SYM | format == consts.ASYM
        A = A + A';
        [B d_u d_v] = konect_normalize_matrix(A); 
    else
        error('format'); 
    end

  case 'bip'

    [m n] = size(A);
    B = [ sparse(m,m) A ; A' sparse(n,n) ]; 

  case 'symabs'

    B = A ~= 0; 

  case 'symc'
    
    B = A; 

  otherwise
    error(sprintf('*** Invalid decomposition %s', decomposition)); 
end
