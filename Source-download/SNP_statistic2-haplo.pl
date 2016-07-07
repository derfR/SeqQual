#!/usr/bin/env perl
# This script is part of the SeqQual pipeline which automatically process chromatogram data and ace assemblies while integrating quality.
# Copyright 2014 Tiange Lang and Pauline Garnier-Gere, INRA
# Last updated 22-April-2014
# SeqQual is a free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details  at http://www.gnu.org/licenses/.


$arg1=shift;
$arg2=shift;

use Bio::SeqIO;
print "Contig\tPos\tAllele\tAll\tAll-$arg1\tAll-$arg2\ta\ta-$arg1\ta-$arg2\tt\tt-$arg1\tt-$arg2\tc\tc-$arg1\tc-$arg2\tg\tg-$arg1\tg-$arg2\ti\ti-$arg1\ti-$arg2\tman\tman-$arg1\tman-$arg2\tmaf\tmaf-$arg1\tmaf-$arg2\tXs\tGst\tGst'\n";
@ids=qx{ls};
foreach $input(@ids){
    chomp $input;
    next unless $input =~ /\.aln/;
    $input2=$input;
    $input2=~s/\.aln//g;
 
    $in = Bio::SeqIO -> new (-file => "$input", -format => 'Fasta');
    while ($seqobj = $in -> next_seq()){
	$len = $seqobj -> length; next;
    }
    
    for ($i=0;$i<$len;$i++){
	$isSNP=1;$isSNP1=1;$isSNP2=1;$a=0;$a1=0;$a2=0;$t=0;$t1=0;$t2=0;$c=0;$c1=0;$c2=0;$g=0;$g1=0;$g2=0;$indel=0;$indel1=0;$indel2=0;$all=0;$all1=0;$all2=0;$alleleA=();$alleleT=();$alleleC=();$alleleG=();$alleleI=();@rarealleles=();$rareallele1=0;$rareallele2=0;
$aa=0;$tt=0;$cc=0;$gg=0;$ii=0;$at=0;$ac=0;$ag=0;$tc=0;$tg=0;$cg=0;$aa1=0;$tt1=0;$cc1=0;$gg1=0;$ii1=0;$at1=0;$ac1=0;$ag1=0;$tc1=0;$tg1=0;$cg1=0;$aa2=0;$tt2=0;$cc2=0;$gg2=0;$ii2=0;$at2=0;$ac2=0;$ag2=0;$tc2=0;$tg2=0;$cg2=0;$homo1=();$homo2=();$heter=();$nbho1=0;$nbho2=0;$nbhet=0;$nbho11=0;$nbho12=0;$nbhol21=0;$nbhol22=0;$heter1=0;$heter2=0;
	$in = Bio::SeqIO -> new (-file => "$input", -format => 'Fasta');
	while ($seqobj = $in -> next_seq()){
	    $id = $seqobj -> id; 
	    $seq = $seqobj -> seq; 
	    $base=substr($seq,$i,1);
	    if (uc$base eq "A" && ($id=~/^$arg1/||$id=~/^$arg2/)){
		$a++;$all++;
		if ($id=~/^$arg1/){$a1++;$all1++;}
		if ($id=~/^$arg2/){$a2++;$all2++;}
	    }
	    if (uc$base eq "C" && ($id=~/^$arg1/||$id=~/^$arg2/)){
		$c++;$all++;
		if ($id=~/^$arg1/){$c1++;$all1++;}
		if ($id=~/^$arg2/){$c2++;$all2++;}
	    }
	    if (uc$base eq "T" && ($id=~/^$arg1/||$id=~/^$arg2/)){
		$t++;$all++;
		if ($id=~/^$arg1/){$t1++;$all1++;}
		if ($id=~/^$arg2/){$t2++;$all2++;}
	    }
	    if (uc$base eq "G" && ($id=~/^$arg1/||$id=~/^$arg2/)){
		$g++;$all++;
		if ($id=~/^$arg1/){$g1++;$all1++;}
		if ($id=~/^$arg2/){$g2++;$all2++;}
	    }
	    if ($base eq "-" && ($id=~/^$arg1/||$id=~/^$arg2/)){
		$indel++;$all++;
		if ($id=~/^$arg1/){$indel1++;$all1++;}
		if ($id=~/^$arg2/){$indel2++;$all2++;}
	    }
	}
	if ($a==$all||$t==$all||$c==$all||$g==$all||$indel==$all){$isSNP=0;}
	if ($a1==$all1||$t1==$all1||$c1==$all1||$g1==$all1||$indel1==$all1){$isSNP1=0;}
	if ($a2==$all2||$t2==$all2||$c2==$all2||$g2==$all2||$indel2==$all2){$isSNP2=0;}
	if ($a>0){$alleleA="A";}
	if ($t>0){$alleleT="T";}
	if ($c>0){$alleleC="C";}
	if ($g>0){$alleleG="G";}
	if ($indel>0){$alleleI="-";}
	$allele=$alleleA.$alleleT.$alleleC.$alleleG.$alleleI;
	@rarealleles=($a,$t,$c,$g,$indel); @rarealleles=sort{$b<=>$a}@rarealleles; 
	if ($rarealleles[1]==$a){
	    $rareallele1=$a1; $rareallele2=$a2;
	}
	elsif ($rarealleles[1]==$t){
	    $rareallele1=$t1; $rareallele2=$t2;
	}
	elsif ($rarealleles[1]==$c){
	    $rareallele1=$c1; $rareallele2=$c2;
	}
	elsif ($rarealleles[1]==$g){
	    $rareallele1=$g1; $rareallele2=$g2;
	}
	else {
	    $rareallele1=$indel1; $rareallele2=$indel2;
	}

	if ($all>0){$maf=$rarealleles[1]/$all;} else {$maf=0;}
	if ($all1>0){$maf1=$rareallele1/$all1;} else {$maf1=0;}
	if ($all2>0){$maf2=$rareallele2/$all2;} else {$maf2=0;}

	$n=$nbho1+$nbhet+$nbho2;$n1=$nbho11+$nbhet1+$nbho21;$n2=$nbho12+$nbhet2+$nbho22;
# new code from Pauline for computing expected diversity based on allele frequencies, not from genotypes
	if ($all>0) {
	    $Ht=(2*$maf*(1-$maf));
	}
	else {$Ht=0;}

	if ($all1>0) {
            $Hs1=(2*$maf1*(1-$maf1));
	}
	else {$Hs1=0;}
	if ($all2>0) {
	    $Hs2=(2*$maf2*(1-$maf2));
	}
	else {$Hs2=0;}
	if ($isSNP1==0||$isSNP2==0){$Xs="yes";} else {$Xs="no";}

	$Hs=($Hs1+$Hs2)/2;$Dst=$Ht-$Hs;
	if ($Ht>0){$Gst=($Ht-$Hs)/$Ht;} else {$Gst=0;}
	if (($Hs+2*$Dst)!=0) {$GstPrime=2*($Ht-$Hs)/($Hs+2*$Dst);} else {$GstPrime=0;}

	if ($isSNP==1){
	    print "$input2\t",$i+1,"\t$allele\t$all\t$all1\t$all2\t$a\t$a1\t$a2\t$t\t$t1\t$t2\t$c\t$c1\t$c2\t$g\t$g1\t$g2\t$indel\t$indel1\t$indel2\t$rarealleles[1]\t$rareallele1\t$rareallele2\t$maf\t$maf1\t$maf2\t$Xs\t$Gst\t$GstPrime\n";
	}
    }
}
