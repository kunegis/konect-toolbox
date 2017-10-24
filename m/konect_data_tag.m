%
% Return information about the tags in KONECT.
%
% RETURN VALUES
%	tag_list	List of tags, in preferred KONECT order
%	tag_text	Textual description for each tag
%

function [tag_list tag_text tag_name] = konect_data_tag()

% The order is important here.  This order is how the tags are shown to
% the user.  
tag_list = { ...
	     'skew', 'path', ...
	     'nonreciprocal', 'acyclic', 'loop', 'tournament', ...
	     'trianglefree', 'zeroweight', 'incomplete', 'join', ...
	     'missingorientation', 'missingmultiplicity', ...
	     'kcore', 'lcc', ...
	   };
	     
  
tag_text = struct();

tag_text.nonreciprocal		= 'Does not contain reciprocal edges';
tag_text.acyclic		= 'Does not contain directed cycles';
tag_text.loop			= 'Contains loops';
tag_text.tournament		= 'All pairs of nodes are connected by a directed edge';
tag_text.trianglefree		= 'Does not contain triangles';
tag_text.zeroweight		= 'Edges may have weight zero';
tag_text.incomplete		= 'Is incomplete';
tag_text.join			= 'Is the join of an underlying network';
tag_text.path			= 'The edges form paths';
tag_text.missingorientation	= 'Is not directed, but the underlying data is';
tag_text.missingmultiplicity	= 'Does not have multiple edges, but the underlying data has';
tag_text.kcore			= 'Only nodes with degree larger than a given threshold are included';
tag_text.lcc			= 'Only the largest connected component of the original data is included';
tag_text.skew			= 'Inverted edges can be interpreted as negated edges';

tag_name = struct();

tag_name.nonreciprocal		= 'Reciprocal';
tag_name.acyclic		= 'Directed cycles';
tag_name.loop			= 'Loops';
tag_name.tournament		= 'Tournament';
tag_name.trianglefree		= 'Triangles';
tag_name.zeroweight		= 'Zero weights';
tag_name.incomplete		= 'Completeness';
tag_name.join			= 'Join';
tag_name.path			= 'Paths';
tag_name.missingorientation	= 'Orientation';
tag_name.missingmultiplicity	= 'Multiplicity';
tag_name.kcore			= '<I>k</I>-Core';
tag_name.lcc			= 'Connectedness';
tag_name.skew			= 'Skew-symmetry';

