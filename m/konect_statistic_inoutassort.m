%
% Compute the in/outdegree assortativity, i.e., the Pearson correlation
% between the in-degree and the out-degree in directed networks. 
%
% GROUP:  asym
%
% RESULT
%	[1] 	Pearson correlation of log(d+1)
%	[3]	Pearson correlation of log(d), excluding nodes with d=0
%	[5]	Pearson correlation of d
%	[7]	Rank correlation of d (Kendall) 
%	[9]	Rank correlation of d (Spearman) 
%	[2,4,6,8,10]	Corresponding p-values 
%

function values = konect_statistic_inoutassort(A, format, weights)

consts = konect_consts();

assert(size(A,1) == size(A,2));

n = size(A,1);

if weights == consts.POSITIVE | weights == consts.UNWEIGHTED
  % Keep the values
else
  A = (A ~= 0); 
end

d_out = sum(A,2);
d_in  = sum(A,1)';

values = zeros(10,1) * NaN;

[r, p] = corr(log(d_out + 1), log(d_in + 1))
values(1) = r;  values(2) = p;

d_out_log = log(d_out);  d_out_log(d_out == 0) = NaN;
d_in_log  = log(d_in);   d_in_log(d_in == 0)   = NaN;
[r, p] = corr(d_out_log, d_in_log, 'rows', 'complete');
values(3) = r;  values(4) = p;

[r, p] = corr(d_out, d_in)
values(5) = r;  values(6) = p;

[r, p] = corr(d_out, d_in, 'type', 'Kendall');
values(7) = r;  values(8) = p;

[r, p] = corr(d_out, d_in, 'type', 'Spearman');
values(9) = r;  values(10) = p;
