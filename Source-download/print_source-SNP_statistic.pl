#!/usr/bin/env -perl
# This script is part of the SeqQual pipeline post-processing programs which automatically process chromatogram data and ace assemblies while integrating quality.
# Copyright 2010 Tiange Lang and Pauline Garnier-Gere, INRA
# Last updated 31-07-2015
# SeqQual post-processing programs are free programs: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program. If not, see <http://www.gnu.org/licenses/>.

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
