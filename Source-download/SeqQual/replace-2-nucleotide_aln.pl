#!/usr/bin/env perl

# This script is part of the SeqQual pipeline which automatically process DNA sequences from chromatogram *.ab1/abd/scf files and ace assemblies while integrating quality.
# Copyright 2010 Tiange Lang and Pauline Garnier-Gere, INRA
# Last updated April 2010
# SeqQual scripts are free to be distributed and/or changed under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version. These scripts are distributed in the hope that they will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details at <http://www.gnu.org/licenses/>.

if (-d "aln_replace2"){die "already exist dir aln_replace2\n";}
system ("mkdir aln_replace2");

use Bio::SeqIO;
@ids=qx{ls};
foreach $input(@ids){
    chomp $input;
    next unless $input =~ /\.aln/;
    $input2=$input;
    $input2=~s/\.aln//g;
    print $input2,"\n";
    $goal="$input2".".replace2".".aln";
 
    open OUT, ">$goal";
    $in = Bio::SeqIO -> new (-file => "$input", -format => 'Fasta');
    while ($seqobj = $in -> next_seq()){
	$id = $seqobj -> id;
	print OUT ">",$id,"\n";
	$seq = $seqobj -> seq; 
	@seqs = split (//,$seq);
	@seqs2 = @seqs;
	for ($i=0;$i<scalar(@seqs);$i++){
	    if ($seqs[$i-5] eq "?" &&  $seqs[$i-4] eq "?" &&  $seqs[$i-3] eq "?" &&  $seqs[$i-2] eq "?" &&  $seqs[$i-1] eq "?" &&  $seqs[$i+1] eq "?"  &&  $seqs[$i+2] eq "?" &&  $seqs[$i+3] eq "?" &&  $seqs[$i+4] eq "?" &&  $seqs[$i+5] eq "?"){
	    splice (@seqs2,$i,1,"?");
	    }

	    if ($seqs[$i-5] eq "?" &&  $seqs[$i-4] eq "?" &&  $seqs[$i-3] eq "?" &&  $seqs[$i-2] eq "?" &&  $seqs[$i-1] eq "?" &&  $seqs[$i+2] eq "?"  &&  $seqs[$i+3] eq "?" &&  $seqs[$i+4] eq "?" &&  $seqs[$i+5] eq "?" &&  $seqs[$i+6] eq "?"){
	    splice (@seqs2,$i,1,"?");
	    }

	    if ($seqs[$i-6] eq "?" &&  $seqs[$i-5] eq "?" &&  $seqs[$i-4] eq "?" &&  $seqs[$i-3] eq "?" &&  $seqs[$i-2] eq "?" &&  $seqs[$i+1] eq "?"  &&  $seqs[$i+2] eq "?" &&  $seqs[$i+3] eq "?" &&  $seqs[$i+4] eq "?" &&  $seqs[$i+5] eq "?"){
	    splice (@seqs2,$i,1,"?");
	    }

    	}
	$seq2 = join (//,@seqs2);
	print OUT $seq2,"\n";
    }
    
   system ("mv $goal aln_replace2/");
}
