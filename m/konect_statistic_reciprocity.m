%
% Compute the reciprocity of a directed network, i.e., the proportion
% of edges for which an edge in the opposite direction exists. 
%
% This statistic is always between zero and one.  Zero denotes a
% network in which no directed edge is reciprocated; one denotes a
% network in which all edges are reciprocated.  
%
% Each edge is counted separately, which means that if two edges are
% opposite to each other, they count twice. For instance, the graph
%
%                /------------->
%    * -------> *               *
%                <------------/
%
% has recoprocity 2/3. 
%
% Multiple edges are ignored. 
%
% PARAMETERS 
%	A	Adjacency matrix of a directed graph
%	format
%	weights
%
% RESULT 
%	value	The algebraic asymmetry
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%
% ATTRIBUTE:  asym 
%

function value = konect_statistic_reciprocity(A, format, weights)

consts = konect_consts(); 

if format ~= consts.ASYM
    error('*** reciprocity is only defined for directed networks');
end

A = konect_absx(A); 

value = nnz(A & A') / nnz(A); 
