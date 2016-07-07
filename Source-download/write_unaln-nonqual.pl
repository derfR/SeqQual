#!/usr/bin/env perl

# This script is part of the SeqQual pipeline which automatically process chromatogram data and ace assemblies while integrating quality.
# Copyright 2010 Tiange Lang and Pauline Garnier-Géré, INRA
# Last updated 26-April-2010
# SeqQual is a free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program. If not, see <http://www.gnu.org/licenses/>.

use Bio::SeqIO; 

if (-d "unaln"){die "already exist dir unaln\n";}
system ("mkdir unaln");

@ids=qx{ls};
foreach $input(@ids){
    chomp $input;
    next unless $input =~ /\.aln/;
    $input2=$input;
    $input2=~s/\.aln//g;
    print $input2,"\n";
    $goal="$input2".".unaln";

    $in = Bio::SeqIO -> new (-file => "$input", -format => 'Fasta');
    open OUT, ">$goal";
    while ($seqobj = $in -> next_seq()){
	$id = $seqobj -> id;
	next if $id=~/Contig/;
	$seq = $seqobj -> seq;
	$seq =~ s/-//g;
	$seq =~ s/\?//g;
	print OUT ">",$id,"\n",$seq,"\n";
    }
    system ("mv $goal unaln/"); 
}
