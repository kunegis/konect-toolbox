%
% The readable names of statistics. 
%
% RESULT 
% 	ret	A string of the format "NAME ($EXPRESSION$)", in
% 		which NAME is the readable name, and EXPRESSION is a
% 		Latex expression for the mathematical symbol; subsets
% 		of this can be output by setting the "type" parameter 
%
% PARAMETERS 
%	statistic 	The statistic; in addition to statistic
%			names, the following are also supported: 
%			m, n, mpn
%	type		optional, default is 'latex'
%		'latex' 	For Latex 
%		'latex-short'	For Latex, only the expression
%				(without the surrounding $ signs)
%		'matlab'	For Matlab plots
%		'matlab-short'	For Matlab plots, only the expression 
%

function ret = konect_label_statistic(statistic, type)

if ~exist('type', 'var')
    type = 'latex'; 
end

%
% Note:  the Latex expressions must be compatible with Matlab, which
% means that we don't use \mathrm{...}, which appears in quite a few
% of the official expressions in the KONECT Handbook. 
%

if     strcmp(statistic, 'm'), 			ret = 'Nodes ($m$) [vertices]'; 
elseif strcmp(statistic, 'n'), 			ret = 'Nodes ($n$) [vertices]'; 
elseif strcmp(statistic, 'mpn'),		ret = 'Nodes ($n$) [vertices]';       
elseif strcmp(statistic, 'size'),		ret = 'Size ($n$) [vertices]'; 
elseif strcmp(statistic, 'size+2'),		ret = 'Left size ($n_1$) [vertices]'; 
elseif strcmp(statistic, 'size+3'),		ret = 'Right size ($n_2$) [vertices]'; 
elseif strcmp(statistic, 'volume'), 		ret = 'Volume ($m$) [edges]'; 
elseif strcmp(statistic, 'fill'), 		ret = 'Fill ($p$) [edges / vertex^2]';
elseif strcmp(statistic, 'diameter'), 		ret = 'Effective diameter ($\delta_{0.9}$) [edges]'; 
elseif strcmp(statistic, 'diam'),		ret = 'Diameter ($\delta$) [edges]'; 
elseif strcmp(statistic, 'diam+3'),		ret = '50-percentile effective diameter ($\delta_{0.5}$) [edges]'; 
elseif strcmp(statistic, 'diam+4'),		ret = 'Mean path length ($\delta_m) [edges]'; 
elseif strcmp(statistic, 'avgdegree'), 		ret = 'Average degree ($d$) [edges / vertex]';  
elseif strcmp(statistic, 'avgdegree+4'),	ret = 'Average number of neighbors'; 
elseif strcmp(statistic, 'clusco'),    		ret = 'Clustering coefficient ($c$)'; 
elseif strcmp(statistic, 'cluscoall+5'),    	ret = 'Relative signed clustering coefficient ($c_r$)'; 
elseif strcmp(statistic, 'cluscoall+7'),    	ret = 'Clustering coefficient, variant 2 ($c_2$)'; 
elseif strcmp(statistic, 'power'),		ret = 'Power law exponent ($\gamma$)'; 
elseif strcmp(statistic, 'powerv'),		ret = 'Power law exponent ($\gamma$)'; 
elseif strcmp(statistic, 'power2'),		ret = 'Power law exponent ($\gamma$)'; 
elseif strcmp(statistic, 'rank'), 		ret = 'Rank ($\syRank$)'; 
elseif strcmp(statistic, 'alcon')		ret = 'Algebraic connectivity ($a$)';
elseif strcmp(statistic, 'alconn')		ret = 'Normalized algebraic connectivity ($a_n$)';
elseif strcmp(statistic, 'dentropy') 		ret = 'Edge distribution entropy ($H_e$) [nat]'; 
elseif strcmp(statistic, 'dentropyn')		ret = 'Relative edge distribution entropy ($H_{er}$)'; 
elseif strcmp(statistic, 'dentropy2') 		ret = 'Degree distribution entropy ($H_d$) [nat]'; 
elseif strcmp(statistic, 'network_rank_sq')	ret = 'Fractional network rank ($rank_F$)'; 
elseif strcmp(statistic, 'network_rank_abs')	ret = 'Absolute network rank ($rank_*$)'; 
elseif strcmp(statistic, 'network_rank_norm')	ret = 'Normalized network rank ($rank_N$)'; 
elseif strcmp(statistic, 'network_rank_norm4')	ret = 'Random walk return probability ($\vartheta_r(n)$)'; 
elseif strcmp(statistic, 'epower')		ret = 'Eigenvalue power law exponent ($\alpha$)'; 
elseif strcmp(statistic, 'entropy')		ret = 'Spectral entropy ($H_s$) [nat]';
elseif strcmp(statistic, 'entropyn')		ret = 'Normalized spectral entropy ($H_{sn}$)'; 
elseif strcmp(statistic, 'aredis')		ret = 'Average resistance distance ($aredis$)'; 
elseif strcmp(statistic, 'coco')		ret = 'Size of LCC ($N$) [vertices]';
elseif strcmp(statistic, 'coco+2')		ret = 'Relative size of LCC';
elseif strcmp(statistic, 'coco+4')		ret = 'Relative size of left LCC';
elseif strcmp(statistic, 'coco+6')		ret = 'Relative size of right LCC';
elseif strcmp(statistic, 'cocos')		ret = 'Size of LSCC ($N_s$) [vertices]';
elseif strcmp(statistic, 'cocos+2')		ret = 'Relative size of LSCC';
elseif strcmp(statistic, 'snorm')		ret = 'Spectral norm ($||A||_2$)'; 
elseif strcmp(statistic, 'separation')		ret = 'Spectral separation ($|\lambda_1[A] / \lambda_2[A]|$)';
elseif strcmp(statistic, 'separationl')		ret = 'Laplacian spectral separation ($\lambda_3[L] / \lambda_2[L]$)';
elseif strcmp(statistic, 'gini')		ret = 'Gini coefficient ($G$)'; 
elseif strcmp(statistic, 'controllability')	ret = 'Driver node count ($N_D$) [vertices]';
elseif strcmp(statistic, 'controllabilityn')	ret = 'Relative driver node count ($C_r$) [vertices]';
elseif strcmp(statistic, 'conflict')		ret = 'Algebraic conflict ($\xi$)';
elseif strcmp(statistic, 'conflict+2')		ret = 'Relative relaxed frustration ($\xi n / 8 m$)';
elseif strcmp(statistic, 'conflictn')		ret = 'Normalized algebraic conflict ($\xi_n$)';
elseif strcmp(statistic, 'runtime')		ret = 'Runtime [s]'; 
elseif strcmp(statistic, 'asymmetry')		ret = 'Spectral asymmetry ($\zeta$)'; 
elseif strcmp(statistic, 'own')			ret = 'Balanced inequality ratio ($P$)'; 
elseif strcmp(statistic, 'radius')		ret = 'Spectral radius ($\rho$)'; 
elseif strcmp(statistic, 'maxdegree')		ret = 'Maximum degree ($d_{max}$) [edges]'; 
elseif strcmp(statistic, 'jain') 		ret = ['Jain' '''' 's index ($J$)']; 
elseif strcmp(statistic, 'prefatt') 		ret = 'Preferential attachment exponent ($\beta$)'; 
elseif strcmp(statistic, 'prefatt+2') 		ret = 'Root-mean-square logarithmic error ($\epsilon$)'; 
elseif strcmp(statistic, 'prefatt+3') 		ret = 'Preferential attachment exponent ($\beta$)'; 
elseif strcmp(statistic, 'patest')		ret = 'Relative size of largest degree ($ln(d_{max}) / ln(|V|)$)'; 
elseif strcmp(statistic, 'reciprocity') 	ret = 'Reciprocity ($y$)'; 
elseif strcmp(statistic, 'triangles')		ret = 'Triangle count ($t$)'; 
elseif strcmp(statistic, 'anticonflict')	ret = 'Approximate normalized frustration ($b_K$)'; 
elseif strcmp(statistic, 'oddcycles')		ret = 'Odd cycle ratio ($b_2$)'; 
elseif strcmp(statistic, 'nonbip')		ret = 'Non-bipartivity ($b_A$)'; 
elseif strcmp(statistic, 'nonbipn')		ret = 'Normalized non-bipartivity ($b_N$)'; 
elseif strcmp(statistic, 'weight')		ret = 'Weight ($w$)'; 
elseif strcmp(statistic, 'negativity')		ret = 'Negativity ($\zeta$)'; 
elseif strcmp(statistic, 'triangles_normuni')	ret = ['Uniformized triangle count ($t' '''' '$)'];     
elseif strcmp(statistic, 'clusco_normuni')	ret = ['Uniformized clustering coefficient ($c' '''' '$)'];     
elseif strcmp(statistic, 'clusco_norm_p')	ret = 'Orthogonalized clustering coefficient ($c / p$)';
elseif strcmp(statistic, 'triangles_norm_p')	ret = 'Orthogonalized triangle count ($t / (p^3 (n ; 3))$)';
elseif strcmp(statistic, 'twostars')		ret = 'Wedge count ($s$)'; 
elseif strcmp(statistic, 'twostars_normuni')	ret = ['Uniformized wedge count ($s' '''' '$)']; 
elseif strcmp(statistic, 'uniquevolume')	ret = 'Unique edges ($\bar{\bar m}$)';
elseif strcmp(statistic, 'lines')		ret = 'Data volume ($m_D$)';
elseif strcmp(statistic, 'twostars_norm_p')	ret = 'Orthogonalized wedge count'; 
elseif strcmp(statistic, 'twostars_coef') 	ret = 'Preferential attachment coefficient';
elseif strcmp(statistic, 'twostars_norm_d')	ret = 'Twostars factor ($s_d$)'; 
elseif strcmp(statistic, 'clusco_n')		ret = 'N-Clusco ($sqrt(n) c$)'; 
elseif strcmp(statistic, 'twostars_perf')	ret = 'Twostars perf';
elseif strcmp(statistic, 'volume_normuni')	ret = ['Uniformized volume ($m' '''' '$)']; 
elseif strcmp(statistic, 'meandist')		ret = 'Mean distance ($\delta_m$)'; 
elseif strcmp(statistic, 'squares')		ret = 'Square count ($q$)'; 
elseif strcmp(statistic, 'tour4')		ret = '4-tour count ($T_4$)'; 
elseif strcmp(statistic, 'threestars')		ret = 'Claw count ($z$)';
elseif strcmp(statistic, 'fourstars')		ret = 'Cross count ($x$)';
elseif strcmp(statistic, 'assortativity')	ret = 'Assortativity ($\rho$)';
elseif strcmp(statistic, 'mediandist')		ret = 'Median distance ($\delta_M$)';
elseif strcmp(statistic, 'relmaxdegree')	ret = 'Relative maximum degree ($d_{MR}$)';
elseif strcmp(statistic, 'cocorel')		ret = 'Relative size of LCC ($N_{rel}$)'; 
elseif strcmp(statistic, 'cocorelinv')		ret = 'Inv. Rel. LCC ($N_{inv}$)'; 
elseif strcmp(statistic, 'degone')		ret = 'Proportion of degree-one nodes ($d_1$)';
elseif strcmp(statistic, 'diameff50'),		ret = '50-percentile effective diameter ($\delta_{0.5}$) [edges]'; 
elseif strcmp(statistic, 'diameff90'), 		ret = '90-percentile effective diameter ($\delta_{0.9}$) [edges]'; 
elseif strcmp(statistic, 'dconflict'),		ret = 'Dyadic conflict ($\eta$)'; 
    
else
    error(sprintf('*** Invalid statistic %s', statistic)); 
end

if strcmp(type, 'latex')

    % Do nothing

elseif strcmp(type, 'latex-short')
    
    % Keep what is inside the $s
    ret = regexprep(ret, '^[^\$]+(\$', '');
    ret = regexprep(ret, '\$)[^\$]*$', ''); 
    
elseif strcmp(type, 'matlab')

    % Remove "$" 
    ret = regexprep(ret, '\$', ''); 

elseif strcmp(type, 'matlab-short')

    ret = regexp(ret, '\$(.+)\$', 'tokens');
    if length(ret)
        ret = ret{1}; ret = ret{1}; 
    else
        ret = statistic; 
    end

end
