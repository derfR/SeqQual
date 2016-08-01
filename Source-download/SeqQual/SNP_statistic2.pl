#!/usr/bin/env perl

# This script is part of the SeqQual pipeline which automatically process DNA sequences from chromatogram *.ab1/abd/scf files and ace assemblies while integrating quality.
# Copyright 2016 Tiange Lang and Pauline Garnier-Gere, INRA
# Last updated July 2016
# SeqQual scripts are free to be distributed and/or changed under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version. These scripts are distributed in the hope that they will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details at <http://www.gnu.org/licenses/>.
$arg1=shift;
$arg2=shift;

use Bio::SeqIO;
print "Contig\tPos\tAllele\tAll\tAll-$arg1\tAll-$arg2\ta\ta-$arg1\ta-$arg2\tt\tt-$arg1\tt-$arg2\tc\tc-$arg1\tc-$arg2\tg\tg-$arg1\tg-$arg2\ti\ti-$arg1\ti-$arg2\tman\tman-$arg1\tman-$arg2\tmaf\tmaf-$arg1\tmaf-$arg2\thomo1\tnbho1\tnbho1-$arg1\tnbho1-$arg2\thomo2\tnbho2\tnbho2-$arg1\tnbho2-$arg2\theter\tnbhet\tnbhet-$arg1\tnbhet-$arg2\tChi-square\treject5%\treject1%\tChi-square-$arg1\treject5%\treject1%\tChi-square-$arg2\treject5%\treject1%\tXs\tGst\tGst'\n";
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
	$isSNP=1;$isSNP1=1;$isSNP2=1;$a=0;$a1=0;$a2=0;$t=0;$t1=0;$t2=0;$c=0;$c1=0;$c2=0;$g=0;$g1=0;$g2=0;$indel=0;$indel1=0;$indel2=0;$all=0;$all1=0;$all2=0;$alleleA=();$alleleT=();$alleleC=();$alleleG=();$alleleI=();@rarealleles=();$rareallele1=0;$rareallele2=0;$aa=0;$tt=0;$cc=0;$gg=0;$ii=0;$at=0;$ac=0;$ag=0;$tc=0;$tg=0;$cg=0;$aa1=0;$tt1=0;$cc1=0;$gg1=0;$ii1=0;$at1=0;$ac1=0;$ag1=0;$tc1=0;$tg1=0;$cg1=0;$aa2=0;$tt2=0;$cc2=0;$gg2=0;$ii2=0;$at2=0;$ac2=0;$ag2=0;$tc2=0;$tg2=0;$cg2=0;$homo1=();$homo2=();$heter=();$nbho1=0;$nbho2=0;$nbhet=0;$nbho11=0;$nbho12=0;$nbhol21=0;$nbhol22=0;$heter1=0;$heter2=0;
	$in = Bio::SeqIO -> new (-file => "$input", -format => 'Fasta');
	while ($seqobj = $in -> next_seq()){
	    $id = $seqobj -> id; 
	    $seq = $seqobj -> seq; 
	    $base=substr($seq,$i,1);
	    if (uc$base eq "A" && ($id=~/^$arg1/||$id=~/^$arg2/)){
		$a=$a+2;$all=$all+2;$aa++;
		if ($id=~/^$arg1/){$a1=$a1+2;$all1=$all1+2;$aa1++;}
		if ($id=~/^$arg2/){$a2=$a2+2;$all2=$all2+2;$aa2++;}
	    }
	    if (uc$base eq "C" && ($id=~/^$arg1/||$id=~/^$arg2/)){
		$c=$c+2;$all=$all+2;$cc++;
		if ($id=~/^$arg1/){$c1=$c1+2;$all1=$all1+2;$cc1++;}
		if ($id=~/^$arg2/){$c2=$c2+2;$all2=$all2+2;$cc2++;}
	    }
	    if (uc$base eq "T" && ($id=~/^$arg1/||$id=~/^$arg2/)){
		$t=$t+2;$all=$all+2;$tt++;
		if ($id=~/^$arg1/){$t1=$t1+2;$all1=$all1+2;$tt1++;}
		if ($id=~/^$arg2/){$t2=$t2+2;$all2=$all2+2;$tt2++;}
	    }
	    if (uc$base eq "G" && ($id=~/^$arg1/||$id=~/^$arg2/)){
		$g=$g+2;$all=$all+2;$gg++;
		if ($id=~/^$arg1/){$g1=$g1+2;$all1=$all1+2;$gg1++;}
		if ($id=~/^$arg2/){$g2=$g2+2;$all2=$all2+2;$gg2++;}
	    }
	    if (uc$base eq "R" && ($id=~/^$arg1/||$id=~/^$arg2/)){
		$a++;$g++;$all=$all+2;$ag++;
		if ($id=~/^$arg1/){$a1++;$g1++;$all1=$all1+2;$ag1++;}
		if ($id=~/^$arg2/){$a2++;$g2++;$all2=$all2+2;$ag2++;}
	    }
	    if (uc$base eq "W" && ($id=~/^$arg1/||$id=~/^$arg2/)){
		$a++;$t++;$all=$all+2;$at++;
		if ($id=~/^$arg1/){$a1++;$t1++;$all1=$all1+2;$at1++;}
		if ($id=~/^$arg2/){$a2++;$t2++;$all2=$all2+2;$at2++;}
	    }
	    if (uc$base eq "M" && ($id=~/^$arg1/||$id=~/^$arg2/)){
		$a++;$c++;$all=$all+2;$ac++;
		if ($id=~/^$arg1/){$a1++;$c1++;$all1=$all1+2;$ac1++;}
		if ($id=~/^$arg2/){$a2++;$c2++;$all2=$all2+2;$ac2++;}
	    }
	    if (uc$base eq "K" && ($id=~/^$arg1/||$id=~/^$arg2/)){
		$g++;$t++;$all=$all+2;$tg++;
		if ($id=~/^$arg1/){$g1++;$t1++;$all1=$all1+2;$tg1++;}
		if ($id=~/^$arg2/){$g2++;$t2++;$all2=$all2+2;$tg2++;}
	    }
	    if (uc$base eq "Y" && ($id=~/^$arg1/||$id=~/^$arg2/)){
		$c++;$t++;$all=$all+2;$tc++;
		if ($id=~/^$arg1/){$c1++;$t1++;$all1=$all1+2;$tc1++;}
		if ($id=~/^$arg2/){$c2++;$t2++;$all2=$all2+2;$tc2++;}
	    }
	    if (uc$base eq "S" && ($id=~/^$arg1/||$id=~/^$arg2/)){
		$c++;$g++;$all=$all+2;$cg++;
		if ($id=~/^$arg1/){$c1++;$g1++;$all1=$all1+2;$cg1++;}
		if ($id=~/^$arg2/){$c2++;$g2++;$all2=$all2+2;$cg2++;}
	    }
	    if ($base eq "-" && ($id=~/^$arg1/||$id=~/^$arg2/)){
		$indel=$indel+2;$all=$all+2;$ii++;
		if ($id=~/^$arg1/){$indel1=$indel1+2;$all1=$all1+2;$ii1++;}
		if ($id=~/^$arg2/){$indel2=$indel2+2;$all2=$all2+2;$ii2++;}
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
	    if ($rarealleles[0]==$t){$homo1="TT";$homo2="AA";$heter="AT";$nbho1=$tt;$nbho2=$aa;$nbhet=$at;$nbho11=$tt1;$nbho21=$aa1;$nbhet1=$at1;$nbho12=$tt2;$nbho22=$aa2;$nbhet2=$at2;}
	    elsif ($rarealleles[0]==$c){$homo1="CC";$homo2="AA";$heter="AC";$nbho1=$cc;$nbho2=$aa;$nbhet=$ac;$nbho11=$cc1;$nbho21=$aa1;$nbhet1=$ac1;$nbho12=$cc2;$nbho22=$aa2;$nbhet2=$ac2;}
	    elsif ($rarealleles[0]==$g){$homo1="GG";$homo2="AA";$heter="AG";$nbho1=$gg;$nbho2=$aa;$nbhet=$ag;$nbho11=$gg1;$nbho21=$aa1;$nbhet1=$ag1;$nbho12=$gg2;$nbho22=$aa2;$nbhet2=$ag2;}
	    else {$homo1="Indel";$homo2="AA";$heter="None";$nbho1=$ii;$nbho2=$aa;$nbhet=0;$nbho11=$ii1;$nbho21=$aa1;$nbhet1=0;$nbho12=$ii2;$nbho22=$aa2;$nbhet2=0;}
	}
	elsif ($rarealleles[1]==$t){
	    $rareallele1=$t1; $rareallele2=$t2;
	    if ($rarealleles[0]==$a){$homo1="AA";$homo2="TT";$heter="AT";$nbho1=$aa;$nbho2=$tt;$nbhet=$at;$nbho11=$aa1;$nbho21=$tt1;$nbhet1=$at1;$nbho12=$aa2;$nbho22=$tt2;$nbhet2=$at2;}
	    elsif ($rarealleles[0]==$c){$homo1="CC";$homo2="TT";$heter="TC";$nbho1=$cc;$nbho2=$tt;$nbhet=$tc;$nbho11=$cc1;$nbho21=$tt1;$nbhet1=$tc1;$nbho12=$cc2;$nbho22=$tt2;$nbhet2=$tc2;}
	    elsif ($rarealleles[0]==$g){$homo1="GG";$homo2="TT";$heter="TG";$nbho1=$gg;$nbho2=$tt;$nbhet=$tg;$nbho11=$gg1;$nbho21=$tt1;$nbhet1=$tg1;$nbho12=$gg2;$nbho22=$tt2;$nbhet2=$tg2;}
	    else {$homo1="Indel";$homo2="TT";$heter="None";$nbho1=$ii;$nbho2=$tt;$nbhet=0;$nbho11=$ii1;$nbho21=$tt1;$nbhet1=0;$nbho12=$ii2;$nbho22=$tt2;$nbhet2=0;}
	}
	elsif ($rarealleles[1]==$c){
	    $rareallele1=$c1; $rareallele2=$c2;
	    if ($rarealleles[0]==$a){$homo1="AA";$homo2="CC";$heter="AC";$nbho1=$aa;$nbho2=$cc;$nbhet=$ac;$nbho11=$aa1;$nbho21=$cc1;$nbhet1=$ac1;$nbho12=$aa2;$nbho22=$cc2;$nbhet2=$ac2;}
	    elsif ($rarealleles[0]==$t){$homo1="TT";$homo2="CC";$heter="TC";$nbho1=$tt;$nbho2=$cc;$nbhet=$tc;$nbho11=$tt1;$nbho21=$cc1;$nbhet1=$tc1;$nbho12=$tt2;$nbho22=$cc2;$nbhet2=$tc2;}
	    elsif ($rarealleles[0]==$g){$homo1="GG";$homo2="CC";$heter="CG";$nbho1=$gg;$nbho2=$cc;$nbhet=$cg;$nbho11=$gg1;$nbho21=$cc1;$nbhet1=$cg1;$nbho12=$gg2;$nbho22=$cc2;$nbhet2=$cg2;}
	    else {$homo1="Indel";$homo2="CC";$heter="None";$nbho1=$ii;$nbho2=$cc;$nbhet=0;$nbho11=$ii1;$nbho21=$cc1;$nbhet1=0;$nbho12=$ii2;$nbho22=$cc2;$nbhet2=0;}
	}
	elsif ($rarealleles[1]==$g){
	    $rareallele1=$g1; $rareallele2=$g2;
	    if ($rarealleles[0]==$a){$homo1="AA";$homo2="GG";$heter="AG";$nbho1=$aa;$nbho2=$gg;$nbhet=$ag;$nbho11=$aa1;$nbho21=$gg1;$nbhet1=$ag1;$nbho12=$aa2;$nbho22=$gg2;$nbhet2=$ag2;}
	    elsif ($rarealleles[0]==$t){$homo1="TT";$homo2="GG";$heter="TC";$nbho1=$tt;$nbho2=$gg;$nbhet=$tc;$nbho11=$tt1;$nbho21=$gg1;$nbhet1=$tc1;$nbho12=$tt2;$nbho22=$gg2;$nbhet2=$tc2;}
	    elsif ($rarealleles[0]==$c){$homo1="CC";$homo2="GG";$heter="CG";$nbho1=$cc;$nbho2=$gg;$nbhet=$cg;$nbho11=$cc1;$nbho21=$gg1;$nbhet1=$cg1;$nbho12=$cc2;$nbho22=$gg2;$nbhet2=$cg2;}
	    else {$homo1="Indel";$homo2="GG";$heter="None";$nbho1=$ii;$nbho2=$gg;$nbhet=0;$nbho11=$ii1;$nbho21=$gg;$nbhet1=0;$nbho12=$ii2;$nbho22=$gg2;$nbhet=0;}
	}
	else {
	    $rareallele1=$indel1; $rareallele2=$indel2;
	    if ($rarealleles[0]==$a){$homo1="AA";$homo2="Indel";$heter="None";$nbho1=$aa;$nbho2=$ii;$nbhet=0;$nbho11=$aa1;$nbho21=$ii1;$nbhet1=0;$nbho12=$aa2;$nbho22=$ii2;$nbhet2=0;}
	    elsif ($rarealleles[0]==$t){$homo1="TT";$homo2="Indel";$heter="None";$nbho1=$tt;$nbho2=$ii;$nbhet=0;$nbho11=$tt1;$nbho21=$ii1;$nbhet1=0;$nbho12=$tt2;$nbho22=$ii2;$nbhet2=0;}
	    elsif ($rarealleles[0]==$c){$homo1="CC";$homo2="Indel";$heter="None";$nbho1=$cc;$nbho2=$ii;$nbhet=0;$nbho11=$cc1;$nbho21=$ii1;$nbhet1=0;$nbho12=$cc2;$nbho22=$ii2;$nbhet2=0;}
	    else {$homo1="GG";$homo2="Indel";$heter="None";$nbho1=$gg;$nbho2=$ii;$nbhet=0;$nbho11=$gg1;$nbho21=$ii1;$nbhet1=0;$nbho12=$gg2;$nbho22=$ii2;$nbhet2=0;}
	}

	if ($all>0){$maf=$rarealleles[1]/$all;} else {$maf=0;}
	if ($all1>0){$maf1=$rareallele1/$all1;} else {$maf1=0;}
	if ($all2>0){$maf2=$rareallele2/$all2;} else {$maf2=0;}

	$n=$nbho1+$nbhet+$nbho2;$n1=$nbho11+$nbhet1+$nbho21;$n2=$nbho12+$nbhet2+$nbho22;

	if ($n>0) {
	    $p=(2*$nbho1+$nbhet)/(2*$n);$q=1-$p;$Enbho1=$p*$p*$n;$Enbhet=2*$p*$q*$n;$Enbho2=$q*$q*$n;
	    if ($Enbho1>0){$OEho1=($nbho1-$Enbho1)**2/$Enbho1} else{$OEho1=0;}
	    if ($Enbho2>0){$OEho2=($nbho2-$Enbho2)**2/$Enbho2} else{$OEho2=0;}
	    if ($Enbhet>0){$OEhet=($nbhet-$Enbhet)**2/$Enbhet} else{$OEhet=0;}
	    $chisquare=$OEho1+$OEho2+$OEhet;$Ht=2*$p*$q;
	}
	else {$chisquare=0;$Ht=0;}

	if ($n1>0) {
	    $p1=(2*$nbho11+$nbhet1)/(2*$n1);$q1=1-$p1;$Enbho11=$p1*$p1*$n1;$Enbhet1=2*$p1*$q1*$n1;$Enbho21=$q1*$q1*$n1;
	    if ($Enbho11>0){$OEho11=($nbho11-$Enbho11)**2/$Enbho11} else{$OEho11=0;}
	    if ($Enbho21>0){$OEho21=($nbho21-$Enbho21)**2/$Enbho21} else{$OEho21=0;}
	    if ($Enbhet1>0){$OEhet1=($nbhet1-$Enbhet1)**2/$Enbhet1} else{$OEhet1=0;}
	    $chisquare1=$OEho11+$OEho21+$OEhet1;$Hs1=2*$p1*$q1;
	}
	else {$chisquare1=0;$Hs1=0;}

	if ($n2>0) {
	    $p2=(2*$nbho12+$nbhet2)/(2*$n2);$q2=1-$p2;$Enbho12=$p2*$p2*$n2;$Enbhet2=2*$p2*$q2*$n2;$Enbho22=$q2*$q2*$n2;
	    if ($Enbho12>0){$OEho12=($nbho12-$Enbho12)**2/$Enbho12} else{$OEho12=0;}
	    if ($Enbho22>0){$OEho22=($nbho22-$Enbho22)**2/$Enbho22} else{$OEho22=0;}
	    if ($Enbhet2>0){$OEhet2=($nbhet2-$Enbhet2)**2/$Enbhet2} else{$OEhet2=0;}
	    $chisquare2=$OEho12+$OEho22+$OEhet2;$Hs2=2*$p2*$q2;
	}
	else {$chisquare2=0;$Hs2=0;}

	if ($chisquare>3.84){$reject5percent="yes";} else {$reject5percent="no";}
	if ($chisquare>6.64){$reject1percent="yes";} else {$reject1percent="no";}
	if ($chisquare1>3.84){$reject5percent1="yes";} else {$reject5percent1="no";}
	if ($chisquare1>6.64){$reject1percent1="yes";} else {$reject1percent1="no";}
	if ($chisquare2>3.84){$reject5percent2="yes";} else {$reject5percent2="no";}
	if ($chisquare2>6.64){$reject1percent2="yes";} else {$reject1percent2="no";}
	if ($isSNP1==0||$isSNP2==0){$Xs="yes";} else {$Xs="no";}

	$Hs=($Hs1+$Hs2)/2;$Dst=$Ht-$Hs;
	if ($Ht>0){$Gst=($Ht-$Hs)/$Ht;} else {$Gst=0;}
	if (($Hs+2*$Dst)!=0) {$GstPrimer=2*($Ht-$Hs)/($Hs+2*$Dst);} else {$GstPrimer=0;}

	if ($isSNP==1){
	    print "$input2\t",$i+1,"\t$allele\t$all\t$all1\t$all2\t$a\t$a1\t$a2\t$t\t$t1\t$t2\t$c\t$c1\t$c2\t$g\t$g1\t$g2\t$indel\t$indel1\t$indel2\t$rarealleles[1]\t$rareallele1\t$rareallele2\t$maf\t$maf1\t$maf2\t$homo1\t$nbho1\t$nbho11\t$nbho12\t$homo2\t$nbho2\t$nbho21\t$nbho22\t$heter\t$nbhet\t$nbhet1\t$nbhet2\t$chisquare\t$reject5percent\t$reject1percent\t$chisquare1\t$reject5percent1\t$reject1percent1\t$chisquare2\t$reject5percent2\t$reject1percent2\t$Xs\t$Gst\t$GstPrimer\n";
	}
    }
}
