%
% Names and related information for plots. 
%
% In fields, dashes are replaced by double underscores and dots by
% triple underscores. 
%
% RETURN VALUES
%	labels_plot	Names of plot types; in lower case and in the
% 			singular
%

function [labels_plot] = konect_data_plot()
  
labels_plot = struct();

labels_plot.assortativity		= 'degree assortativity plot'; 
labels_plot.bidd			= 'cumulative degree distribution';
labels_plot.cluscod			= 'clustering coefficient distribution'; 
labels_plot.degcc			= 'average neighbor degree distribution'; 
labels_plot.degree			= 'degree distribution';
labels_plot.delaunay			= 'Delaunay graph drawing';
labels_plot.diadens			= 'diameter/density evolution';
labels_plot.distr___sym			= 'spectral distribution of the adjacency matrix';
labels_plot.distr___sym__n		= 'spectral distribution of the normalized adjacency matrix'; 
labels_plot.distr___lap			= 'spectral distribution of the Laplacian'; 
labels_plot.hopdistr			= 'hop plot'; 
labels_plot.hopdistr_time___full	= 'temporal hop plot'; 
labels_plot.layout			= 'Fruchterman–Reingold graph drawing';
labels_plot.lorenz			= 'Lorenz curve'; 
labels_plot.lybl			= 'double Laplacian graph drawing';
labels_plot.map___sym			= 'spectral graph drawing based on the adjacency matrix';
labels_plot.map___stoch			= 'spectral graph drawing based on the normalized adjacency matrix';
labels_plot.map___lap			= 'spectral graph drawing based on the Laplacian'; 
labels_plot.outin			= 'in/outdegree scatter plot';
labels_plot.rating_evolution		= 'item rating evolution';
labels_plot.rating_evolution2		= 'rating class evolution';
labels_plot.time_histogram		= 'temporal distribution';
labels_plot.time_histogram_signed	= 'signed temporal distribution';
labels_plot.weights			= 'edge weight distribution'; 
labels_plot.zipf			= 'Zipf plot';
