%
% Colors used in various plots. 
%
% Each color represents the "side" from which an analysis is done. This
% is used in many different analyses, so the meaning depends on the
% analysis, but the overall structure is the same, so we use consistent
% colors. 
%
% See the comments below for uses. 
%
function colors = konect_colors_letter()

% All nodes
colors.a      = 	[0 0 1];

% Only left nodes (BIP)
% Only outlinks (ASYM)
colors.u      = 	[1 0 0];

% Only right nodes (BIP)
% Only inlinks (ASYM)
colors.v      = 	[0 0.9 0]; 

% Edge weight distribution
colors.weight = 	[0.7 0.5 0]; 

% Out/in-link comparison 
colors.b      =         [0.5 0.8 0]; 
