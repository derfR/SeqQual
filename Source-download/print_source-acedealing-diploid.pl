#!/usr/bin/env perl

# This script is part of the SeqQual pipeline which automatically process chromatogram data and ace assemblies while integrating quality.
# Copyright 2010 Tiange Lang and Pauline Garnier-Géré, INRA
# Last updated 26-April-2010
# SeqQual is a free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program. If not, see <http://www.gnu.org/licenses/>.

$input=shift;
$polyphredscore=shift;		
$polyphredquality=shift;		

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
    print "mkdir phd_dir poly_dir edit_dir\n";
    print "cp ../*.phd.1 phd_dir\n";
    print "cp ../*.poly poly_dir\n";
    print "cp ../*.ace edit_dir\n";
    print "cd edit_dir\n";
    print "ls *.ace > ace.id\n";
    print "perl ~/SeqQual/polyphred_all_lang.pl ace.id $polyphredscore $polyphredquality\n";
    print "cd ../../../\n\n\n";
}
