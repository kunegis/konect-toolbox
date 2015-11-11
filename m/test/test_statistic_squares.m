%
% Test the function that counts the number of squares in a
% network. 
%

cd ..

consts = konect_consts(); 

%
% Test graphs
%
Ats.edge = [ 1 2 ]; 
Ats.twostar = [ 1 2; 2 3 ];
Ats.triangle = [ 1 2; 2 3; 3 1 ]; 
Ats.path3 = [ 1 2 ; 2 3 ; 3 4 ]; 
Ats.square = [ 1 2; 2 3; 3 4; 4 1];
Ats.k4 = [ 1 2 ; 1 3 ; 1 4; 2 3 ; 2 4; 3 4]; 
Ats.foursquare = [1 2; 1 3; 2 3; 2 6; 3 4; 3 7; 4 5; 4 8; 5 8; 5 9; ...
                 6 7; 7 8; 8 9; 8 10; 9 10]
Ats.k5 = [ 1 2; 1 3; 1 4; 1 5; 2 3; 2 4; 2 5; 3 4; 3 5; 4 5]; 

%
% Correct number of squares in each
%
counts.edge = 0;
counts.twostar = 0;
counts.triangle = 0;
counts.path3 = 0;
counts.square = 1;
counts.k4 = 3; 
counts.foursquare = 4;
counts.k5 = 15; 

names = fieldnames(Ats);

for i = 1 : length(names)
    name = names{i}
    At = Ats.(name);
    count = counts.(name); 

    n = max(max(At)); 
    A = full(sparse(At(:,1), At(:,2), 1, n, n)); 

    values = konect_statistic_squares(A, consts.SYM, consts.UNWEIGHTED); 

    assert(values(1) == count); 
end
