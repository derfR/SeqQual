#!/usr/bin/env perl

# This script is part of the SeqQual pipeline which automatically process DNA sequences from chromatogram *.ab1/abd/scf files and ace assemblies while integrating quality.
# Copyright 2014 Tiange Lang and Pauline Garnier-Gere, INRA
# Last updated 22 April 2014
# SeqQual scripts are free to be distributed and/or changed under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version. These scripts are distributed in the hope that they will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details at <http://www.gnu.org/licenses/>.

if (-d "aln_mask"){die "already exist dir aln_mask\n";}
system ("mkdir aln_mask");

use Getopt::Long;

$man=1;
$man_if_depth=10;
$maf=0.1;
$indel_only="no";

GetOptions("man=i"=>\$man,"man_if_depth=i"=>\$man_if_depth,"maf=f"=>\$maf,"indel_only=s"=>\$indel_only);

use Bio::SeqIO;
@ids=qx{ls};
foreach $input(@ids){
    chomp $input;
    next unless $input =~ /\.aln/;
    $input2=$input;
    $input2=~s/\.aln//g;
    print $input2,"\n";
    $goal="$input2".".clean".".aln";
 
    $in = Bio::SeqIO -> new (-file => "$input", -format => 'Fasta');
    $seqnumber=0;@seqs=();@idseqs=();
    while ($seqobj = $in -> next_seq()){
	$id = $seqobj -> id;
	$seq = $seqobj -> seq;
	$len = $seqobj -> length;
	next if $id=~/^Contig/;
	$seqnumber++;
	push (@idseqs,$id);
	push (@seqs,$seq);
    }   

    for ($i=0;$i<$len;$i++){
	$base_no_a=0;$base_no_t=0;$base_no_c=0;$base_no_g=0;$base_no_r=0;$base_no_y=0;$base_no_m=0;$base_no_k=0;$base_no_w=0;$base_no_s=0;$base_no_i=0;$base_no_real=0;
	$in = Bio::SeqIO -> new (-file => "$input", -format => 'Fasta');
	while ($seqobj = $in -> next_seq()){
	    $id = $seqobj -> id; 
	    $seq = $seqobj -> seq; 
	    next if $id=~/^Contig/;
	    $base=substr($seq,$i,1);
	    if(uc$base eq "A"){$base_no_a++;}
	    if(uc$base eq "T"){$base_no_t++;}
	    if(uc$base eq "C"){$base_no_c++;}
	    if(uc$base eq "G"){$base_no_g++;}
	 #   if(uc$base eq "R"){$base_no_r++;}
	 #   if(uc$base eq "Y"){$base_no_y++;}
	 #   if(uc$base eq "M"){$base_no_m++;}
	 #   if(uc$base eq "K"){$base_no_k++;}
	 #   if(uc$base eq "W"){$base_no_w++;}
	 #   if(uc$base eq "S"){$base_no_s++;}
	 #   if(uc$base eq "N"){$base_no_n++;}
	    if($base eq "-"){$base_no_i++;}
	    unless($base eq "?"){$base_no_real++;}
	}
       	for ($j=0;$j<$seqnumber;$j++){
	    $base=substr($seqs[$j],$i,1);
		if(uc$base eq "R") {$seqs[$j]=substr($seqs[$j],0,$i)."?".substr($seqs[$j],$i+1,$len);}
		if(uc$base eq "Y") {$seqs[$j]=substr($seqs[$j],0,$i)."?".substr($seqs[$j],$i+1,$len);}
		if(uc$base eq "M") {$seqs[$j]=substr($seqs[$j],0,$i)."?".substr($seqs[$j],$i+1,$len);}
		if(uc$base eq "K") {$seqs[$j]=substr($seqs[$j],0,$i)."?".substr($seqs[$j],$i+1,$len);}
		if(uc$base eq "W") {$seqs[$j]=substr($seqs[$j],0,$i)."?".substr($seqs[$j],$i+1,$len);}
		if(uc$base eq "S") {$seqs[$j]=substr($seqs[$j],0,$i)."?".substr($seqs[$j],$i+1,$len);}
		if(uc$base eq "N") {$seqs[$j]=substr($seqs[$j],0,$i)."?".substr($seqs[$j],$i+1,$len);}
	    unless ($indel_only eq "yes"){
		if((uc$base eq "A") && (($base_no_a<=$man && $base_no_real>=$man_if_depth) || $base_no_a/$base_no_real<=$maf)){$seqs[$j]=substr($seqs[$j],0,$i)."?".substr($seqs[$j],$i+1,$len);}
		if((uc$base eq "T") && (($base_no_t<=$man && $base_no_real>=$man_if_depth) || $base_no_t/$base_no_real<=$maf)){$seqs[$j]=substr($seqs[$j],0,$i)."?".substr($seqs[$j],$i+1,$len);}
		if((uc$base eq "C") && (($base_no_c<=$man && $base_no_real>=$man_if_depth) || $base_no_c/$base_no_real<=$maf)){$seqs[$j]=substr($seqs[$j],0,$i)."?".substr($seqs[$j],$i+1,$len);}
		if((uc$base eq "G") && (($base_no_g<=$man && $base_no_real>=$man_if_depth) || $base_no_g/$base_no_real<=$maf)){$seqs[$j]=substr($seqs[$j],0,$i)."?".substr($seqs[$j],$i+1,$len);}
		if(($base eq "-") && (($base_no_i<=$man && $base_no_real>=$man_if_depth) || $base_no_i/$base_no_real<=$maf)){$seqs[$j]=substr($seqs[$j],0,$i)."?".substr($seqs[$j],$i+1,$len);}
	    }
	    else {
                if(($base eq "-") && (($base_no_i<=$man && $base_no_real>=$man_if_depth) || $base_no_i/$base_no_real<=$maf)){$seqs[$j]=substr($seqs[$j],0,$i)."?".substr($seqs[$j],$i+1,$len);}
		if((uc$base eq "A" && $base_no_i != 0) && (($base_no_a<=$man && $base_no_real>=$man_if_depth) || $base_no_a/$base_no_real<=$maf)){$seqs[$j]=substr($seqs[$j],0,$i)."?".substr($seqs[$j],$i+1,$len);}
		if((uc$base eq "T"&& $base_no_i != 0) && (($base_no_t<=$man && $base_no_real>=$man_if_depth) || $base_no_t/$base_no_real<=$maf)){$seqs[$j]=substr($seqs[$j],0,$i)."?".substr($seqs[$j],$i+1,$len);}
		if((uc$base eq "C"&& $base_no_i != 0) && (($base_no_c<=$man && $base_no_real>=$man_if_depth) || $base_no_c/$base_no_real<=$maf)){$seqs[$j]=substr($seqs[$j],0,$i)."?".substr($seqs[$j],$i+1,$len);}
		if((uc$base eq "G"&& $base_no_i != 0) && (($base_no_g<=$man && $base_no_real>=$man_if_depth) || $base_no_g/$base_no_real<=$maf)){$seqs[$j]=substr($seqs[$j],0,$i)."?".substr($seqs[$j],$i+1,$len);}
            }
	}       
    }
    open OUT, ">$goal";
    for ($j=0;$j<$seqnumber;$j++){
	print OUT ">",$idseqs[$j],"\n",$seqs[$j],"\n";
    }
    close OUT;
    system ("mv $goal aln_mask/");
}
