#!/usr/bin/env -perl
# This script is part of the SeqQual pipeline which automatically process chromatogram data and ace assemblies while integrating quality.
# Copyright 2014 Tiange Lang and Pauline Garnier-Gere, INRA
# Last updated 22-April-2014
# SeqQual is a free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details  at http://www.gnu.org/licenses/.

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
	print "perl ~/SeqQual/SNP_statistic2-haplo.pl $arg1 $arg2 > ../SNP_statistic_",$_,".txt\n";
	print "cd ..\n";
    }
    elsif ($arg1) {
	print "echo Dealing $_\n";
	print "cd $_\n";
	print "perl ~/SeqQual/SNP_statistic1-haplo.pl $arg1 > ../SNP_statistic_",$_,".txt\n";
	print "cd ..\n";
    }
    else {
	print "echo Dealing $_\n";
	print "cd $_\n";
	print "perl ~/SeqQual/SNP_statistic0-haplo.pl > ../SNP_statistic_",$_,".txt\n";
	print "cd ..\n";
    }
}
