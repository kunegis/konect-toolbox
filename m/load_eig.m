
function dd = load_eig()

logfile = getenv('LOGFILE')

[status, dd_text] = unix(['sh/save_diag ' logfile]);

assert(status == 0); 

dd_text

dd_text = regexprep(dd_text, '\n', ' ')

dd = sscanf(dd_text, '%f')

