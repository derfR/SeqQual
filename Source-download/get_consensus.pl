#!/usr/bin/env perl

if (-d "aln_consensus"){die "already exist dir aln_consensus\n";}
system ("mkdir aln_consensus");

use Bio::SeqIO;
@ids=qx{ls};
foreach $input(@ids){
    chomp $input;
    next unless $input =~ /\.aln/;
    $input2=$input;
    $input2=~s/\.aln//g;
    print $input2,"\n";
    $goal="$input2".".consensus".".fa";
 
    open OUT, ">$goal";
    $in = Bio::SeqIO -> new (-file => "$input", -format => 'Fasta');
    while ($seqobj = $in -> next_seq()){
	$id = $seqobj -> id; 
	$seq = $seqobj -> seq;
	$seq =~ s/-//g;
        print OUT ">",$input2,"_consensus\n",$seq,"\n";
	last;
    }

    system ("mv $goal aln_consensus/");
    system ("cat aln_consensus/*.fa > all_consensus.fa");
}
