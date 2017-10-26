%
% Timer class.  This is used to output the remaining time on the log
% of a long computation.  See konect_clusco.m for example usage. 
%
% Note: it is important to assign the result of konect_timer_tick()
% to the timer object. 
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.cc
%	(c) Jerome Kunegis 2017; this is Free Software released under
%	the GPLv3, see COPYING. 
%

classdef konect_timer

    properties
        time_begin
        time_last
	time_threshold
        n 
        count_my;   
    end

    methods

        % Create a timer with N iterations. 
        function this = konect_timer(n)
            persistent count; 

            if (n < 0)
                count = count - 1; 
                return; 
            end
            
            this.time_begin = clock; 
            this.time_last = this.time_begin; 
            this.n = n; 
            if ~size(count), count = 0; end;
            this.count_my = count; 
            count = count + 1; 
            this.time_threshold = 10; % seconds
        end

        function this = konect_timer_tick(this, i)

            assert(i >= 0); 
            
            time_now = clock; 

            time_diff = etime(time_now, this.time_last); 
            if (time_diff < this.time_threshold)
                return; 
            end

            this.time_last = time_now; 

            time_diff = etime(time_now, this.time_begin); 
            left = time_diff * (this.n - i + 1) / (i - 1); 
            text = konect_timer_text(this, left);
            if this.count_my > 0 
                fprintf(1, '%d of %d {%s left}\n', i - 1, this.n, text); 
            else
                fprintf(1, '%d of %d [%s left]\n', i - 1, this.n, text); 
            end
        end

        function text = konect_timer_text(this, t)
            if t < 3600
                text = sprintf('%d:%02d', floor(t/60), mod(floor(t), 60)); 
            elseif t < 3600 * 24
                text = sprintf('%d:%02d:%02d', floor(t/3600), mod(floor(t/60), 60), mod(floor(t), 60)); 
            else
                text = sprintf('%d-%02d:%02d:%02d', floor(t/3600/24), mod(floor(t/3600), 24), mod(floor(t/60), 60), mod(floor(t), 60)); 
            end
        end 

        function this = konect_timer_end(this)
            e = etime(this.time_last, this.time_begin);
            if e ~= 0
                text = konect_timer_text(this, 0); 
                if this.count_my > 0 
                    fprintf(1, '%d of %d {%s left}\n', this.n, this.n, text); 
                else
                    fprintf(1, '%d of %d [%s left]\n', this.n, this.n, text); 
                end
            end
            konect_timer(-1); 
        end

        % Set new value of N, i.e. of the total number of
        % iterations 
        function this = konect_timer_set(this, n_new)
            this.n = n_new; 
        end

    end
end
