%
% Colors used for drawing statistic graphs consistently. 
%
% RESULT 
%	colors			Struct by statistic
%		.(statistic)	(1*3) Color
%	line_styles		Struct by statistic
%		.(statistic)	(string) line style
%	markers			Struct by statistic
%		.(statistic)	(string) marker 
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.1.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under the GPLv3, see COPYING.
%

function [colors line_styles markers] = konect_styles_statistic()

colors = struct(); 
line_styles = struct(); 
markers = struct(); 


colors.power2 		= [ 1   0   0  ];
colors.gini		= [ 0   1   0  ];
colors.own		= [ 0   1   1  ];
colors.dentropy		= [ 0   0   1  ];
colors.dentropyn	= [ 1   0   1  ];
colors.dentropy2	= [ .8  .8  0  ];
colors.volume		= [ 0   0   0  ];
colors.twostars		= [ 1   0   0  ];
colors.triangles	= [ .7  .7  0  ]; 
colors.diam		= [ 0   1   1  ]; 
colors.meandist		= [ 0   .8  .8 ]; 
colors.squares 		= [ 0   0   1  ]; 
colors.snorm		= [ 1   1   0  ];
colors.alcon		= [ 0   .6  0  ];
colors.threestars	= [ 0   .8  0  ]; 
colors.fourstars	= [ .7  0   1  ]; 
colors.clusco		= [ .6  .4  0  ]; 
colors.size		= [0.12 0.99 0.74]; 
colors.avgdegree	= [0.23 0.13 0.11];
colors.twostars_norm_d	= [0.65 0.16 0.75];
colors.maxdegree	= [0.45 0.99 0.44]; 
colors.nonbip		= [0.92 0.80 0.79];
colors.assortativity	= [0.07 0.29 0.90];
colors.jain		= [0.66 0.21 0.92];
colors.relmaxdegree	= [0.29 0.02 0.70];
colors.cocorelinv	= [0.14 0.64 0.43];
colors.degone		= [0.91 0.00 0.35];
colors.diameff50	= [0.29 0.70 0.28];
colors.diameff90	= [0.60 0.64 0.46];


