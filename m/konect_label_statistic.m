%
% The name and symbol of all statistics.  This file contains all
% metadata that is non-mathematical, i.e., all metadata that does not
% change computations.  
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
%		'html-short'	Symbol of the statistic in HTML, using UTF-8
%		'html-name'	For HTML, name of the statistic, using
% 				UTF-8 for special characters  
%

function ret = konect_label_statistic(statistic, type)

if ~exist('type', 'var')
    type = 'latex'; 
end

%
% For each statistic and substatistic, there is one line below.
% Substatistics are indicated with the '+' sign, as everywhere in
% KONECT.  The given string contains the English name of the statistic,
% the symbol, and the units.
%
% * Name:  This is the label used to represent the statistic; it
%   shouldn't be too long as we use this in axis labels, etc.
% * Symbol:  This is the Latex code between $...$.  It should be short
%   too.  Only simple Latex math is used, namely that which can be
%   converted to HTML by the code at the end of this file. 
% * Unit:  (optional) This is the unit between [brackets].  Not used
%   much.
%
% The Latex expressions must be compatible with Matlab, which
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
elseif strcmp(statistic, 'diam+3'),		ret = '50-Percentile effective diameter ($\delta_{0.5}$) [edges]'; 
elseif strcmp(statistic, 'diam+4'),		ret = 'Mean path length ($\delta_m) [edges]'; 
elseif strcmp(statistic, 'avgdegree'), 		ret = 'Average degree ($d$) [edges / vertex]';  
elseif strcmp(statistic, 'avgdegree+2'),	ret = 'Average left degree ($d_1$)'; 
elseif strcmp(statistic, 'avgdegree+3'),	ret = 'Average right degree ($d_2$)'; 
elseif strcmp(statistic, 'avgdegree+4'),	ret = 'Average number of neighbors'; 
elseif strcmp(statistic, 'clusco'),    		ret = 'Clustering coefficient ($c$)'; 
elseif strcmp(statistic, 'cluscoall+5'),    	ret = 'Relative signed clustering coefficient ($c_r$)'; 
elseif strcmp(statistic, 'cluscoall+7'),    	ret = 'Clustering coefficient, variant 2 ($c_2$)'; 
elseif strcmp(statistic, 'cluscoasym'),    	ret = 'Directed clustering coefficient ($c^{\pm}$)'; 
elseif strcmp(statistic, 'opnorm'),		ret = 'Operator 2-norm ($\nu$)'; 
elseif strcmp(statistic, 'power'),		ret = 'Power law exponent ($\gamma$)'; 
elseif strcmp(statistic, 'powerv'),		ret = 'Power law exponent ($\gamma$)'; 
elseif strcmp(statistic, 'power2'),		ret = 'Tail power law exponent ($\gamma_t$)'; 
elseif strcmp(statistic, 'power3'),		ret = 'Tail power law exponent with p ($\gamma_3$)'; 
elseif strcmp(statistic, 'power3+4'),		ret = 'p-value ($p$)'; 
elseif strcmp(statistic, 'power3+6'),		ret = 'Left tail power law exponent with p ($\gamma_{3,1}$)'; 
elseif strcmp(statistic, 'power3+9'),		ret = 'Left p-value ($p_1$)'; 
elseif strcmp(statistic, 'power3+11'),		ret = 'Right tail power law exponent with p ($\gamma_{3,2}$)'; 
elseif strcmp(statistic, 'power3+14'),		ret = 'Right p-value ($p_2$)'; 
elseif strcmp(statistic, 'power3+16'),		ret = 'Outdegree tail power law exponent with p ($\gamma_{3,o}$)'; 
elseif strcmp(statistic, 'power3+19'),		ret = 'Outdegree p-value ($p_o$)'; 
elseif strcmp(statistic, 'power3+21'),		ret = 'Indegree tail power law exponent with p ($\gamma_{3,i}$)'; 
elseif strcmp(statistic, 'power3+24'),		ret = 'Indegree p-value ($p_i$)'; 
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
elseif strcmp(statistic, 'coco+2')		ret = 'Relative size of LCC ($N^{rel}$)';
elseif strcmp(statistic, 'coco+3')		ret = 'Size of left LCC ($N_1$)';
elseif strcmp(statistic, 'coco+4')		ret = 'Relative size of left LCC';
elseif strcmp(statistic, 'coco+5')		ret = 'Size of right LCC ($N_2$)';
elseif strcmp(statistic, 'coco+6')		ret = 'Relative size of right LCC';
elseif strcmp(statistic, 'cocos')		ret = 'Size of LSCC ($N_s$) [vertices]';
elseif strcmp(statistic, 'cocos+2')		ret = 'Relative size of LSCC ($N^{r}_{s}$)';
elseif strcmp(statistic, 'snorm')		ret = 'Spectral norm ($\alpha$)'; 
elseif strcmp(statistic, 'seidelnorm')		ret = 'Seidel norm ($\alpha_W$)';
elseif strcmp(statistic, 'separation')		ret = 'Spectral separation ($|\lambda_1[A] / \lambda_2[A]|$)';
elseif strcmp(statistic, 'separationl')		ret = 'Laplacian spectral separation ($\lambda_3[L] / \lambda_2[L]$)';
elseif strcmp(statistic, 'gini')		ret = 'Gini coefficient ($G$)'; 
elseif strcmp(statistic, 'controllability')	ret = 'Controllability ($C$) [vertices]';
elseif strcmp(statistic, 'controllability+2')	ret = 'Relative controllability ($C_{r}$)';
elseif strcmp(statistic, 'controllabilityn')	ret = 'Relative controllability ($C_{r}$)';
elseif strcmp(statistic, 'conflict')		ret = 'Algebraic conflict ($\xi$)';
elseif strcmp(statistic, 'conflict+2')		ret = 'Spectral signed frustration ($\phi$)';
elseif strcmp(statistic, 'conflictn')		ret = 'Normalized algebraic conflict ($\xi_n$)';
elseif strcmp(statistic, 'runtime')		ret = 'Runtime [s]'; 
elseif strcmp(statistic, 'asymmetry')		ret = 'Spectral asymmetry ($\zeta$)'; 
elseif strcmp(statistic, 'own')			ret = 'Balanced inequality ratio ($P$)'; 
elseif strcmp(statistic, 'own+2')		ret = 'Left balanced inequality ratio ($P_1$)'; 
elseif strcmp(statistic, 'own+3')		ret = 'Right balanced inequality ratio ($P_2$)'; 
elseif strcmp(statistic, 'own+4')		ret = 'Outdegree balanced inequality ratio ($P_{+}$)'; 
elseif strcmp(statistic, 'own+5')		ret = 'Indegree balanced inequality ratio ($P_{-}$)'; 
elseif strcmp(statistic, 'radius')		ret = 'Spectral radius ($r$)'; 
elseif strcmp(statistic, 'maxdegree')		ret = 'Maximum degree ($d_{max}$) [edges]'; 
elseif strcmp(statistic, 'maxdegree+2')		ret = 'Maximum outdegree ($d^+_{max}$) [edges]'; 
elseif strcmp(statistic, 'maxdegree+3')		ret = 'Maximum indegree ($d^-_{max}$) [edges]'; 
elseif strcmp(statistic, 'maxdegree+4')		ret = 'Maximum left degree ($d_{1max}$) [edges]'; 
elseif strcmp(statistic, 'maxdegree+5')		ret = 'Maximum right degree ($d_{2max}$) [edges]'; 
elseif strcmp(statistic, 'maxdiag')             ret = 'Cyclic eigenvalue ($\pi$)'; 
elseif strcmp(statistic, 'jain') 		ret = ['Jain' '''' 's index ($J$)']; 
elseif strcmp(statistic, 'prefatt') 		ret = 'Preferential attachment exponent ($\beta$)'; 
elseif strcmp(statistic, 'prefatt+2') 		ret = 'Root-mean-square logarithmic error ($\epsilon$)'; 
elseif strcmp(statistic, 'prefatt+3') 		ret = 'Preferential attachment exponent ($\beta$)'; 
elseif strcmp(statistic, 'patest')		ret = 'Relative size of largest degree ($ln(d_{max}) / ln(|V|)$)'; 
elseif strcmp(statistic, 'reciprocity') 	ret = 'Reciprocity ($y$)'; 
elseif strcmp(statistic, 'triangles')		ret = 'Triangle count ($t$)'; 
elseif strcmp(statistic, 'anticonflict')	ret = 'Spectral bipartite frustration ($b_K$)'; 
elseif strcmp(statistic, 'oddcycles')		ret = 'Odd cycle ratio ($b_2$)'; 
elseif strcmp(statistic, 'nonbip')		ret = 'Non-bipartivity ($b_A$)'; 
elseif strcmp(statistic, 'nonbipal')		ret = 'Algebraic non-bipartivity ($\chi$)'; 
elseif strcmp(statistic, 'nonbipn')		ret = 'Normalized non-bipartivity ($b_N$)'; 
elseif strcmp(statistic, 'weight')		ret = 'Weight ($w$)'; 
elseif strcmp(statistic, 'negativity')		ret = 'Negativity ($\zeta$)'; 
elseif strcmp(statistic, 'triangles_normuni')	ret = ['Uniformized triangle count ($t' '''' '$)'];     
elseif strcmp(statistic, 'clusco_normuni')	ret = ['Uniformized clustering coefficient ($c' '''' '$)'];     
elseif strcmp(statistic, 'clusco_norm_p')	ret = 'Orthogonalized clustering coefficient ($c / p$)';
elseif strcmp(statistic, 'triangles_norm_p')	ret = 'Orthogonalized triangle count ($t / (p^3 (n ; 3))$)';
elseif strcmp(statistic, 'twostars')		ret = 'Wedge count ($s$)'; 
elseif strcmp(statistic, 'twostars_normuni')	ret = ['Uniformized wedge count ($s' '''' '$)']; 
elseif strcmp(statistic, 'uniquevolume')	ret = 'Unique edge count ($\bar{\bar m}$)';
elseif strcmp(statistic, 'lines')		ret = 'Data volume ($m_D$)';
elseif strcmp(statistic, 'loops')		ret = 'Loop count ($l$)'; 
elseif strcmp(statistic, 'twostars_norm_p')	ret = 'Orthogonalized wedge count'; 
elseif strcmp(statistic, 'twostars_coef') 	ret = 'Preferential attachment coefficient';
elseif strcmp(statistic, 'twostars_norm_d')	ret = 'Twostars factor ($s_d$)'; 
elseif strcmp(statistic, 'clusco_n')		ret = 'N-Clusco ($sqrt(n) c$)'; 
elseif strcmp(statistic, 'twostars_perf')	ret = 'Twostars perf';
elseif strcmp(statistic, 'volume_normuni')	ret = ['Uniformized volume ($m' '''' '$)']; 
elseif strcmp(statistic, 'meandist')		ret = 'Mean distance ($\delta_m$)'; 
elseif strcmp(statistic, 'squares')		ret = 'Square count ($q$)'; 
elseif strcmp(statistic, 'tconflict'),		ret = 'Triadic conflict ($\tau$)'; 
elseif strcmp(statistic, 'threestars')		ret = 'Claw count ($z$)';
elseif strcmp(statistic, 'tour4')		ret = '4-Tour count ($T_4$)'; 
elseif strcmp(statistic, 'fourstars')		ret = 'Cross count ($x$)';
elseif strcmp(statistic, 'assortativity')	ret = 'Degree assortativity ($\rho$)';
elseif strcmp(statistic, 'assortativity+2')	ret = 'Degree assortativity p-value ($p_{\rho}$)';
elseif strcmp(statistic, 'mediandist')		ret = 'Median distance ($\delta_M$)';
elseif strcmp(statistic, 'relmaxdegree')	ret = 'Relative maximum degree ($d_{Mr}$)';
elseif strcmp(statistic, 'cocorel')		ret = 'Relative size of LCC ($N^{r}$)'; 
elseif strcmp(statistic, 'cocorelinv')		ret = 'Inv. Rel. LCC ($N_{inv}$)'; 
elseif strcmp(statistic, 'degone')		ret = 'Proportion of degree-one nodes ($d_1$)';
elseif strcmp(statistic, 'diameff50'),		ret = '50-Percentile effective diameter ($\delta_{0.5}$) [edges]'; 
elseif strcmp(statistic, 'diameff90'), 		ret = '90-Percentile effective diameter ($\delta_{0.9}$) [edges]'; 
elseif strcmp(statistic, 'dconflict'),		ret = 'Dyadic conflict ($\eta$)'; 
elseif strcmp(statistic, 'fconflict'),		ret = 'Spectral signed frustration ($\phi$)'; 
elseif strcmp(statistic, 'syngraphyruntime'),   ret = 'Runtime [s]';
elseif strcmp(statistic, 'avgdegreeasym'), 	ret = 'Directed average degree ($d^{\rightarrow}$)';
elseif strcmp(statistic, 'avgmult'),		ret = 'Average edge multiplicity ($\tilde{m}$)';
elseif strcmp(statistic, 'inoutassort'), 	ret = 'In/outdegree correlation ($\rho^{\pm}$)'; 
  
else
    ret= statistic; 
end

if strcmp(type, 'latex')

    % Do nothing

elseif strcmp(type, 'latex-short')
    
    % Keep what is inside the $s
    ret = regexprep(ret, '^[^\$]+\(\$', '');
    ret = regexprep(ret, '\$\)[^\$]*$', ''); 
    
elseif strcmp(type, 'html-short')
    
    ret = regexprep(ret, '^[^\$]+\(\$', '');
    ret = regexprep(ret, '\$\)[^\$]*$', ''); 

    % Sub- and superscripts
    ret = regexprep(ret, '_\{([^}]+)\}', '<SUB>$1</SUB>'); 
    ret = regexprep(ret, '\^\{([^}]+)\}', '<SUP>$1</SUP>'); 
    ret = regexprep(ret, '_(.)', '<SUB>$1</SUB>'); 
    ret = regexprep(ret, '\^(.)', '<SUP>$1</SUP>'); 

    % Accidentals
    ret = regexprep(ret, '\\bar\{\\bar (.)\}', '$1̿'); 
    ret = regexprep(ret, '\\tilde\{(.)\}', '$1̃');
    
    % Individual symbols in Unicode
    ret = regexprep(ret, '\\alpha', 'α');
    ret = regexprep(ret, '\\beta',  'β');
    ret = regexprep(ret, '\\gamma', 'γ');
    ret = regexprep(ret, '\\delta', 'δ');
    ret = regexprep(ret, '\\eta',   'η');
    ret = regexprep(ret, '\\zeta',  'ζ');
    ret = regexprep(ret, '\\lambda','λ'); 
    ret = regexprep(ret, '\\nu',    'ν'); 
    ret = regexprep(ret, '\\xi',    'ξ'); 
    ret = regexprep(ret, '\\pi',    'π'); 
    ret = regexprep(ret, '\\rho',   'ρ');
    ret = regexprep(ret, '\\tau',   'τ');
    ret = regexprep(ret, '\\phi',   'φ');
    ret = regexprep(ret, '\\chi',   'χ');

    ret = regexprep(ret, '\\rightarrow', '→'); 
    ret = regexprep(ret, '\\pm', '±'); 
    ret = regexprep(ret, '\|\|', '‖');
    ret = regexprep(ret, '-', '−');
    
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

elseif strcmp(type, 'html-name')

  ret = regexprep(ret, ' \(.*\)', ''); 
  ret = regexprep(ret, ' \[.*\]', ''); 

else

  error(sprintf('*** Invalid type "%s" for konect_label_statistic.m', type)); 
  
end
