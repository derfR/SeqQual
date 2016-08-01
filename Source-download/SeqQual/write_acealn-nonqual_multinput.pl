#!/usr/bin/env perl

# This script is part of the SeqQual pipeline which automatically process DNA sequences from chromatogram *.ab1/abd/scf files and ace assemblies while integrating quality.
# Copyright 2014 Tiange Lang and Pauline Garnier-Gere, INRA
# Last updated 22 April 2014
# SeqQual scripts are free to be distributed and/or changed under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version. These scripts are distributed in the hope that they will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details at <http://www.gnu.org/licenses/>.

if (-d "aln"){die "already exist dir aln\n";} 

system("mkdir aln");

use Bio::Assembly::IO;

@ids=qx{ls};
foreach $input(@ids){
    chomp $input;
    next unless $input =~ /\.ace/;
    $input2=$input;
    $input2=~s/\..*//g;
    print $input2,"\n";

    $assembly = Bio::Assembly::IO -> new (-file =>$input, -format =>'ace') -> next_assembly;

    foreach $contig ($assembly->all_contigs){
	$contig_id=$contig->id;
	$goal="$input2"."_"."$contig_id".".aln";
	$consensus=$contig->get_consensus_sequence;
	$consensus_len=$contig->get_consensus_length;

	open OUT, ">$goal";
	print OUT ">Contig",$contig_id,"|Length:",$consensus_len,"|No_of_Seq:",$contig->no_sequences,"\n",$consensus->seq,"\n";
	
	foreach $seq ($contig->each_seq){ 
	    $seqid=$seq->id;
	    $seqlen=$seq->length;
	    $seqfeat=$contig->get_seq_coord($seq);
	    $seqstart=$seqfeat->start;
	    $seqstrand=$seqfeat->strand;
	    $alignseq=$seq->seq;
	    print OUT ">",$seqid,"|strand:",$seqstrand,"|start:",$seqstart,"\n";
	    if ($seqstart<=0){
		$trim=1-$seqstart;
		$alignseq = substr ($alignseq,$trim,length($alignseq)-$trim);
	    }
	   
	    for ($i=1;$i<$seqstart;$i++){$alignseq="?".$alignseq;}
	    for ($i=1;$i<$consensus_len-$seqstart-$seqlen+2;$i++){$alignseq=$alignseq."?";}
	    $alignseq=substr($alignseq,0,$consensus_len);
	    print OUT $alignseq,"\n";
	}
	system ("mv $goal aln/");
    }
 
}

