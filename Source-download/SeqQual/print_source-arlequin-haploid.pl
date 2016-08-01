#!/usr/bin/env perl

# This script is part of the SeqQual pipeline which automatically process DNA sequences from chromatogram *.ab1/abd/scf files and ace assemblies while integrating quality.
# Copyright 2016 Tiange Lang and Pauline Garnier-Gere, INRA
# Last updated July 2016
# SeqQual scripts are free to be distributed and/or changed under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version. These scripts are distributed in the hope that they will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details at <http://www.gnu.org/licenses/>.

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
$arg11=shift;
$arg12=shift;
$arg13=shift;
$arg14=shift;
$arg15=shift;
$arg16=shift;
$arg17=shift;
$arg18=shift;
$arg19=shift;
$arg20=shift;
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
    print "perl ~/SeqQual/write_arlequin_input_multinput.pl $arg1 $arg2 $arg3 $arg4 $arg5 $arg6 $arg7 $arg8 $arg9 $arg10  $arg11 $arg12 $arg13 $arg14 $arg15  $arg16 $arg17 $arg18 $arg19 $arg20\n";
    print "mv arlequin_input ..\n";
    print "cd ../../../\n\n\n";
}
