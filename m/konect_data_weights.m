%
% Data about WEIGHTS values
%
% RESULT 
%	negative(WEIGHTS)	Whether the adjacency matrix contains negative values
%

function [negative] = konect_data_weights()

consts = konect_consts(); 

negative(consts.UNWEIGHTED)    = 0;
negative(consts.POSITIVE)      = 0;
negative(consts.SIGNED)        = 1;
negative(consts.WEIGHTED)      = 1;
negative(consts.MULTIWEIGHTED) = 1; 
negative(consts.POSWEIGHTED)   = 0;
negative(consts.DYNAMIC)       = 0; 
