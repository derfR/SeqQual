#!/usr/bin/env perl

# This script is part of the SeqQual pipeline which automatically process DNA sequences from chromatogram *.ab1/abd/scf files and ace assemblies while integrating quality.
# Copyright 2016 Tiange Lang and Pauline Garnier-Gere, INRA
# Last updated July 2016
# SeqQual scripts are free to be distributed and/or changed under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version. These scripts are distributed in the hope that they will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details at <http://www.gnu.org/licenses/>.

if (-d "aln_remove"){die "already exist dir aln_remove\n";}
system ("mkdir aln_remove");

$number=shift;

use Bio::SeqIO;
@ids=qx{ls};
foreach $input(@ids){
    chomp $input;
    next unless $input =~ /\.aln/;
    $input2=$input;
    $input2=~s/\.aln//g;
    print $input2,"\n";
    $goal="$input2".".remove".".aln";
 
    $in = Bio::SeqIO -> new (-file => "$input", -format => 'Fasta');
    while ($seqobj = $in -> next_seq()){
	$len = $seqobj -> length; 
	next;
    }
    
    @remove_pos=();
    for ($i=0;$i<$len;$i++){
	$base_no=0;
	$in = Bio::SeqIO -> new (-file => "$input", -format => 'Fasta');
	while ($seqobj = $in -> next_seq()){
	    $id = $seqobj -> id; 
	    $seq = $seqobj -> seq; 
	    next if $id=~/^Contig/;
	    $base=substr($seq,$i,1);
	    unless ($base eq "?" || $base eq "-"){$base_no++;}
	}
	if ($base_no<=$number){push (@remove_pos,$i);}
    }
    print "Removing positions:","@remove_pos","\n";
    open OUT, ">$goal";
    $in = Bio::SeqIO -> new (-file => "$input", -format => 'Fasta');
    while ($seqobj = $in -> next_seq()){
	$id = $seqobj -> id; 
	$seq = $seqobj -> seq;
       	@seq = split(//,$seq);	
	foreach $k(@remove_pos){
		splice(@seq,$k,1,"|");
	}	
	$seq = join(/""/,@seq);
	$seq =~ s/\|//g;
	print OUT ">",$id,"\n",$seq,"\n";
    }

    system ("mv $goal aln_remove/");
}
