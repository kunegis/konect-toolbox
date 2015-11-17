%
% Draw a spectral diagonality test matrix.  This uses imagesc() with a
% colorbar.  This draws the real part of the matrix only. 
%
% See Section 3.2.4 (page 37) in:  Jérôme Kunegis, "On the Spectral
% Evolution of Large Networks", PhD Thesis, University of
% Koblenz-Landau, 2011.  
%
% This function is also used to draw other matrices. 
%
% PARAMETERS 
%	Delta	(r*r) Spectral diagonality test matrix
%

function konect_imageubu(Delta)

damp = .5; 
steps = 200; 
font_size = 24; 

Delta = real(Delta); 

imagesc(Delta);
colorbar; 
axis square; 

smin = min(min(Delta));
smax = max(max(Delta)); 

s = smin:((smax-smin)/steps):smax; 

dist = max(smax, -smin); 

s_green = min(1 - damp * s/dist, 1 + s/dist) .^ 2; 
s_red   = min(1 + damp * s/dist, 1 - s/dist) .^ 2; 
s_blue  = min(1 + s/dist, 1 - s/dist) .^ 2; 

cm = [s_red' s_green' s_blue']; 
colormap(cm); 

set(gca, 'FontSize', font_size); 
