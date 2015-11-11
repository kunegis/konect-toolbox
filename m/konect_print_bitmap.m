
% Print a PNG

function konect_print_bitmap(filename)

% Determines the size of the bitmap 
% Larger values seem to produce blank or clipped pages in Matlab 
factor = 5;

try 

    pp = get(gcf, 'PaperPosition'); 
    pp(3:4) = factor * pp(3:4); 
    set(gcf,'PaperUnits','inches','PaperPosition', pp);
    print(filename, '-dpng');

catch err

    delete(filename);

end

close all;

