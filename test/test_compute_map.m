%
% Test the MAP computation. 
%

cd ..

% [ at_test prediction ]
data = [ 
1 2 1 .8;  % 1:  1/2
1 3 0 .9;
2 1 1 .9;  % 2:  1
2 3 1 .9;
2 4 0 .7;
3 1 0 .9;  % 3:  1/3
3 2 0 .8;
3 4 1 .7
];

precision = konect_map(data(:,4), data(:,1:3))

if abs(precision - (1/2 + 1 + 1/3)/3) > 1e-10
    error
end
