%
% Simple neighborhood-based link predictions.  Only for unipartite
% networks.  See (Lü 2011) for the meaning of the TYPE parameter. 
%
% PARAMETERS 
%	type	'common', 'sorensen', 'hpi', 'hdi', 'lhni', 'adad',
%		'ra', 'cosine', 'jaccard', etc.  
%	A	(n*n) Half-adjacency matrix, not symmetric; must be real 
%	E	(e*2) Indexes of vertex pairs.  Typically this is the test set.
%	format	How to interpret A; must be SYM or ASYM
%	variant	(optional, defaults to 'sym') 
%		How to handle directed edges in the prediction; must
%		be 'sym' when format is SYM 
%		'sym'	Ignore edge direction (SYM and ASYM)
%		'asym'	Directed triangle closing
%		'out'	Compare outlinks
%		'in'	Compare inlinks 
%
% RESULTS 
%	prediction	(e*1) prediction values
%
% REFERENCES 
%	Lu, Linyuan; Zhou, Tao. Link Prediction in Complex Networks:
%	A Survey. Physica A, 390(6), pp. 1150--1170, 2011. 
% 
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function [prediction] = konect_predict_neib(type, A, E, format, variant)

if ~exist('variant', 'var')
    variant = 'sym'; 
end

consts = konect_consts(); 

n = size(A, 1); 
e = size(E, 1); 

% The abs* variants are equivalent to the * variants, except that all
% edges are interpreted as positive.  
if length(type) > 3, if type(1:3) == 'abs'
        A = konect_absx(A);
        type = type(4:end);
    end; end

if format == consts.SYM
    if ~strcmp(variant, 'sym'); error('*** Invalid variant'); end
    A_i = A + A'; 
    A_j = A_i;
elseif format == consts.ASYM
    if strcmp(variant, 'sym')
        A_i = A + A';
        A_j = A_i; 
    elseif strcmp(variant, 'asym')
        A_i = A;
        A_j = A'; 
    elseif strcmp(variant, 'out')
        A_i = A;
        A_j = A;
    elseif strcmp(variant, 'in')
        A_i = A';
        A_j = A'; 
    end
else
    error('*** Unsupported format'); 
end

w_i = sum(konect_absx(A_i), 2); 
w_j = sum(konect_absx(A_j), 2); 

%
% ADAD & RA
% 

if strcmp(type, 'adad') & strcmp(type, 'ra'); 
    
    f_i = sum(A_i,1);  
    f_j = sum(A_j,1); 

    if strcmp(type, 'adad')
        f_i = log(max(2, f_i));
        f_j = log(max(2, f_j));
    end

    A_i = A_i * spdiags(f_i .^ -0.5, [0], n, n); 
    A_j = A_j * spdiags(f_j .^ -0.5, [0], n, n); 

end


%
% COSINE
% 
if strcmp(type, 'cosine')
    ww_i = w_i .^ -0.5;
    ww_i(isinf(ww_i)) = 0;
    A_i = spdiags(ww_i, [0], n,n) * A_i; 

    ww_j = w_j .^ -0.5;
    ww_j(isinf(ww_j)) = 0;
    A_j = spdiags(ww_j, [0], n,n) * A_j; 
end

%
% JACCARD
%
if strcmp(type, 'jaccard')
    A_i_abs = konect_absx(A_i); 
    A_j_abs = konect_absx(A_j);  
end

%
% Prediction
%
prediction = zeros(e, 1); 

[k, from, to] = konect_fromto(1, e, 100); 

t = konect_timer(e); 

for l = 1:k

    t = konect_timer_tick(t, from(l)); 

    range = from(l) : to(l); 

    i = E(range, 1);
    j = E(range, 2); 

    line = A_i(i,:) .* A_j(j,:); 

    index = sum(line, 2);

    if strcmp(type, 'common')
        % noop (included as a check for invalid TYPE values)
    elseif strcmp(type, 'sorensen')
        index = index ./ (w_i(i) + w_j(j)); 
    elseif strcmp(type, 'hpi')
        index = index ./ min(w_i(i), w_j(j));  
    elseif strcmp(type, 'hdi')
        index = index ./ max(w_i(i), w_j(j));  
    elseif strcmp(type, 'lhni')
        index = index ./ (w_i(i) .* w_j(j)); 
    elseif strcmp(type, 'jaccard')
        index = index ./ sum(A_i_abs(i,:) | A_j_abs(j,:), 2); 
    elseif strcmp(type, 'adad')
        % noop
    elseif strcmp(type, 'ra')
        % noop
    elseif strcmp(type, 'cosine') 
        % noop 
    else
        error; 
    end

    prediction(range, 1) = index; 
end

konect_timer_end(t); 

% This happens by design for Jaccard when both nodes have no neighbors. 
prediction(find(isnan(prediction))) = 0; 
