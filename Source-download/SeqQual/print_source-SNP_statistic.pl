#!/usr/bin/env perl

# This script is part of the SeqQual pipeline which automatically process DNA sequences from chromatogram *.ab1/abd/scf files and ace assemblies while integrating quality.
# Copyright 2016 Tiange Lang and Pauline Garnier-Gere, INRA
# Last updated July 2016
# SeqQual scripts are free to be distributed and/or changed under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version. These scripts are distributed in the hope that they will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details at <http://www.gnu.org/licenses/>.
$input=shift;
$arg1=shift;
$arg2=shift;

open (IN, "<$input");
while (<IN>){
    chomp;
    next unless(/\S/);
    if ($arg1 && $arg2) {
	print "echo==============================\n";
	print "echo Dealing $_\n";
	print "echo==============================\n";
	print "cd $_\n";
	print "perl ~/SeqQual/SNP_statistic2.pl $arg1 $arg2 > ../SNP_statistic_",$_,".txt\n";
	print "cd ..\n";
    }
    elsif ($arg1) {
	print "echo Dealing $_\n";
	print "cd $_\n";
	print "perl ~/SeqQual/SNP_statistic1.pl $arg1 > ../SNP_statistic_",$_,".txt\n";
	print "cd ..\n";
    }
    else {
	print "echo Dealing $_\n";
	print "cd $_\n";
	print "perl ~/SeqQual/SNP_statistic0.pl > ../SNP_statistic_",$_,".txt\n";
	print "cd ..\n";
    }
}
