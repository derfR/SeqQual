#!/usr/bin/env perl

# This script is part of the SeqQual pipeline which automatically process chromatogram data and ace assemblies while integrating quality.
# Copyright 2010 Tiange Lang and Pauline Garnier-Géré, INRA
# Last updated 26-April-2010
# SeqQual is a free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program. If not, see <http://www.gnu.org/licenses/>.

$input=shift;
$arg1=shift;
$arg2=shift;
$arg3=shift;
$arg4=shift;
$arg5=shift;
$arg6=shift;
$arg7=shift;
$arg8=shift;
$arg9=shift;
$arg10=shift;
open (IN, "<$input");
while (<IN>){
    chomp;
    next unless(/\S/);
    print "cd $_\n";
    print "echo --------------------------------------------------\n";
    print "echo Dealing $_\n";
    print "echo --------------------------------------------------\n";
    print "cd mydata\n";
    print "cd aln_final\n";
    print "perl ~/SeqQual/write_arlequin_input_diploid-genotypicdata0_multinput.pl $arg1 $arg2 $arg3 $arg4 $arg5 $arg6 $arg7 $arg8 $arg9 $arg10\n";
    print "mv arlequin_input0 ..\n";
    print "perl ~/SeqQual/write_arlequin_input_diploid-genotypicdata1_multinput.pl $arg1 $arg2 $arg3 $arg4 $arg5 $arg6 $arg7 $arg8 $arg9 $arg10\n";
    print "mv arlequin_input1 ..\n";

    print "cd ../../../\n\n\n";
}
