%
% Which latent dimension is the first usable one for a given
% decomposition?  This is 1 for most cases, and 2 for:  The
% Laplacians and normalized matrices of unsigned graphs.
%
% PARAMETERS 
%	decomposition
%	D		(optional) Eigenvalues;  
%
% RESULT 
%	first	Index of first usable latent dimension; 1 or 2
%

function first = konect_first_index(decomposition, D)

epsilon = 1e-13; 

first = 1; 

data_decomposition = konect_data_decomposition(decomposition); 

if data_decomposition.l
    if exist('D', 'var')
        if D(1,1) < epsilon
            first = 2; 
        end
    else
        first = 2; 
    end
elseif strcmp(decomposition, 'stoch1') | strcmp(decomposition, 'stoch2') ...
        | strcmp(decomposition, 'stoch')
    first = 2; 
end
