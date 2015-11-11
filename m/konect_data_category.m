%
% Properties of network categories.  All returned variables are
% structs in which each entry corresponds to a category name (with
% dashes replaced by underscores).
%
% RESULT 
%	colors	The color (as [r g b] vector) used for representing
%		the category 
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function [colors vertices edges markers letters] = konect_data_category()

%
% Color used for each category
%

colors.Affiliation		= [1    0.4  0.4 ];
colors.Animal			= [0.24 0.84 0.32];
colors.Authorship		= [0.8  0    1   ];
colors.Citation			= [0.10 0.16 0.50];
colors.Coauthorship		= [0.81 0.90 0.12];
colors.Communication		= [0    0    1   ];
colors.Computer			= [0.56 0.32 0.69];
colors.Feature			= [0.55 0.55 1   ];
colors.Folksonomy		= [0.08 0.83 0.23];
colors.HumanContact		= [0.86 0.81 0.59];
colors.HumanSocial		= [0.42 0.42 0.37];
colors.Hyperlink		= [1    0.62 0   ];
colors.Infrastructure		= [1.0  0.2  0.2 ];
colors.Interaction		= [0.25 0.75 0.25];
colors.Lexical			= [0	1    0   ];
colors.Metabolic		= [0.58 0.70 0.67]; 
colors.Misc			= [0.85 0.95 0.59];
colors.OnlineContact		= [0.27	0.54 0.95];
colors.Rating			= [0.70 0.70 0   ];
colors.Social			= [0.8  0.7  0   ];
colors.Software			= [0.10 0.37 0.10];
colors.Text			= [0.43 0.52 0.82];
colors.Trophic			= [0.40 0.42 0.61];

vertices.Affiliation		= 'Actors, groups';
vertices.Animal			= 'Animals';
vertices.Authorship		= 'Authors, works';
vertices.Citation		= 'Documents'; 
vertices.Coauthorship		= 'Authors';
vertices.Communication		= 'Persons';
vertices.Computer		= 'Computers';
vertices.Contact		= 'Persons';
vertices.Feature		= 'Items, features';
vertices.Folksonomy		= 'Users, tags, items';
vertices.HumanContact		= 'Persons';
vertices.HumanSocial		= 'Persons';
vertices.Hyperlink		= 'Web page'; 
vertices.Infrastructure		= 'Location';
vertices.Interaction		= 'Persons, items';
vertices.Lexical		= 'Words';
vertices.Metabolic		= 'Metabolites';
vertices.Misc			= 'Various';
vertices.OnlineContact		= 'Users';
vertices.Rating			= 'Users, items';
vertices.Software		= 'Software Component'; 
vertices.Social			= 'Persons';
vertices.Text			= 'Documents, words';
vertices.Trophic		= 'Species';

edges.Affiliation		= 'Membership';
edges.Animal			= 'Tie';
edges.Authorship		= 'Authorship';
edges.Citation			= 'Citation';
edges.Coauthorship		= 'Coauthorship'; 
edges.Communication		= 'Message';
edges.Computer			= 'Connection';
edges.Contact			= 'Interaction';
edges.Feature			= 'Property';
edges.Folksonomy		= 'Tag assignment';
edges.HumanContact		= 'Real-life contact'; 
edges.HumanSocial		= 'Real-life tie';
edges.Hyperlink			= 'Hyperlink';
edges.Infrastructure		= 'Connection'; 
edges.Interaction		= 'Interaction';
edges.Lexical			= 'Lexical relationship';
edges.Metabolic			= 'Interaction'; 
edges.Misc			= 'Various'; 
edges.OnlineContact		= 'Online interaction'; 
edges.Rating			= 'Rating';
edges.Social			= 'Tie';
edges.Software			= 'Dependency'; 
edges.Text			= 'Occurrence';
edges.Trophic			= 'Carbon exchange'; 

% Some of the following are duplicate 

% Unipartite 
markers.Animal			= '+'; 
markers.Citation		= 'o'; 
markers.Coauthorship		= '*';
markers.Communication		= 'x'; 
markers.Computer		= 's'; 
markers.HumanContact		= 'd'; 
markers.HumanSocial		= '^'; 
markers.Hyperlink		= 'v';
markers.Infrastructure		= '>';
markers.Lexical			= '<';
markers.Metabolic		= 'p'; 
markers.Misc			= 'h'; 
markers.OnlineContact		= '+';
markers.Social			= 'o';
markers.Software		= '*';
markers.Trophic			= 'x';

% Bipartite 
markers.Affiliation		= 'o';
markers.Authorship		= '*';
markers.Feature			= 'd';
markers.Folksonomy		= 's';
markers.Interaction		= '+';
markers.Rating			= 'x';
markers.Text			= '^';

% Unipartite 
letters.Animal			= 'A'; 
letters.Citation		= 'I'; 
letters.Coauthorship		= 'O';
letters.Communication		= 'M'; 
letters.Computer		= 'U'; 
letters.HumanContact		= 'C'; 
letters.HumanSocial		= 'S'; 
letters.Hyperlink		= 'H';
letters.Infrastructure		= 'N';
letters.Lexical			= 'L';
letters.Metabolic		= 'E'; 
letters.Misc			= 'X'; 
letters.OnlineContact		= 'T';
letters.Social			= 'Z';
letters.Software		= 'F';
letters.Trophic			= 'P';

% Bipartite 
letters.Affiliation		= 'A';
letters.Authorship		= 'U';
letters.Feature			= 'F';
letters.Folksonomy		= 'O';
letters.Interaction		= 'I';
letters.Rating			= 'R';
letters.Text			= 'T';

