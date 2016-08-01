#!/usr/bin/env perl

# This script is part of the SeqQual pipeline which automatically process DNA sequences from chromatogram *.ab1/abd/scf files and ace assemblies while integrating quality.
# Copyright 2014 Tiange Lang and Pauline Garnier-Gere, INRA
# Last updated 22 April 2014
# SeqQual scripts are free to be distributed and/or changed under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version. These scripts are distributed in the hope that they will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details at <http://www.gnu.org/licenses/>.

$source = $ARGV[0];
open (IN, "<$source");

while (my $line = <IN>){
    chomp $line;
    if ($line =~ /BEGIN_SEQUENCE/){
	print $line,"\n";
	$filename = $line;
	$filename =~ s/BEGIN_SEQUENCE //;
	$goal = $filename.".phd.1";
	open (OUT,">$goal");
    }
    print OUT $line,"\n";
}
close IN;





