#!/usr/bin/env perl

# This script is part of the SeqQual pipeline which automatically process DNA sequences from chromatogram *.ab1/abd/scf files and ace assemblies while integrating quality.
# Copyright 2014 Tiange Lang and Pauline Garnier-Gere, INRA
# Last updated 22 April 2014
# SeqQual scripts are free to be distributed and/or changed under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version. These scripts are distributed in the hope that they will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details at <http://www.gnu.org/licenses/>.

$input=shift;
open (IN, "<$input");
while (<IN>){
    chomp;
    next unless(/\S/);
    print "cd $_\n";
    print "echo --------------------------------------------------\n";
    print "echo Dealing $_\n";
    print "echo --------------------------------------------------\n";
    print "perl ~/SeqQual/checkdir_mydata.pl\n";
    print "mkdir mydata\n";
    print "cd mydata\n";
    print "mkdir phd_dir edit_dir\n";
    print "cp ../*.phd.1 phd_dir\n";
    print "cp ../*.ace edit_dir\n";
    print "cd ../../\n\n\n";
}
