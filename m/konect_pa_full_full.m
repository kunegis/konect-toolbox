%
% Compute statistics from a single preferential attachment
% distribution.  This is based on the plot in [751:Fig. 2]. 
%
% This is an extended version of konect_pa_full(), with code that does
% not work with GNU Octave (only Matlab). 
%
% PARAMETERS 
%	i_1	(e_1 * 1) IDs of all old vertices 
%	i_2	(e_2 * 1) IDs of all new vertices
%	w_1	(e_1 * 1) Weights of all old vertices, or 1 for uniform weights
%	w_2	(e_2 * 1) Weights of all new vertices, or 1 for uniform weights
%
% RETURN VALUE
%	ret			Values
%		.$method	For each method, see below (the
%				letters in parentheses)
%				A vector of parameter values
%		.lambda
%		.lambda_1
%	ret_data		Related data
%		.xx .yy .xxx
%

function [ret ret_data] = konect_pa_full_full(i_1, w_1, i_2, w_2)

% Regularizarion parameter
lambda = 0.1;
lambda_1 = 1; 

% Number of vertices
n = max(max(i_1), max(i_2)); 

% (n*1) 
% The degree of each vertex
d_1 = sparse(i_1, 1, w_1, n, 1);
d_2 = sparse(i_2, 1, w_2, n, 1);

% Regularization
d_1 = d_1;
d_2 = d_2 + lambda; 

% Maximum degree 
d_max = max(d_1); 

% (d_max*1) 
% Degree distribution, i.e., frequency of degree 
% Indexes are degree values, values are number of nodes with that degree
freq_1 = sparse(d_1+1, 1, 1, d_max+1, 1);  freq_1 = freq_1(2:end);

% (d_max*1)
% Total number of new edges for nodes for given degree.  Indexes are
% degrees.  Values are number of new edges attached to nodes of that
% degree.  
summ = sparse(d_1+1, 1, d_2, d_max+1, 1);  summ = summ(2:end); 

% (d_max*1)
% Total sum of squares of new degrees for nodes with given old degree. 
sumsq = sparse(d_1+1, 1, d_2 .^ 2, d_max+1, 1);  sumsq = sumsq(2:end); 

% The points on the plot
xx = find(freq_1 > 0);

yy = summ(xx) ./ freq_1(xx); 

yy_dev = ((sumsq(xx) ./ freq_1(xx)) - (summ(xx) ./ freq_1(xx)) .^ 2) .^ 0.5; 

%
% (a) a * x
%
fact_a = xx \ yy
ret.a = [ fact_a ]; 

% Log of new degrees
d_geo_2 = log(d_2);


sum_geo = sparse(d_1+1, 1, d_geo_2, d_max+1, 1);  sum_geo = sum_geo(2:end); 

sumsq_geo = sparse(d_1+1, 1, d_geo_2 .^ 2, d_max+1, 1);  sumsq_geo = sumsq_geo(2:end); 

yy_geo = sum_geo(xx) ./ freq_1(xx);


% The YY values computed geometrically.  
yy_geo_orig = exp(yy_geo); 

% The additive error in the geometric domain.  This is the sample standard deviation.
yy_dev_log_geo = (((sumsq_geo(xx) ./ freq_1(xx)) - (sum_geo(xx) ./ freq_1(xx)) .^ 2) .* freq_1(xx) ./ (freq_1(xx) - 1)) .^ 0.5; 

% The multiplicative error, i.e., the actual values are multiplied or divied by these values 
yy_dev_geo = exp(yy_dev_log_geo);

%
% (e) Direct method
%

arg_1 = [log(d_1 + lambda_1) ones(length(d_1),1)]; 

arg_2 = log(d_2); 

assert(0 == sum(sum(~isfinite(arg_1)))); 
assert(0 == sum(sum(~isfinite(arg_2)))); 

[fact_e tmp mse_e ] = lscov(arg_1, arg_2)
ret.e = [ fact_e ; mse_e ]; 

%
% (f) First 10 degrees
%

N = 10; 
iii = find(d_1 <= N);
size_iii = size(iii)
if size(iii) < 5
    % This may happen when the network has a minimum degree. 
    ret.f = [ NaN ; NaN ; NaN ];
else
    [fact_f tmp mse_f] = lscov([log(d_1(iii) + lambda_1) ones(length(iii),1)], log(d_2(iii))); 
    ret.f = [ fact_f ; mse_f ]; 
end

%
% (g) Last 99%
%

d_limit = 0.01 * d_max;
iii = find(d_1 > d_limit);
[fact_g tmp mse_g] = lscov([log(d_1(iii) + lambda_1) ones(length(iii),1)], log(d_2(iii))); 
ret.g = [ fact_g ; mse_g ]; 

%
% Save
%

ret.lambda = lambda; 
ret.lambda_1 = lambda_1; 

ret_data.xx = xx;
ret_data.yy = yy;
ret_data.yy_dev = yy_dev;
ret_data.yy_geo_orig = yy_geo_orig;
ret_data.yy_dev_geo = yy_dev_geo;
ret_data.d_1 = d_1;
ret_data.d_2 = d_2;
