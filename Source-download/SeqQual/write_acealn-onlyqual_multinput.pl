#!/usr/bin/env perl

# This script is part of the SeqQual pipeline which automatically process DNA sequences from chromatogram *.ab1/abd/scf files and ace assemblies while integrating quality.
# Copyright 2010 Tiange Lang and Pauline Garnier-Gere, INRA
# Last updated April 2010
# SeqQual scripts are free to be distributed and/or changed under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version. These scripts are distributed in the hope that they will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details at <http://www.gnu.org/licenses/>.

$score=$ARGV[0];

if (-d "aln"){die "already exist dir aln\n";} 

system("mkdir aln");

use Bio::Assembly::IO;
use Bio::SeqIO;

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
	    $alignseqace=$seq->seq;
	    @alignseqace=split(//,$alignseqace);
	    @dash=();
	    for ($i=0;$i<scalar(@alignseqace);$i++){
		if ($alignseqace[$i] eq "-"){push (@dash, $i);}
	    }
	    print $seqid,"\tstrand:",$seqstrand,"\tstart:",$seqstart,"\n";
	    print OUT ">",$seqid,"|strand:",$seqstrand,"|start:",$seqstart,"\n";

	    $in = Bio::SeqIO -> new (-file => "../phd_dir/$seqid.phd.1", -format => 'phd');
	    while ($seqobj = $in -> next_seq()){
		$qual = $seqobj->qual_text;
		@quals = split (/ /, $qual);
    		$alignseqphd = $seqobj -> seq;
		
		for ($x=0;$x<scalar(@quals);$x++){
		    if ($quals[$x]<$score) {substr($alignseqphd,$x,1)='?'; }
		}
	    }
	    if ($seqstrand==-1){
		$alignseqphd = reverse $alignseqphd;
		$alignseqphd =~ tr/ATCGatcg/TAGCtagc/;
	    }
	    @alignseqphd=split(//,$alignseqphd);
	    for ($i=0;$i<scalar(@dash);$i++){
		splice (@alignseqphd,$dash[$i],0,"-");
	    }
	    $alignseq=join(/""/,@alignseqphd);
	    $alignseqback = $alignseq;
	    while ($alignseqback =~ /\?-+\?/g){
		$l = length($&);
		$p = pos($alignseqback);
		substr($alignseq, $p-$l, $l) = "?" x $l;
		pos($alignseqback) = pos($alignseqback)-1;
	    }

	    if ($seqstart<=0){
		$trim=1-$seqstart;
		$alignseq = substr ($alignseq,$trim,length($alignseq)-$trim);
	    }
	    for ($i=1;$i<$seqstart;$i++){$alignseq="?".$alignseq;}
	    for ($j=1;$j<$consensus_len-$seqstart-$seqlen+2;$j++){$alignseq=$alignseq."?";}
	    $alignseq=substr($alignseq,0,$consensus_len);
	    print OUT $alignseq,"\n";
	}
	system ("mv $goal aln/");
    }
 
}

