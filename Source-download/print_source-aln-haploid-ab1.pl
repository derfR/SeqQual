#!/usr/bin/env perl

# This script is part of the SeqQual pipeline which automatically process chromatogram data and ace assemblies while integrating quality.
# Copyright 2010 Tiange Lang and Pauline Garnier-Géré, INRA
# Last updated 26-April-2010
# SeqQual is a free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program. If not, see <http://www.gnu.org/licenses/>.

$input=shift;
$phrap1=shift;
$phrap2=shift;
$phrap3=shift;
$phrap4=shift;
$phrap5=shift;
$phrap6=shift;
$phrap7=shift;
$phrap8=shift;
$phrap9=shift;
$phrap10=shift;
$phrap11=shift;
$phrap12=shift;
$phrap13=shift;
$phrap14=shift;
$phrap15=shift;
$phrap16=shift;
$phrap17=shift;
$phrap18=shift;
open (IN, "<$input");
while (<IN>){
    chomp;
    next unless(/\S/);
    print "export PHRED_PARAMETER_FILE='/usr/local/Phred/phredpar.dat'\n";
    print "cd $_\n";
    print "echo --------------------------------------------------\n";
    print "echo Dealing $_\n";
    print "echo --------------------------------------------------\n";
    print "perl ~/SeqQual/checkdir_mydata.pl\n";
    print "mkdir mydata\n";
    print "cd mydata\n";
    print "mkdir chromat_dir phd_dir edit_dir\n";
    print "cp ../*.ab1 chromat_dir\n";
    print "cp ../*.AB1 chromat_dir\n";
    print "cp ../*.abd chromat_dir\n";
    print "cp ../*.ABD chromat_dir\n";
    print "cp ../*.SCF chromat_dir\n";
    print "cp ../*.scf chromat_dir\n";
    print "cd edit_dir\n";
    print "phred -id ../chromat_dir/ -pd ../phd_dir/\n";
    print "phd2fasta -id ../phd_dir/ -os $_.fa\n";
    print "ls *.fa > fa.id\n";
    print "perl ~/SeqQual/phrap_all_lang.pl fa.id $phrap1 $phrap2 $phrap3 $phrap4 $phrap5 $phrap6 $phrap7 $phrap8 $phrap9 $phrap10 $phrap11 $phrap12 $phrap13 $phrap14 $phrap15 $phrap16 $phrap17 $phrap18 \n";
    print "cd ../../../\n\n\n";
}
