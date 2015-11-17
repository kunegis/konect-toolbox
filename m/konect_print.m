%
% Save a plot to a file.  This is used to print all KONECT plots.   
%
% STYLE 
%
% Plots in KONECT follow the following style recommendations: 
%
% * Don't include a title (titles are added in papers using latex)
% * Grid lines are included for the Y axis when the X axis is
%   discrete (or the other way around); otherwise they are omitted. 
% * The plots should be viewable at small size, for papers and the
%   previews on the KONECT website.  As a rule, a user will see an image
%   with a width of about 5cm in both cases.  Remember that the font in
%   plots should be of comparable size to the font in papers or in the
%   browser. 
%
% SIZE 
%
% font_size = 22;  % 18 when the labels contain subscripts 
% line_width = 3; 
%
% COLORS 
%
% Color values used in KONECT plots are defined in
% konect_colors_letter.m. 
%
% The following colors are used in KONECT plots: 
%
% blue:	spectrum
% red:	runtime
% positive/negative values:  green/red, respectively
% left/right distributions in bipartite graphs:  red/green
%    (consistent with navigation lights)
% outlinks/inlinks:  red/green (consistent with left/right
%    distributions in bipartite networks) 
%

function konect_print(filename)

try 
    % "epsc" stands for "EPS color".  The "-d" options sets the device. 
    print(filename, '-depsc'); 

catch err

    delete(filename);
    error(sprintf('Error while printing %s', filename)); 
    
end

close all;
