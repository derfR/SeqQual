#!/usr/bin/env perl

# This script is part of the SeqQual pipeline which automatically process DNA sequences from chromatogram *.ab1/abd/scf files and ace assemblies while integrating quality.
# Copyright 2014 Tiange Lang and Pauline Garnier-Gere, INRA
# Last updated 22 April 2014
# SeqQual scripts are free to be distributed and/or changed under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version. These scripts are distributed in the hope that they will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details at <http://www.gnu.org/licenses/>.
use Bio::SeqIO;

if (-d "aln_del_empty_seq"){die "already exist dir aln_del_empty_seq\n";}
system ("mkdir aln_del_empty_seq");

@ids=qx{ls};
foreach $input(@ids){
    chomp $input;
    next unless ($input =~ /\.aln$/ || $input =~ /\.fas$/);
    $input2=$input;
    $input2=~s/\.aln//;
    $input2=~s/\.fas//;
    if($input =~ /\.aln$/){$goal="$input2".".del".".aln";}
    if($input =~ /\.fas$/){$goal="$input2".".del".".fas";}
    open OUT, ">$goal";
    $in = Bio::SeqIO -> new (-file => "$input", -format => 'Fasta');
    while ($seqobj = $in -> next_seq()){
	$seq = $seqobj -> seq;
	$seqid = $seqobj -> id;
	if($seq=~/A/||$seq=~/T/||$seq=~/C/||$seq=~/G/||$seq=~/a/||$seq=~/t/||$seq=~/c/||$seq=~/g/){
	    print ">",$seqid,"\n";
	    print OUT ">",$seqid,"\n",$seq,"\n";
	}
    }
    system ("mv $goal aln_del_empty_seq");
}
