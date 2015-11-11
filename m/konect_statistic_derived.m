%
% Computre a derived statistic.
%
% RESULT 
%	values	Volumn vector of values of STATISTIC 
%	
% PARAMETERS 
%	statistic		The statistic to compute
%	statistic_underlying	The statistic of which values are known
%	values_underlying	The known values of the underlying
%				statistic, as a column vector
%	values_size
%	values_volume
%	values_uniquevolume 
%	values_fill		Column vector of FILL statistics
%	values_avgdegree
%
% ABOUT 
%	This file is part of the KONECT Matlab Toolbox version 0.3.
%	konect.uni-koblenz.de
%	(c) Jerome Kunegis 2014; this is Free Software released under
%	the GPLv3, see COPYING. 
%

function values = konect_statistic_derived(statistic, statistic_underlying, ...
                                           values_underlying, ...
                                           values_size, ...
                                           values_volume, ...
                                           values_uniquevolume, ...
                                           values_fill, ...
                                           values_avgdegree)

if strcmp(statistic, 'triangles_norm')

    assert(strcmp(statistic_underlying, 'triangles'));

    t = values_underlying(1); 

    n = values_size(1);
    
    values = (t - (1/48) * n * (n-1) * (n-2)) / sqrt( 7 / 384 * n * (n-1) * (n-2));

elseif strcmp(statistic, 'clusco_norm')

    assert(strcmp(statistic_underlying, 'clusco'));

    c = values_underlying(1); 

    n = values_size(1); 

    values = (c - 0.5) * sqrt(n * (n-1) / 2); 

elseif strcmp(statistic, 'clusco_norm_p')

    assert(strcmp(statistic_underlying, 'clusco'));

    c = values_underlying(1);
    
    p = values_fill(2); 

    values = c / p;

elseif strcmp(statistic, 'triangles_norm_p')

    assert(strcmp(statistic_underlying, 'triangles'));

    t = values_underlying(1);

    n = values_size(1);
    p = values_fill(2); 

    values = t / (p^3 * (1/6) * n * (n-1) * (n-2)); 

elseif strcmp(statistic, 'twostars_norm_p')

    assert(strcmp(statistic_underlying, 'twostars'));

    s = values_underlying(1); 

    n = values_size(1);
    p = values_fill(2); 

    values = s / ( p * p * 0.5 * n * (n-1) * (n-2)); 

elseif strcmp(statistic, 'twostars_coef')

    assert(strcmp(statistic_underlying, 'twostars'));

    s = values_underlying(1); 

    m = values_uniquevolume(1);
    n = values_size(1); 

    values = s / (m * (n - 2)); 

elseif strcmp(statistic, 'twostars_norm_d')

    assert(strcmp(statistic_underlying, 'twostars'));

    s = values_underlying(1);

    n = values_size(1);
    d = values_avgdegree(4);

    values = (s / n) / (0.5 * d * (d-1)); 

elseif strcmp(statistic, 'clusco_n')

    assert(strcmp(statistic_underlying, 'clusco'));

    c = values_underlying(1);

    n = values_size(1);

    values = sqrt(n) * c; 

elseif strcmp(statistic, 'twostars_perf')

    assert(strcmp(statistic_underlying, 'twostars'));

    s = values_underlying(1);
    n = values_size(1);
    m = values_uniquevolume(1);

    values = s / (sqrt(n) * m); 

elseif strcmp(statistic, 'volume_norm')
    
    assert(strcmp(statistic_underlying, 'volume'));
    
    m = values_uniquevolume(1);
    n = values_size(1);
    p = 0.5; 
    
    values = (m - p * (1/2) * n * (n-1)) / sqrt(p * (1-p) * (1/2) * n * (n-1));

elseif strcmp(statistic, 'meandist')

    assert(strcmp(statistic_underlying, 'diam'));

    values = values_underlying(4); 
    
else
    error(sprintf('*** Invalid statistic %s', statistic));
end
