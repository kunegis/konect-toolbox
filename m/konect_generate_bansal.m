%
% The algorithm from Bansal et al., i.e., Equation 6 in [1].  Also
% described in [2]. 
%
% RESULT 
%	A	(n*n) Half-adjacency matrix
%
% PARAMETERS 
%	n	Number of nodes
%	d	(n*1) Requested degree vector
%	c	Requested clustering coefficient
% 
% REFERENCES 
%  [1] Evolving Clustered Random Networks, Shweta Bansal and Shashank
%      Khandelwal and Lauren Ancel Meyers, 2014
%  [2] Exploring Biological Network Structure with Clustered Random
%      Networks, BMC Bioinformatics 10(1), 2009, pp. 1--15. 
%

function A = konect_generate_bansal(n, d, c_req)

% 0:  no checks
% 1:  checks
disp = 0; 

% Maximum number of iterations.  Should not be reached.  I.e., the
% number of triangles should reach the requested value before this
% is attained. 
i_max = 100000000; 

consts = konect_consts(); 

%
% Generate initial graph
%
A = simul_generate_configuration(n, d);  

%
% Perform switchings
%

% Number of wegdes; never changes with this rewiring scheme
s = konect_statistic_twostars (A, consts.SYM, consts.UNWEIGHTED)

% Current number of triangles
t_cur = konect_statistic_triangles(A, consts.SYM, consts.UNWEIGHTED) 

% Requested number of triangles
t_req = c_req * s / 3

% Current degree vector
d = sum(A,2) + sum(A,1)'; 

i = 0; 

% Number of triangles at last output
t_last = -Inf; 

% Iteration count at last increase
i_last = 1000; 

t = konect_timer(2 * i_last); 

for i = 1 : i_max
%while t_cur < t_req

    t = konect_timer_tick(t, i); 

    % Break if number of triangles has not increased since 50%
    % of the run. 
    if i > 2 * i_last,
        break;
    end

    % i = i + 1;
    % if i > i_max,  break;  end;
    
    % Selected random node with degree at least 2
    xs = find(d > 1);
    x = xs(randi(length(xs))); 

    % Select two neighbours of x that have degree at least 2  
    ny = A(:,x) | A(x,:)' | (d > 1);
    ny(x) = 0;
    nys = find(ny); 
    if length(nys) < 2,  continue;  end; 
    y1i = randi(length(nys)); 
    while 1
        y2i = randi(length(nys));
        if y1i == y2i,  continue;  end;
        break;
    end
    y1 = nys(y1i);
    y2 = nys(y2i); 
    
    % Select a neighbor z1 of y1 that is not x or y2
    nz1 = A(:,y1) | A(y1,:)';
    nz1(x) = 0;
    nz1(y2) = 0;
    nz1s = find(nz1);
    if length(nz1s) < 1,  continue;  end;
    z1 = nz1s(randi(length(nz1s))); 

    % Select a neighbour z2 of y2 that is not x, y1 or z1 
    nz2 = A(:,y2) | A(y2,:)';
    nz2(x) = 0;
    nz2(y1) = 0;
    nz2(z1) = 0;
    nz2s = find(nz2);
    if length(nz2s) < 1,  continue;  end;
    z2 = nz2s(randi(length(nz2s)));

    % If (y1,y2) and (z1,z2) do not exist, rewire:
    % (y1,z1),(y2,z2) -> (y1,y2),(z1,z2)
    if A(y1,y2) | A(y2,y1) | A(z1,z2) | A(z2,z1)
        continue;
    end

    % 'perform switch  (y1,z1),(y2,z2) -> (y1,y2),(z1,z2)'

    if disp > 0
        t_cur_test = konect_statistic_triangles(A, consts.SYM, consts.UNWEIGHTED); 
        assert(t_cur == t_cur_test); 
    end

    t_old = t_cur; 

    % 'Remove (y1,z1)'
    A(y1,z1) = 0;
    A(z1,y1) = 0;
    t_diff = sum((A(y1,:)' | A(:,y1)) & (A(:,z1) | A(z1,:)'));
    t_cur = t_cur - t_diff;

    if disp > 0
        t_cur_test = konect_statistic_triangles(A, consts.SYM, consts.UNWEIGHTED); 
        assert(t_cur == t_cur_test); 
    end

    % 'Remove (y2,z2)'
    A(y2,z2) = 0;
    A(z2,y2) = 0;
    t_diff = sum((A(y2,:)' | A(:,y2)) & (A(:,z2) | A(z2,:)'));
    t_cur = t_cur - t_diff;

    if disp > 0
        t_cur_test = konect_statistic_triangles(A, consts.SYM, consts.UNWEIGHTED);
        assert(t_cur == t_cur_test); 
    end

    % 'Add (y1,y2)'
    A(y1,y2) = 1;
    t_diff = sum((A(y1,:)' | A(:,y1)) & (A(:,y2) | A(y2,:)'));
    t_cur = t_cur + t_diff;

    if disp > 0
        t_cur_test = konect_statistic_triangles(A, consts.SYM, consts.UNWEIGHTED);
        assert(t_cur == t_cur_test); 
    end

    % 'Add (z1,z2)'
    A(z1,z2) = 1;
    t_diff = sum((A(z1,:)' | A(:,z1)) & (A(:,z2) | A(z2,:)'));
    t_cur = t_cur + t_diff;

    if disp > 0
        t_cur_test = konect_statistic_triangles(A, consts.SYM, consts.UNWEIGHTED); 
        assert(t_cur == t_cur_test); 
    end

    % If it's not an improvement, take the switch back
    
    if t_old > t_cur
        A(y1,z1) = 1;
        A(y2,z2) = 1;
        A(y1,y2) = 0;
        A(z1,z2) = 0;

        t_cur = t_old; 

        if disp > 0
            t_cur_test = konect_statistic_triangles(A, consts.SYM, consts.UNWEIGHTED); 
            assert(t_cur == t_cur_test); 
        end

        i_last = i;
        t = konect_timer_set(t, 2 * i_last); 

    else
        if t_cur > t_old
            if t_last + 0 < t_cur
                fprintf(1, '    T = %u -> %u\n', t_cur, t_req); 
                t_last = t_cur; 
            end
        end
        if t_cur >= t_req,  break;  end;
    end

end

konect_timer_end(t); 
