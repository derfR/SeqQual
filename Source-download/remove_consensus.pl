#!/usr/bin/env perl

if (-d "aln_removeconsensus"){die "already exist dir aln_removeconsensus\n";}
system ("mkdir aln_removeconsensus");

use Bio::SeqIO;
@ids=qx{ls};
foreach $input(@ids){
    chomp $input;
    next unless $input =~ /\.aln/;
    $input2=$input;
    $input2=~s/\.aln//g;
    print $input2,"\n";
    $goal="$input2".".removeconsensus".".aln";
 
    open OUT, ">$goal";
    $in = Bio::SeqIO -> new (-file => "$input", -format => 'Fasta');
    $seqobj = $in -> next_seq();
    while ($seqobj = $in -> next_seq()){
	$id = $seqobj -> id; 
	$seq = $seqobj -> seq;
        print OUT ">",$id,"\n",$seq,"\n";
    }

    system ("mv $goal aln_removeconsensus/");
}
