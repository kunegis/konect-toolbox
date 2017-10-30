%
% Data about WEIGHTS values
%
% RETURN VALUES 
%	negative	Whether the adjacency matrix contains negative values
%	interval_scale	Whether the values are from an interval scale
%	multi		Whether multiple edges are allowed
%

function [negative, interval_scale, multi] = konect_data_weights()

consts = konect_consts(); 

negative(consts.UNWEIGHTED)       = 0;
negative(consts.POSITIVE)         = 0;
negative(consts.POSWEIGHTED)      = 0;
negative(consts.SIGNED)           = 1;
negative(consts.MULTISIGNED)      = 1;
negative(consts.WEIGHTED)         = 1;
negative(consts.MULTIWEIGHTED)    = 1; 
negative(consts.DYNAMIC)          = 0; 
negative(consts.MULTIPOSWEIGHTED) = 0;

interval_scale(consts.UNWEIGHTED)       = 0;
interval_scale(consts.POSITIVE)         = 0;
interval_scale(consts.POSWEIGHTED)      = 0;
interval_scale(consts.SIGNED)           = 0;
interval_scale(consts.MULTISIGNED)      = 0;
interval_scale(consts.WEIGHTED)         = 1;
interval_scale(consts.MULTIWEIGHTED)    = 1; 
interval_scale(consts.DYNAMIC)          = 0; 
interval_scale(consts.MULTIPOSWEIGHTED) = 0;

multi(consts.UNWEIGHTED)       = 0;
multi(consts.POSITIVE)         = 1;
multi(consts.POSWEIGHTED)      = 0;
multi(consts.SIGNED)           = 0;
multi(consts.MULTISIGNED)      = 1;
multi(consts.WEIGHTED)         = 0;
multi(consts.MULTIWEIGHTED)    = 1; 
multi(consts.DYNAMIC)          = 1; 
multi(consts.MULTIPOSWEIGHTED) = 1;
