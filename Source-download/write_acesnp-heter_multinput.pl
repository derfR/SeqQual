#!/usr/bin/env perl

# This script is part of the SeqQual pipeline which automatically process chromatogram data and ace assemblies while integrating quality.
# Copyright 2010 Tiange Lang and Pauline Garnier-Géré, INRA
# Last updated 26-April-2010
# SeqQual is a free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program. If not, see <http://www.gnu.org/licenses/>.

$score1=$ARGV[0];
$score2=$ARGV[1];

if (-d "SNP"){die "already exist dir SNP\n";} 

system("mkdir SNP");


use Bio::Assembly::IO;

@ids=qx{ls};
foreach $input(@ids){
    chomp $input;
    next unless $input =~ /\.ace/;
    $input2=$input;
    $input2=~s/\..*//g;
    print $input2,"\n";
    $input3=$input2;
    $input2=$input2.".polyphred.out";

    $assembly = Bio::Assembly::IO -> new (-file =>$input, -format =>'ace') -> next_assembly;

    foreach $contig ($assembly->all_contigs){
        $contig_id=$contig->id;
	$goal="$input3"."_"."$contig_id".".snp.aln";
        $consensus=$contig->get_consensus_sequence; 
        $consensus_len=$contig->get_consensus_length;

	$feature=$contig->get_features_collection;
        @feat=$feature->get_all_features;
        @SNP=();
        foreach $feat(@feat){
	    $tag=$feat->primary_tag;
	    next unless $tag=~/polyPhredRank/;	
	    $start=$feat->start;
	    push (@SNP, $start);
        }

	open OUT, ">$goal";
 	if (scalar(@SNP)==0){print "No SNP\n"; next;}
	print OUT "Contig",$contig_id,":SNP number:",scalar @SNP,"\t","SNP pos:","@SNP","\n";

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
	    print OUT ">",$seqid,"\n";

	    open IN, "<$input2"; $begin_genotype=0; %heter=(); 
	    while (<IN>){
	    	chomp;
	        if (/BEGIN_GENOTYPE/){$begin_genotype=1;}
	        if (/END_GENOTYPE/){$begin_genotype=0;}
	        if ($begin_genotype==1 && /^\d/){
		    split(/\s+/, $_);
		    if ($_[2] eq $seqid && $_[3] ne $_[4] && $_[5]>=$score2){
		    	$heter{$_[1]}="$_[3]"."$_[4]";
		    }
	        }
	    }
	    close IN;
	    foreach $k(keys %heter){
	        $heter{$k}=~ s/AG|GA/R/;
	        $heter{$k}=~ s/AT|TA/W/;
	        $heter{$k}=~ s/AC|CA/M/;
	        $heter{$k}=~ s/TG|GT/K/;
	        $heter{$k}=~ s/TC|CT/Y/;
	        $heter{$k}=~ s/CG|GC/S/;
	    }

	    $in = Bio::SeqIO -> new (-file => "../phd_dir/$seqid.phd.1", -format => 'phd');
	    while ($seqobj = $in -> next_seq()){
	        $qual = $seqobj->qual_text;
	        @quals = split (/ /, $qual);
	        $alignseqphd = $seqobj -> seq;
	        for ($x=0;$x<scalar(@quals);$x++){
		    $isheter=0; $isheterneighbour=0;
		    foreach $k(keys %heter){
		        if ($x==$k-1){ #seq pos in poly.out counts from 1 not 0!
			    $isheter=1;
			    substr($alignseqphd,$x,1)=$heter{$k};
		        }
		        if ($x==$k-2||$x==$k){$isheterneighbour=1;}
		    } 
		    if ($isheter==0 && $isheterneighbour==0) {
		        if ($quals[$x]<$score1) {substr($alignseqphd,$x,1)='?';}
		    }
		    if ($isheter==0 && $isheterneighbour==1) {
		        $leftqual=($quals[$x-3]+$quals[$x-2]+$quals[$x-1])/3;
		        $rightqual=($quals[$x+1]+$quals[$x+2]+$quals[$x+3])/3;
		        if ($leftqual<$score1 && $rightqual<$score1){
			    if ($quals[$x]<$score1) {substr($alignseqphd,$x,1)='?';}
		        }
		    }
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
	    for ($i=1;$i<$consensus_len-$seqstart-$seqlen+2;$i++){$alignseq=$alignseq."?";}
	    $alignseq=substr($alignseq,0,$SNP[scalar(@SNP)-1]);

	    foreach $SNP(@SNP){
	        $SNPsite=substr($alignseq,$SNP-1,1);
	        print OUT "$SNPsite";
	    }
	    print OUT "\n";

	}
	system ("mv $goal SNP/");
    }
}
