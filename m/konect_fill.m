UNUSED

%
% Computes the fill of a network, i.e., the proportion of existing
% edges to possible edges.  
%
% Note:  loops are always considered possible here. 
%
% PARAMETERS 
%	n1, n2
%	m
%	format
%
% RESULT 
%	fill 
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING.
%

function fill = konect_fill(n1, n2, m, format)

consts = konect_consts(); 

if format == consts.SYM
    
    assert(n1 == n2);
    n = n1;

    fill = m * 2 / n / (n + 1); 

elseif format == consts.ASYM

    assert(n1 == n2);
    n = n1;

    fill = m / n / n;

elseif format == consts.BIP

    fill = m / n1 / n2; 

end

