%
% Plot a Delta matrix in analogy for konect_imageubu(), but in which
% Delta may be complex. 
%

function konect_imageubu_complex(Delta)

Delta = Delta / max(max(abs(Delta))); 

for i = 1 : size(Delta,1)
    for j = 1 : size(Delta,2)
        value = Delta(i,j);
        h = angle(value) / (2*pi) + 0.5;
        s = 1;
        v = abs(value); 
        x(i,j,1:3) = hsv2rgb([h s v]);
    end
end

image(x);

axis square;
