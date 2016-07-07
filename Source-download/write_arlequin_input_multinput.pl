#!/usr/bin/env perl

# This script is part of the SeqQual pipeline which automatically process chromatogram data and ace assemblies while integrating quality.
# Copyright 2010 Tiange Lang and Pauline Garnier-Géré, INRA
# Last updated 26-April-2010
# SeqQual is a free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program. If not, see <http://www.gnu.org/licenses/>.

use Bio::SeqIO; 

$arg1=$ARGV[0];
$arg2=$ARGV[1];
$arg3=$ARGV[2];
$arg4=$ARGV[3];
$arg5=$ARGV[4];
$arg6=$ARGV[5];
$arg7=$ARGV[6];
$arg8=$ARGV[7];
$arg9=$ARGV[8];
$arg10=$ARGV[9];
$arg11=$ARGV[10];
$arg12=$ARGV[11];
$arg13=$ARGV[12];
$arg14=$ARGV[13];
$arg15=$ARGV[14];
$arg16=$ARGV[15];
$arg17=$ARGV[16];
$arg18=$ARGV[17];
$arg19=$ARGV[18];
$arg20=$ARGV[19];

if (-d "arlequin_input"){die "already exist dir arlequin_input\n";}
system ("mkdir arlequin_input");

@ids=qx{ls};
foreach $input(@ids){
    chomp $input;
    next unless $input =~ /\.aln/;
    $input2=$input;
    $input2=~s/\.aln//g;
    print $input2,"\n";
    $goal="$input2".".arp";

    $in = Bio::SeqIO -> new (-file => "$input", -format => 'Fasta');
    open OUT, ">$goal";
    print OUT "[Profile]\n\nTitle=\"$input\"\nNbSamples=";
    if (scalar(@ARGV)==0){print OUT "1";}
    else {print OUT scalar(@ARGV);}
    print OUT "\nGenotypicData=0\nDataType=DNA\nLocusSeparator=NONE\nGameticPhase=1\nMissingData='?'\n\n[Data]\n\n[[Samples]]\n";
    
    if ($arg1){

	%entry1=(); %entry2=();%entry3=(); %entry4=(); %entry5=(); %entry6=(); %entry7=(); %entry8=(); %entry9=(); %entry10=(); %entry11=(); %entry12=();%entry13=(); %entry14=(); %entry15=(); %entry16=(); %entry17=(); %entry18=(); %entry19=(); %entry20=(); 
	while ($seqobj = $in -> next_seq()){
	    $id = $seqobj -> id;
    	    if ($id=~/^Contig/){next;}
	    for ($i=0;$i<50-length($id);$i++){$id=$id." ";}
	    $seq = $seqobj -> seq;
	    if ($id=~/^$arg1/ && $arg1) {$entry1{$id} = $seq;}
	    if ($id=~/^$arg2/ && $arg2) {$entry2{$id} = $seq;}
	    if ($id=~/^$arg3/ && $arg3) {$entry3{$id} = $seq;}
	    if ($id=~/^$arg4/ && $arg4) {$entry4{$id} = $seq;}
	    if ($id=~/^$arg5/ && $arg5) {$entry5{$id} = $seq;}
	    if ($id=~/^$arg6/ && $arg6) {$entry6{$id} = $seq;}
	    if ($id=~/^$arg7/ && $arg7) {$entry7{$id} = $seq;}
	    if ($id=~/^$arg8/ && $arg8) {$entry8{$id} = $seq;}
	    if ($id=~/^$arg9/ && $arg9) {$entry9{$id} = $seq;}
	    if ($id=~/^$arg10/ && $arg10) {$entry10{$id} = $seq;}
	    if ($id=~/^$arg11/ && $arg11) {$entry11{$id} = $seq;}
	    if ($id=~/^$arg12/ && $arg12) {$entry12{$id} = $seq;}
	    if ($id=~/^$arg13/ && $arg13) {$entry13{$id} = $seq;}
	    if ($id=~/^$arg14/ && $arg14) {$entry14{$id} = $seq;}
	    if ($id=~/^$arg15/ && $arg15) {$entry15{$id} = $seq;}
	    if ($id=~/^$arg16/ && $arg16) {$entry16{$id} = $seq;}
	    if ($id=~/^$arg17/ && $arg17) {$entry17{$id} = $seq;}
	    if ($id=~/^$arg18/ && $arg18) {$entry18{$id} = $seq;}
	    if ($id=~/^$arg19/ && $arg19) {$entry19{$id} = $seq;}
	    if ($id=~/^$arg20/ && $arg20) {$entry20{$id} = $seq;}
	}
	$size1=scalar(keys %entry1);$size2=scalar(keys %entry2);$size3=scalar(keys %entry3);$size4=scalar(keys %entry4);$size5=scalar(keys %entry5);$size6=scalar(keys %entry6);$size7=scalar(keys %entry7);$size8=scalar(keys %entry8);$size9=scalar(keys %entry9);$size10=scalar(keys %entry10);$size11=scalar(keys %entry11);$size12=scalar(keys %entry12);$size13=scalar(keys %entry13);$size14=scalar(keys %entry14);$size15=scalar(keys %entry15);$size16=scalar(keys %entry16);$size17=scalar(keys %entry17);$size18=scalar(keys %entry18);$size19=scalar(keys %entry19);$size20=scalar(keys %entry20);
    
	if (%entry1){
	    print OUT "SampleName=\"",$arg1,"\"\nSampleSize=",$size1,"\nSampleData={\n";
	    foreach $id (sort keys %entry1){
		print OUT $id,"\t1\t",$entry1{$id},"\n";
	    }
	    print OUT "}\n";
	}
    
	if (%entry2){
	    print OUT "SampleName=\"",$arg2,"\"\nSampleSize=",$size2,"\nSampleData={\n";
	    foreach $id (sort keys %entry2){
		print OUT $id,"\t1\t",$entry2{$id},"\n";
	    }
	    print OUT "}\n";
	}
    
	if (%entry3){
	    print OUT "SampleName=\"",$arg3,"\"\nSampleSize=",$size3,"\nSampleData={\n";
	    foreach $id (sort keys %entry3){
		print OUT $id,"\t1\t",$entry3{$id},"\n";
	    }
	    print OUT "}\n";
	}
    
	if (%entry4){
	    print OUT "SampleName=\"",$arg4,"\"\nSampleSize=",$size4,"\nSampleData={\n";
	    foreach $id (sort keys %entry4){
		print OUT $id,"\t1\t",$entry4{$id},"\n";
	    }
	    print OUT "}\n";
	}
    
	if (%entry5){
	    print OUT "SampleName=\"",$arg5,"\"\nSampleSize=",$size5,"\nSampleData={\n";
	    foreach $id (sort keys %entry5){
		print OUT $id,"\t1\t",$entry5{$id},"\n";
	    }
	    print OUT "}\n";
	}
    
	if (%entry6){
	    print OUT "SampleName=\"",$arg6,"\"\nSampleSize=",$size6,"\nSampleData={\n";
	    foreach $id (sort keys %entry6){
		print OUT $id,"\t1\t",$entry6{$id},"\n";
	    }
	    print OUT "}\n";
	}
    
	if (%entry7){
	    print OUT "SampleName=\"",$arg7,"\"\nSampleSize=",$size7,"\nSampleData={\n";
	    foreach $id (sort keys %entry7){
		print OUT $id,"\t1\t",$entry7{$id},"\n";
	    }
	    print OUT "}\n";
	}
    
	if (%entry8){
	    print OUT "SampleName=\"",$arg8,"\"\nSampleSize=",$size8,"\nSampleData={\n";
	    foreach $id (sort keys %entry8){
		print OUT $id,"\t1\t",$entry8{$id},"\n";
	    }
	    print OUT "}\n";
	}
    
	if (%entry9){
	    print OUT "SampleName=\"",$arg9,"\"\nSampleSize=",$size9,"\nSampleData={\n";
	    foreach $id (sort keys %entry9){
		print OUT $id,"\t1\t",$entry9{$id},"\n";
	    }
	    print OUT "}\n";
	}
    
	if (%entry10){
	    print OUT "SampleName=\"",$arg10,"\"\nSampleSize=",$size10,"\nSampleData={\n";
	    foreach $id (sort keys %entry10){
		print OUT $id,"\t1\t",$entry10{$id},"\n";
	    }
	    print OUT "}\n";
	}
    
	if (%entry11){
	    print OUT "SampleName=\"",$arg11,"\"\nSampleSize=",$size11,"\nSampleData={\n";
	    foreach $id (sort keys %entry11){
		print OUT $id,"\t1\t",$entry11{$id},"\n";
	    }
	    print OUT "}\n";
	}
    
	if (%entry12){
	    print OUT "SampleName=\"",$arg12,"\"\nSampleSize=",$size12,"\nSampleData={\n";
	    foreach $id (sort keys %entry12){
		print OUT $id,"\t1\t",$entry12{$id},"\n";
	    }
	    print OUT "}\n";
	}
    
	if (%entry13){
	    print OUT "SampleName=\"",$arg13,"\"\nSampleSize=",$size13,"\nSampleData={\n";
	    foreach $id (sort keys %entry13){
		print OUT $id,"\t1\t",$entry13{$id},"\n";
	    }
	    print OUT "}\n";
	}
    
	if (%entry14){
	    print OUT "SampleName=\"",$arg14,"\"\nSampleSize=",$size14,"\nSampleData={\n";
	    foreach $id (sort keys %entry14){
		print OUT $id,"\t1\t",$entry14{$id},"\n";
	    }
	    print OUT "}\n";
	}
    
	if (%entry15){
	    print OUT "SampleName=\"",$arg15,"\"\nSampleSize=",$size15,"\nSampleData={\n";
	    foreach $id (sort keys %entry15){
		print OUT $id,"\t1\t",$entry15{$id},"\n";
	    }
	    print OUT "}\n";
	}
    
	if (%entry16){
	    print OUT "SampleName=\"",$arg16,"\"\nSampleSize=",$size16,"\nSampleData={\n";
	    foreach $id (sort keys %entry16){
		print OUT $id,"\t1\t",$entry16{$id},"\n";
	    }
	    print OUT "}\n";
	}
    
	if (%entry17){
	    print OUT "SampleName=\"",$arg17,"\"\nSampleSize=",$size17,"\nSampleData={\n";
	    foreach $id (sort keys %entry17){
		print OUT $id,"\t1\t",$entry17{$id},"\n";
	    }
	    print OUT "}\n";
	}
    
	if (%entry18){
	    print OUT "SampleName=\"",$arg18,"\"\nSampleSize=",$size18,"\nSampleData={\n";
	    foreach $id (sort keys %entry18){
		print OUT $id,"\t1\t",$entry18{$id},"\n";
	    }
	    print OUT "}\n";
	}
    
	if (%entry19){
	    print OUT "SampleName=\"",$arg19,"\"\nSampleSize=",$size19,"\nSampleData={\n";
	    foreach $id (sort keys %entry19){
		print OUT $id,"\t1\t",$entry19{$id},"\n";
	    }
	    print OUT "}\n";
	}
    
	if (%entry20){
	    print OUT "SampleName=\"",$arg20,"\"\nSampleSize=",$size20,"\nSampleData={\n";
	    foreach $id (sort keys %entry20){
		print OUT $id,"\t1\t",$entry20{$id},"\n";
	    }
	    print OUT "}\n";
	}
	print OUT "\n[[Structure]]\nStructureName=\"Structure in ",scalar(@ARGV)," samples\"\nNbGroups=1\nGroup={\n";
    
	if (%entry1 != ()){
	    print OUT "\"",$arg1,"\"\n";
	}
    
	if (%entry2 != ()){
	    print OUT "\"",$arg2,"\"\n";
	}
    
	if (%entry3 != ()){
	    print OUT "\"",$arg3,"\"\n";
	}
    
	if (%entry4 != ()){
	    print OUT "\"",$arg4,"\"\n";
	}
    
	if (%entry5 != ()){
	    print OUT "\"",$arg5,"\"\n";
	}
    
	if (%entry6 != ()){
	    print OUT "\"",$arg6,"\"\n";
	}
    
	if (%entry7 != ()){
	    print OUT "\"",$arg7,"\"\n";
	}
    
	if (%entry8 != ()){
	    print OUT "\"",$arg8,"\"\n";
	}
    
	if (%entry9 != ()){
	    print OUT "\"",$arg9,"\"\n";
	}
    
	if (%entry10 != ()){
	    print OUT "\"",$arg10,"\"\n";
	}
    
	if (%entry11 != ()){
	    print OUT "\"",$arg11,"\"\n";
	}
    
	if (%entry12 != ()){
	    print OUT "\"",$arg12,"\"\n";
	}
    
	if (%entry13 != ()){
	    print OUT "\"",$arg13,"\"\n";
	}
    
	if (%entry14 != ()){
	    print OUT "\"",$arg14,"\"\n";
	}
    
	if (%entry15 != ()){
	    print OUT "\"",$arg15,"\"\n";
	}
    
	if (%entry16 != ()){
	    print OUT "\"",$arg16,"\"\n";
	}
    
	if (%entry17 != ()){
	    print OUT "\"",$arg17,"\"\n";
	}
    
	if (%entry18 != ()){
	    print OUT "\"",$arg18,"\"\n";
	}
    
	if (%entry19 != ()){
	    print OUT "\"",$arg19,"\"\n";
	}
    
	if (%entry20 != ()){
	    print OUT "\"",$arg20,"\"\n";
	}

	print OUT "}\n";
    }

    else{
	%entry1=(); 
	while ($seqobj = $in -> next_seq()){
	    $id = $seqobj -> id;
    	    if ($id=~/^Contig/){next;}
	    for ($i=0;$i<50-length($id);$i++){$id=$id." ";}
	    $seq = $seqobj -> seq;
	    $entry1{$id} = $seq;
	}
	$size1=scalar(keys %entry1);

	print OUT "\nSampleName=\"Noname\"\nSampleSize=",$size1,"\nSampleData={\n";

	foreach $id (sort keys %entry1){
	    print OUT $id,"\t1\t",$entry1{$id},"\n";
	}
	
	print OUT "}\n\n[[Structure]]\nStructureName=\"Structure in 1 samples\"\nNbGroups=1\nGroup={\n\"Noname\"\n}\n";
	
    }

    system ("mv $goal arlequin_input/"); 
}
