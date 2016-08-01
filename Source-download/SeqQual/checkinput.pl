#!/usr/bin/env perl

# This script is part of the SeqQual pipeline which automatically process DNA sequences from chromatogram *.ab1/abd/scf files and ace assemblies while integrating quality.
# Copyright 2010 Tiange Lang and Pauline Garnier-Gere, INRA
# Last updated April 2010
# SeqQual scripts are free to be distributed and/or changed under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version. These scripts are distributed in the hope that they will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details at <http://www.gnu.org/licenses/>.

@dirs=qx{ls -d *};
while(<>){
    chomp;
    next unless(/\S/);
    $warn=0;
    foreach $unit(@dirs){
	chomp $unit;
	if($_ eq $unit){$warn=1;}
    }
}
if ($war==0){print "One or more folders don't exist or are not spelled correctly. Please check your list. Note that the spelling is case-sensitive.\n"}




