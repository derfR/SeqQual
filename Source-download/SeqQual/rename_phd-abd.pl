#!/usr/bin/env perl

# This script is part of the SeqQual pipeline which automatically process DNA sequences from chromatogram *.ab1/abd/scf files and ace assemblies while integrating quality.
# Copyright 2010 Tiange Lang and Pauline Garnier-Gere, INRA
# Last updated April 2010
# SeqQual scripts are free to be distributed and/or changed under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version. These scripts are distributed in the hope that they will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details at <http://www.gnu.org/licenses/>.

open OUT, ">rename-abd.txt";
@ids=qx{ls};
foreach $input(@ids){
    chomp $input;
    next unless $input =~ /\.phd\.1/;
    next if $input =~ /\.ab1\.phd\.1/;
    next if $input =~ /\.abd\.phd\.1/;
    next if $input =~ /\.scf\.phd\.1/;
    $input2=$input;
    $input2=~s/\.phd\.1//;
    print OUT "mv $input $input2\.abd\.phd\.1\n"; 
}
