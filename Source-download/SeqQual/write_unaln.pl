#!/usr/bin/env perl

# This script is part of the SeqQual pipeline which automatically process DNA sequences from chromatogram *.ab1/abd/scf files and ace assemblies while integrating quality.
# Copyright 2016 Tiange Lang and Pauline Garnier-Gere, INRA
# Last updated July 2016
# SeqQual scripts are free to be distributed and/or changed under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version. These scripts are distributed in the hope that they will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details at <http://www.gnu.org/licenses/>.

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
