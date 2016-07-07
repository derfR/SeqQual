#!/usr/bin/env perl

# This script is part of the SeqQual pipeline which automatically process chromatogram data and ace assemblies while integrating quality.
# Copyright 2014 Tiange Lang and Pauline Garnier-Gere, INRA
# Last updated 22-April-2014
# SeqQual is a free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details  at http://www.gnu.org/licenses/.

$lengthsplit=shift;

use Bio::SeqIO;
if (-d "aln_splitted"){die "already exist dir aln_splitted\n";}
system ("mkdir aln_splitted");

@ids=qx{ls};
foreach $input(@ids){
    chomp $input;
    next unless $input =~ /\.aln/;
    $in = Bio::SeqIO -> new (-file => "$input", -format => 'Fasta');
    while ($seqobj = $in -> next_seq()){
	$id=$seqobj -> id;
	$len = $seqobj -> length; last;
    }
    $input2=$input;
    $input2=~s/\.aln//;
    for ($i=0;$i<$len;$i=$i+$lengthsplit){
	$goal=$input2."-".$i.".aln";
	open OUT,">$goal";
	$in = Bio::SeqIO -> new (-file => "$input", -format => 'Fasta');
	while ($seqobj = $in -> next_seq()){
	    $id = $seqobj -> id; 
	    $seq = $seqobj -> seq; 
	    $base=substr($seq,$i,$lengthsplit);
	    print OUT ">",$id,"\n",$base,"\n";
	}
	print $goal,"\n";
	system ("mv $goal aln_splitted");
    }
}
