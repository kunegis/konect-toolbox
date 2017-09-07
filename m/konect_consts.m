%
% Numerical constants used in KONECT.  The list of values and their
% numerical values are prescribed by the KONECT handbook. 
%
% RESULT 
%	A struct containing all constants as fields, with all-uppercase
%	names; see below
%

function [consts symbols_format symbols_weights labels_format labels_weights] = konect_consts()

consts = {};

%
% Format
%
consts.SYM  = 1;  % Undirected network; adjacency matrix contains edge
                  % edge only once, and A + A' is used implicitly
consts.ASYM = 2;  % Directed network, 
consts.BIP  = 3;  % Bipartite network; the biadjacency matrix is passed

consts.FORMAT_COUNT = 3;

%
% Weights
%
consts.UNWEIGHTED       = 1;
consts.POSITIVE         = 2;
consts.POSWEIGHTED      = 3;
consts.SIGNED           = 4;
consts.MULTISIGNED      = 5;
consts.WEIGHTED         = 6;
consts.MULTIWEIGHTED    = 7;
consts.DYNAMIC 	     	= 8;
consts.MULTIPOSWEIGHTED = 9;

consts.WEIGHTS_COUNT = 9;

%
% Symbols
%

symbols_format{consts.SYM } = 'U';
symbols_format{consts.ASYM} = 'D';
symbols_format{consts.BIP } = 'B';

symbols_weights{consts.UNWEIGHTED      } = '$-$';
symbols_weights{consts.POSITIVE        } = '$=$';
symbols_weights{consts.POSWEIGHTED     } = '$+$';
symbols_weights{consts.SIGNED          } = '$\pm$';
symbols_weights{consts.MULTISIGNED     } = '$\stackrel{+}{=}$';
symbols_weights{consts.WEIGHTED        } = '$*$';
symbols_weights{consts.MULTIWEIGHTED   } = '$_*{}^*$';
symbols_weights{consts.DYNAMIC         } = '$\rightleftarrows$';
symbols_weights{consts.MULTIPOSWEIGHTED} = '$++$';

%
% Labels
%

labels_format{consts.SYM}	= 'Unipartite, undirected';
labels_format{consts.ASYM}	= 'Unipartite, directed';
labels_format{consts.BIP}	= 'Bipartite, undirected';

labels_weights{consts.UNWEIGHTED}	= 'Unweighted, no multiple edges';
labels_weights{consts.POSITIVE}		= 'Unweighted, multiple edges';
labels_weights{consts.POSWEIGHTED}	= 'Positive weights, no multiple edges';
labels_weights{consts.SIGNED}		= 'Signed, no multiple edges';
labels_weights{consts.MULTISIGNED}	= 'Signed, multiple edges';
labels_weights{consts.WEIGHTED}		= 'Ratings, no multiple edges';
labels_weights{consts.MULTIWEIGHTED}	= 'Ratings, multiple edges';
labels_weights{consts.DYNAMIC}		= 'Dynamic';
labels_weights{consts.MULTIPOSWEIGHTED} = 'Positive weights, multiple edges';


