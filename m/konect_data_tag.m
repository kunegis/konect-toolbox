%
% Return information about the tags in KONECT.
%
% RETURN VALUES
%	tag_list	List of tags, in preferred KONECT order
%	tag_text	Textual description for each tag
%

function [tag_list tag_text tag_name] = konect_data_tag()

% This order is how the tags are shown to the user.  It goes roughly
% from "simple" to "complex".  
tag_list = { ...
	     'skew', 'path', ...
	     'nonreciprocal', 'acyclic', 'loop', 'clique', 'tournament', ...
	     'trianglefree', 'zeroweight', 'incomplete', 'join', ...
	     'missingorientation', 'missingmultiplicity', ...
	     'kcore', 'lcc', ...
	   };
	     
  
tag_text = struct();

tag_text.acyclic		= 'Does not contain directed cycles';
tag_text.clique			= 'Edges exist between all possible nodes'; 
tag_text.incomplete		= 'Is a snapshot and likely to not contain all data';
tag_text.join			= 'Is the join of an underlying network';
tag_text.kcore			= 'Only nodes with degree larger than a given threshold are included';
tag_text.lcc			= 'Only the largest connected component of the original data is included';
tag_text.loop			= 'Contains loops';
tag_text.missingorientation	= 'Is not directed, but the underlying data is';
tag_text.missingmultiplicity	= 'Does not have multiple edges, but the underlying data has';
tag_text.nonreciprocal		= 'Does not contain reciprocal edges';
tag_text.path			= 'The edges form paths';
tag_text.skew			= 'Inverted edges can be interpreted as negated edges';
tag_text.tournament		= 'All pairs of nodes are connected by a directed edge';
tag_text.trianglefree		= 'Does not contain triangles';
tag_text.zeroweight		= 'Edges may have weight zero';

tag_name = struct();

tag_name.acyclic		= 'Directed cycles';
tag_name.clique			= 'Complete'; 
tag_name.incomplete		= 'Snapshot';
tag_name.join			= 'Join';
tag_name.kcore			= '<I>k</I>-Core';
tag_name.lcc			= 'Connectedness';
tag_name.loop			= 'Loops';
tag_name.missingorientation	= 'Orientation';
tag_name.missingmultiplicity	= 'Multiplicity';
tag_name.nonreciprocal		= 'Reciprocal';
tag_name.path			= 'Paths';
tag_name.skew			= 'Skew-symmetry';
tag_name.tournament		= 'Tournament';
tag_name.trianglefree		= 'Triangles';
tag_name.zeroweight		= 'Zero weights';
