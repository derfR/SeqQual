# This script is part of the SeqQual pipeline which automatically process chromatogram data and ace assemblies while integrating quality.
# Copyright 2014 Tiange Lang and Pauline Garnier-Gere, INRA
# Last updated 22-April-2014
# SeqQual is a free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details  at http://www.gnu.org/licenses/.

#!/usr/bin/perl
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
