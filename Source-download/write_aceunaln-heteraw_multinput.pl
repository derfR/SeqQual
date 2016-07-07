#!/usr/bin/env perl

# This script is part of the SeqQual pipeline which automatically process chromatogram data and ace assemblies while integrating quality.
# Copyright 2010 Tiange Lang and Pauline Garnier-Géré, INRA
# Last updated 26-April-2010
# SeqQual is a free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program. If not, see <http://www.gnu.org/licenses/>.

$score1=$ARGV[0];
$score2=$ARGV[1];

if (-d "unaln"){die "already exist dir unaln\n";} 

system("mkdir unaln");


use Bio::Assembly::IO;
use Bio::SeqIO;

@ids=qx{ls};
foreach $input(@ids){
    chomp $input;
    next unless $input =~ /\.ace/;
    $input2=$input;
    $input2=~s/\..*//g;
    print $input2,"\n";
    $input1=$input2;

    $assembly = Bio::Assembly::IO -> new (-file =>$input, -format =>'ace') -> next_assembly;

    foreach $contig ($assembly->all_contigs){
        $contig_id=$contig->id;
	$goal="$input1"."_"."$contig_id".".unaln";
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
	    print OUT ">",$seqid,"|strand:",$seqstrand,"|start:",$seqstart;

	    open IN, "<../poly_dir/$seqid.poly"; %heter=(); 
	    $line=<IN>;
	    $hit=0;
	    while ($line=<IN>){
	    	chomp $line;
		$hit++;
		$line=~s/\s+/|/g;
		@line=split(/\|/,$line);
		if ($line[0] ne "N" && $line[4] ne "N" && $line[0] ne $line[4] && $line[2]/($line[2]+$line[6])<=$score2 && $line[6]/($line[2]+$line[6])<=$score2){
		    print "Pos:$hit=","$line[0]","+","$line[4]","\n";
		    $heter{$hit}="$line[0]"."$line[4]";
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

	    print OUT "\n";
	    $in = Bio::SeqIO -> new (-file => "../phd_dir/$seqid.phd.1", -format => 'phd');
	    while ($seqobj = $in -> next_seq()){
	        $qual = $seqobj->qual_text;
	        @quals = split (/ /, $qual);
	        $alignseqphd = $seqobj -> seq;
	        for ($x=0;$x<scalar(@quals);$x++){
		    $isheter=0;
		    foreach $k(keys %heter){
		        if ($x==$k-1){ #seq pos in poly counts from 1 not 0!
			    $isheter=1;
			    substr($alignseqphd,$x,1)=$heter{$k};
		        }
		    } 
		    if ($isheter==0) {
		        if ($quals[$x]<$score1) {substr($alignseqphd,$x,1)='?';}
		    }
	        }
	    }

	    if ($seqstrand==-1){
	        $alignseqphd = reverse $alignseqphd;
	        $alignseqphd =~ tr/ATCGatcgRYMKrymk/TAGCtagcYRKMyrkm/;
	    }

	    print OUT $alignseqphd,"\n";
        }
	system ("mv $goal unaln/");
    }
}
