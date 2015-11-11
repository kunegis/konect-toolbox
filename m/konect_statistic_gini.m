%
% Compute the Gini coefficient [gini].
%
% PARAMETERS 
%	A	Adjacency / biadjacency matrix
%	format
% 	weights
%	opts	(optional) 
%
% RESULT 
%	values	The Gini coefficients
%		[1] 	Total coefficient
%		[2,3] 	Left/right coefficients (only ASYM and BIP) 
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function values = konect_statistic_gini(A, format, weights, opts)

consts = konect_consts(); 

if weights == consts.POSITIVE
    has_z = 1; 
    [x y z] = find(A);
else
    has_z = 0; 
    [x y] = find(A); 
end

p = [x; y]; 
if has_z
    q = [z; z]; 
else
    q = []; 
end

values = konect_gini(p, q);

if format == consts.BIP | format == consts.ASYM

    if has_z
        q = z;
    else
        q = []; 
    end
    
    v1 = konect_gini(x, q);
    v2 = konect_gini(y, q);
    values = [ values ; v1 ; v2 ]; 

end
