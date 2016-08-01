#!/usr/bin/env perl

# This script is part of the SeqQual pipeline which automatically process DNA sequences from chromatogram *.ab1/abd/scf files and ace assemblies while integrating quality.
# Copyright 2016 Tiange Lang and Pauline Garnier-Gere, INRA
# Last updated July 2016
# SeqQual scripts are free to be distributed and/or changed under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version. These scripts are distributed in the hope that they will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details at <http://www.gnu.org/licenses/>.

use Bio::SeqIO; 

if (-d "aln_haplotype"){die "already exist dir aln_haplotype\n";}
system ("mkdir aln_haplotype");

@ids=qx{ls};
foreach $input(@ids){
    chomp $input;
    next unless $input =~ /\.aln/;
    $input2=$input;
    $input2=~s/\.aln//g;
    print $input2,"\n";
    $goal="$input2".".haplotype.aln";

    $in = Bio::SeqIO -> new (-file => "$input", -format => 'Fasta');
    open OUT, ">$goal";
    while ($seqobj = $in -> next_seq()){
	$id = $seqobj -> id;
	$seq = $seqobj -> seq;
	if ($id=~/^Contig/) {print OUT ">",$id,"\n",$seq,"\n"; next;}
	$seq0=$seq; $seq1=$seq; $seq2=$seq; @seqs0=split(//,$seq0);@seqs1=split(//,$seq1);@seqs2=split(//,$seq2);
    	for ($i=0;$i<scalar(@seqs0);$i++){
	    if (uc$seqs0[$i] eq "R"){splice (@seqs1,$i,1,"A");splice (@seqs2,$i,1,"G"); }
	    if (uc$seqs0[$i] eq "W"){splice (@seqs1,$i,1,"A");splice (@seqs2,$i,1,"T"); }
	    if (uc$seqs0[$i] eq "M"){splice (@seqs1,$i,1,"A");splice (@seqs2,$i,1,"C"); }
	    if (uc$seqs0[$i] eq "K"){splice (@seqs1,$i,1,"G");splice (@seqs2,$i,1,"T"); }
	    if (uc$seqs0[$i] eq "Y"){splice (@seqs1,$i,1,"C");splice (@seqs2,$i,1,"T"); }
	    if (uc$seqs0[$i] eq "S"){splice (@seqs1,$i,1,"C");splice (@seqs2,$i,1,"G"); }
	}
	$seqprint1=join(//,@seqs1); $seqprint2=join(//,@seqs2);
	print OUT ">",$id,"-a\n",$seqprint1,"\n";
	print OUT ">",$id,"-b\n",$seqprint2,"\n";
    }
    system ("mv $goal aln_haplotype/"); 
}
