#!/usr/bin/env perl

# This script is part of the SeqQual pipeline which automatically process DNA sequences from chromatogram *.ab1/abd/scf files and ace assemblies while integrating quality.
# Copyright 2014 Tiange Lang and Pauline Garnier-Gere, INRA
# Last updated 22 April 2014
# SeqQual scripts are free to be distributed and/or changed under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version. These scripts are distributed in the hope that they will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details at <http://www.gnu.org/licenses/>.
$write=1;
while(<>){
    chomp;
    if(/^RD/){$write=2;}
    if(/^QA/){$write=3;}
    if(/^DS/){$write=1;}
    if ($write==1){print $_,"\n";}
    if ($write==2){
	if(/^RD/){print $_,"\n";}
	else{print $_;}
    }
    if ($write==3){
	if($_ eq ""){print $_,"\n";}
	else{
	    @a=split(/ /,$_);
	    print "|",$a[1],"|",$a[2],"\n";
	    print "\n",$_,"\n";
	}
    }
}
