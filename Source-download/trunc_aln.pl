#!/usr/bin/env perl

# This script is part of the SeqQual pipeline which automatically process chromatogram data and ace assemblies while integrating quality.
# Copyright 2010 Tiange Lang and Pauline Garnier-Géré, INRA
# Last updated 26-April-2010
# SeqQual is a free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program. If not, see <http://www.gnu.org/licenses/>.

if (-d "aln_trunc"){die "already exist dir aln_trunc\n";}
system ("mkdir aln_trunc");

$arg=shift;

use Bio::SeqIO;
@ids=qx{ls};
foreach $input(@ids){
    chomp $input;
    next unless $input =~ /\.aln/;
    $input2=$input;
    $input2=~s/\.aln//g;
    print $input2,"\n";
    $goal="$input2".".trunc".".aln";
 
    $in = Bio::SeqIO -> new (-file => "$input", -format => 'Fasta');
    while ($seqobj = $in -> next_seq()){
	$len = $seqobj -> length; 
	next;
    }

    print "Length:",$len,"\n";
    
    for ($i=0;$i<$len;$i++){
	$base_no=0;
	$in = Bio::SeqIO -> new (-file => "$input", -format => 'Fasta');
	while ($seqobj = $in -> next_seq()){
	    $id = $seqobj -> id; 
	    $seq = $seqobj -> seq; 
	    $base=substr($seq,$i,1);
	    unless ($base eq "?"){$base_no++;}
	}
	if ($base_no>=$arg+1){$start=$i;$i=$len;}
    }

    print "Start:",$start,"\n";

    for ($i=$len-1;$i>-1;$i--){
	$base_no=0;
	$in = Bio::SeqIO -> new (-file => "$input", -format => 'Fasta');
	while ($seqobj = $in -> next_seq()){
	    $id = $seqobj -> id; 
	    $seq = $seqobj -> seq; 
	    $base=substr($seq,$i,1);
	    unless ($base eq "?"){$base_no++;}
	}
	if ($base_no>=$arg+1){$end=$i;$i=-1;}
    }
    
    print "End:",$end,"\n";

    open OUT, ">$goal";
    $in = Bio::SeqIO -> new (-file => "$input", -format => 'Fasta');
    while ($seqobj = $in -> next_seq()){
	$id = $seqobj -> id; 
	$seq = $seqobj -> seq; 
	$truncseq=substr($seq,$start,$end-$start+1);
	print OUT ">",$id,"\n",$truncseq,"\n";
    }

    system ("mv $goal aln_trunc/");
}
