#!/usr/bin/env perl

# This script is part of the SeqQual pipeline which automatically process chromatogram data and ace assemblies while integrating quality.
# Copyright 2010 Tiange Lang and Pauline Garnier-Géré, INRA
# Last updated 26-April-2010
# SeqQual is a free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program. If not, see <http://www.gnu.org/licenses/>.

$score=$ARGV[0];

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

    $assembly = Bio::Assembly::IO -> new (-file =>$input, -format =>'ace') -> next_assembly;

    foreach $contig ($assembly->all_contigs){
	$contig_id=$contig->id;
	$goal="$input2"."_"."$contig_id".".unaln";
	$consensus=$contig->get_consensus_sequence;
	$consensus_len=$contig->get_consensus_length;

	open OUT, ">$goal";
 	foreach $seq ($contig->each_seq){ 
	    $seqid=$seq->id;
	    $seqlen=$seq->length;
	    $seqfeat=$contig->get_seq_coord($seq);
	    $seqstart=$seqfeat->start;
	    $seqstrand=$seqfeat->strand;

	    print OUT ">",$seqid,"\n";

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
	    
	    print OUT $alignseqphd,"\n";
	}
	system ("mv $goal unaln/");
    }
 
}

