# KONECT Toolbox

This is a toolbox for the analysis of large complex networks written in
Matlab.  It is part of the KONECT project (Koblenz Network Collection)

http://konect.uni-koblenz.de/

## Installation

The toolbox consists entirely of *.m files.  To use it, add the
directory m/ to the Matlab path, e.g., using addpath().  

## Requirements

Some functions need BGL, the Boost Graph Library. 

Installation of BGL:
* Download version 4.0.1 from website (newer versions may not work)
* unzip it
* (on some systems:  install libstdc++5 from http://packages.debian.org/stable/base/libstdc++5)
* symlink the unzipped matlab_bgl to here

## License

Written by Jérôme Kunegis at the University of Koblenz-Landau.

The KONECT Toolbox is free software: you can redistribute it and/or modify it under the
terms of the GNU General Public License as published by the Free
Software Foundation, either version 3 of the License, or (at your
option) any later version. 

The KONECT Toolbox is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or
FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
for more details. 

The full text of the GPLv3 is found in the file COPYING.
