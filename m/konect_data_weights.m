%
% Data about WEIGHTS values
%
% RESULT 
%	negative	Whether the adjacency matrix contains negative values
%	interval_scale	Whether the values are from an interval scale
%

function [negative, interval_scale] = konect_data_weights()

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
