%
% Names and related information for plots. 
%
% The labels are in the singular and in lower case. 
%
% In fields, dashes are replaced by double underscores and dots by
% triple underscores.
%
% This file contains *both* plots and subplots
%
% RETURN VALUES
%	labels_plot	Names of plot types; in lower case and in the
% 			singular
%

function [labels_plot] = konect_data_plot()
  
labels_plot = struct();

% Plots
labels_plot.assortativity		= 'degree assortativity'; 
labels_plot.bidd			= 'cumulative degree distribution';
labels_plot.cluscod			= 'clustering coefficient distribution'; 
labels_plot.degcc			= 'average neighbor degree distribution'; 
labels_plot.degree			= 'degree distribution';
labels_plot.delaunay			= 'Delaunay graph drawing';
labels_plot.diadens			= 'diameter/density evolution';
labels_plot.distr___sym			= 'spectral distribution of the adjacency matrix';
labels_plot.distr___sym__n		= 'spectral distribution of the normalized adjacency matrix'; 
labels_plot.distr___lap			= 'spectral distribution of the Laplacian'; 
labels_plot.hopdistr			= 'hop distribution'; 
labels_plot.hopdistr_time___full	= 'temporal hop distribution'; 
labels_plot.inter			= 'inter-event distribution';
labels_plot.inter2			= 'node-level inter-event distribution';
labels_plot.layout			= 'Fruchterman–Reingold graph drawing';
labels_plot.lorenz			= 'Lorenz curve'; 
labels_plot.lybl			= 'double Laplacian graph drawing';
labels_plot.map___sym			= 'spectral graph drawing based on the adjacency matrix';
labels_plot.map___stoch			= 'spectral graph drawing based on the normalized adjacency matrix';
labels_plot.map___lap			= 'spectral graph drawing based on the Laplacian'; 
labels_plot.outin			= 'in/outdegree scatter plot';
labels_plot.rating_evolution		= 'item rating evolution';
labels_plot.rating_evolution2		= 'rating class evolution';
labels_plot.syngraphy			= 'SynGraphy'; 
labels_plot.time_histogram		= 'temporal distribution';
labels_plot.time_histogram_signed	= 'signed temporal distribution';
labels_plot.weights			= 'edge weight/multiplicity distribution'; 
labels_plot.zipf			= 'Zipf plot';

% Subplots
labels_plot.assortativity___a		= 'overall degree assortativity';
labels_plot.assortativity___u		= 'left/outdegree assortativity';
labels_plot.assortativity___v		= 'right/indegree assortativity'; 
labels_plot.bidd___ax			= 'overall cumulative degree distribution';
labels_plot.bidd___ux			= 'cumulative left/outdegree degree distribution';
labels_plot.bidd___vx			= 'cumulative right/indegree degree distribution';
labels_plot.bidd___uvx			= 'comparison of cumulative left-right/in-out degree distributions';
labels_plot.degree___a			= 'overall degree distribution';
labels_plot.degree___u			= 'left/outdegree distribution';
labels_plot.degree___v			= 'right/indegree distribution';
labels_plot.delaunay___a		= 'Delaunay graph drawing (double)';
labels_plot.delaunay___b		= 'Delaunay graph drawing (single)'; 
labels_plot.delaunay___f		= 'Delaunay graph drawing with spring layout';
labels_plot.delaunay___g		= 'Delaunay graph drawing (uniformized) '; 
labels_plot.hopdistr___a		= 'hop distribution (unscaled)';
labels_plot.hopdistr___b		= 'hop distribution (logistic scale)';
labels_plot.hopdistr___c		= 'hop distribution (Cauchy scale)'; 
labels_plot.hopdistr___d		= 'hop distribution (hyperbolic secant scale)'; 
labels_plot.hopdistr___e		= 'hop distribution (normal scale)'; 
labels_plot.hopdistr___f		= 'hop distribution (Weibull scale)';
labels_plot.hopdistr___g		= 'hop distribution (exponential scale)';
labels_plot.hopdistr_time___full___a	= 'temporal hop distribution (by vertex pairs)';
labels_plot.hopdistr_time___full___b	= 'temporal hop distribution (by reachable vertices)'; 
labels_plot.hopdistr_time___full___c	= 'temporal hop distribution (relative)'; 
labels_plot.inter2___a			= 'overall node-level inter-event distribution';
labels_plot.inter2___u			= 'left/outdegree node-level inter-event distribution';
labels_plot.inter2___v			= 'right/indegree node-level inter-event distribution';
labels_plot.lorenz___a			= 'overall Lorenz curve';
labels_plot.lorenz___u			= 'left/outdegree Lorenz curve';
labels_plot.lorenz___v			= 'right/indegree Lorenz curve';
labels_plot.lybl___a			= 'double Laplacian graph drawing (plain)';
labels_plot.lybl___b			= 'double Laplacian graph drawing (with clustering)'; 
labels_plot.outin___a			= 'in/outdegree scatter plot (linear scale)';
labels_plot.outin___b			= 'in/outdegree scatter plot (log-log scale)';
labels_plot.outin___c			= 'in/outdegree scatter plot (log-log scale, augmented)';
labels_plot.rating_evolution___a	= 'item rating evolution (non-normalized)';
labels_plot.rating_evolution___b	= 'item rating evolution (normalized)'; 
labels_plot.syngraph___a		= 'SynGraphy with Fruchterman-Reingold'; 
labels_plot.time_histogram___a		= 'temporal distribution';
labels_plot.time_histogram___b		= 'cumulative temporal distribution'; 
labels_plot.weights___b			= 'edge weight histogram';
labels_plot.weights___c			= 'edge multiplicity distribution';
labels_plot.weights___d			= 'cumulative edge multiplicity distribution'; 
labels_plot.zipf___a			= 'overall Zipf plot';
labels_plot.zipf___u			= 'left/outdegree Zipf plot';
labels_plot.zipf___v			= 'right/indegree Zipf plot';
