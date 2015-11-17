%
% Compute the average degree [avgdegree].
%
% The main average degree (lines [1] to [3]) does take into account
% multiple edges.  Only the "unique" variants do not take into
% account multiple edges.  
%
% For directed networks, the returned value is the total (out+in)
% degree.  The average outdegree and average indegree are both the
% half of this. 
%
% PARAMETERS 
%	A	Adjacency matrix
%	format	
%	weights
%
% RESULT 
%	values	Column vector of results
%		[1]	Global average degree
%		[2]	Average left degree (BIP)
%		[3]	Average right degree (BIP)
%		[4]	Global unique average degree
%		[5]	Average unique left degree (BIP)
%		[6]	Average unique right degree (BIP)
%

function values = konect_statistic_avgdegree(A, format, weights)

consts = konect_consts();

% Reduce A to be the unweighted adjacency matrix, potentially
% including multiple edges. 
if weights == consts.UNWEIGHTED
    % noop
elseif weights == consts.POSITIVE
    % noop
elseif weights == consts.POSWEIGHTED
    A = (A ~= 0); 
elseif weights == consts.SIGNED
    A = (A ~= 0);
elseif weights == consts.WEIGHTED
    A = (A ~= 0);
elseif weights == consts.MULTIWEIGHTED
    % With only the adjacency matrix available, we cannot recover
    % edge multiplicities, and thus ignore multiple edges. 
    A = (A ~= 0);
elseif weights == consts.DYNAMIC
    % noop 
end

% Total number of edges
if weights == consts.POSITIVE
    m = sum(sum(A));
    m_unique = nnz(A); 
else
    m = nnz(A); 
    m_unique = m;
end

if format == consts.BIP

    [n_1 n_2] = size(A); 
    
    values = [ 2 * m / (n_1 + n_2) ; ...
               m / n_1 ; ...
               m / n_2 ; ...
               2 * m_unique / (n_1 + n_2) ; ...
               m_unique / n_1 ; ...
               m_unique / n_2 ]; 

elseif format == consts.SYM || format == consts.ASYM

    n = size(A, 1); 
    
    values = [ 2 * m / n ; ...
               0 ; 0 ;
               2 * m_unique / n ; ...
               0 ; 0 ]; 
               
else
    error('*** Invalid format'); 
end

