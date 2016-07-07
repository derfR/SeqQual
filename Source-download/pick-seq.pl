#!/usr/bin/env perl

$arg0=$ARGV[0];
$arg1=$ARGV[1];
$arg2=$ARGV[2];
$arg3=$ARGV[3];
$arg4=$ARGV[4];
$arg5=$ARGV[5];
$arg6=$ARGV[6];
$arg7=$ARGV[7];
$arg8=$ARGV[8];
$arg9=$ARGV[9];
$arg10=$ARGV[10];
$arg11=$ARGV[11];
$arg12=$ARGV[12];
$arg13=$ARGV[13];
$arg14=$ARGV[14];
$arg15=$ARGV[15];
$arg16=$ARGV[16];
$arg17=$ARGV[17];
$arg18=$ARGV[18];
$arg19=$ARGV[19];
$arg20=$ARGV[20];
$arg21=$ARGV[21];
$arg22=$ARGV[22];
$arg23=$ARGV[23];
$arg24=$ARGV[24];

if (-d "aln_pick"){die "already exist dir aln_pick\n";}
system ("mkdir aln_pick");

use Bio::SeqIO;
@ids=qx{ls};
foreach $input(@ids){
    chomp $input;
    next unless $input =~ /\.aln/;
    $input2=$input;
    $input2=~s/\.aln//g;
    print $input2,"\n";
    $goal="$input2".".pick".".aln";
    %entry=();
    $in = Bio::SeqIO -> new (-file => "$input", -format => 'Fasta');
    while ($seqobj = $in -> next_seq()){
	$id = $seqobj -> id; 
	$seq = $seqobj -> seq;
	if (($arg0&&$id=~/^$arg0/)||($arg1&&$id=~/^$arg1/)||($arg2&&$id=~/^$arg2/)||($arg3&&$id=~/^$arg3/)||($arg4&&$id=~/^$arg4/)||($arg5&&$id=~/^$arg5/)||($arg6&&$id=~/^$arg6/)||($arg7&&$id=~/^$arg7/)||($arg8&&$id=~/^$arg8/)||($arg9&&$id=~/^$arg9/)||($arg10&&$id=~/^$arg10/)||($arg11&&$id=~/^$arg11/)||($arg12&&$id=~/^$arg12/)||($arg13&&$id=~/^$arg13/)||($arg14&&$id=~/^$arg14/)||($arg15&&$id=~/^$arg15/)||($arg16&&$id=~/^$arg16/)||($arg17&&$id=~/^$arg17/)||($arg18&&$id=~/^$arg18/)||($arg19&&$id=~/^$arg19/)||($arg20&&$id=~/^$arg20/)||($arg21&&$id=~/^$arg21/)||($arg22&&$id=~/^$arg22/)||($arg23&&$id=~/^$arg23/)||($arg24&&$id=~/^$arg24/)) {$entry{$id} = $seq;}
    }
 
    open OUT, ">$goal";
    foreach $id (sort keys %entry){
	next unless $entry{$id}=~/\w/;
	print OUT ">",$id,"\n",$entry{$id},"\n";
    }
    system ("mv $goal aln_pick/");
}
