#!/usr/bin/env perl

# This script is part of the SeqQual pipeline which automatically process DNA sequences from chromatogram *.ab1/abd/scf files and ace assemblies while integrating quality.
# Copyright 2014 Tiange Lang and Pauline Garnier-Gere, INRA
# Last updated 22 April 2014
# SeqQual scripts are free to be distributed and/or changed under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version. These scripts are distributed in the hope that they will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details at <http://www.gnu.org/licenses/>.
if (-d "aln_combined"){die "already exist dir aln_combined\n";}
system ("mkdir aln_combined");

use Bio::SeqIO;
@id1=qx{ls *nonqual.aln};
@id2=qx{ls *phred*.aln};
for($i=0;$i<scalar@id1;$i++){
    chomp $id1[$i];
    chomp $id2[$i];
    $out=$id1[$i];
    $out=~s/-nonqual\.aln//;
    $out=~s/_nonqual\.aln//;
    print $out,"\n";
    $goal="$out"."_combined".".aln";
    @ids=();@seqs=();

    $in1 = Bio::SeqIO -> new (-file => "$id1[$i]", -format => 'Fasta');
    $in2 = Bio::SeqIO -> new (-file => "$id2[$i]", -format => 'Fasta');
    while ($seqobj1 = $in1 -> next_seq()){
	$seqobj2 = $in2 -> next_seq();
	$combinedseq="";
	$id1 = $seqobj1 -> id;
	push(@ids,$id1);
	$seq1 = $seqobj1 -> seq;
	$seq2 = $seqobj2 -> seq;
	if (length$seq1==length$seq2){
	    @seqs1=split(//,$seq1);
	    @seqs2=split(//,$seq2);
	    for ($j=0;$j<scalar@seqs1;$j++){
		if($seqs2[$j] eq "?"){$combinedseq=$combinedseq."?";}
		else {$combinedseq=$combinedseq.$seqs1[$j];}
	    }
	}
	else {$combinedseq=$seq1;print "Problem read: ",$id1,"\n";}
	push(@seqs,$combinedseq);
    }

    open OUT, ">$goal";
    for ($k=0;$k<scalar@ids;$k++){
	print OUT ">",$ids[$k],"\n",$seqs[$k],"\n";
    }
    system ("mv $goal aln_combined/");
}
