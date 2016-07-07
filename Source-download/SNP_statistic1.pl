#!/usr/bin/env perl
# This script is part of the SeqQual pipeline post-processing programs which automatically process chromatogram data and ace assemblies while integrating quality.
# Copyright 2010 Tiange Lang and Pauline Garnier-Gere, INRA
# Last updated 12-05-2010
# SeqQual post-processing programs are free programs: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program. If not, see <http://www.gnu.org/licenses/>.

$arg1=shift;

use Bio::SeqIO;
print "Contig\tPos\tAllele\tAll-$arg1\ta-$arg1\tt-$arg1\tc-$arg1\tg-$arg1\ti-$arg1\tman-$arg1\tmaf-$arg1\thomo1\tnbho1-$arg1\thomo2\tnbho2-$arg1\theter\tnbhet-$arg1\tChi-square-$arg1\treject5%\treject1%\n";
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
	$isSNP=1;$a=0;$t=0;$c=0;$g=0;$indel=0;$all=0;$alleleA=();$alleleT=();$alleleC=();$alleleG=();$alleleI=();@rarealleles=();$aa=0;$tt=0;$cc=0;$gg=0;$ii=0;$at=0;$ac=0;$ag=0;$tc=0;$tg=0;$cg=0;$homo1=();$homo2=();$heter=();$nbho1=0;$nbho2=0;$nbhet=0;
	$in = Bio::SeqIO -> new (-file => "$input", -format => 'Fasta');
	while ($seqobj = $in -> next_seq()){
	    $id = $seqobj -> id; 
	    $seq = $seqobj -> seq; 
	    $base=substr($seq,$i,1);
	    if (uc$base eq "A" && $id=~/^$arg1/){
		$a=$a+2;$all=$all+2;$aa++;
	    }
	    if (uc$base eq "C" && $id=~/^$arg1/){
		$c=$c+2;$all=$all+2;$cc++;
	    }
	    if (uc$base eq "T" && $id=~/^$arg1/){
		$t=$t+2;$all=$all+2;$tt++;
	    }
	    if (uc$base eq "G" && $id=~/^$arg1/){
		$g=$g+2;$all=$all+2;$gg++;
	    }
	    if (uc$base eq "R" && $id=~/^$arg1/){
		$a++;$g++;$all=$all+2;$ag++;
	    }
	    if (uc$base eq "W" && $id=~/^$arg1/){
		$a++;$t++;$all=$all+2;$at++;
	    }
	    if (uc$base eq "M" && $id=~/^$arg1/){
		$a++;$c++;$all=$all+2;$ac++;
	    }
	    if (uc$base eq "K" && $id=~/^$arg1/){
		$g++;$t++;$all=$all+2;$tg++;
	    }
	    if (uc$base eq "Y" && $id=~/^$arg1/){
		$c++;$t++;$all=$all+2;$tc++;
	    }
	    if (uc$base eq "S" && $id=~/^$arg1/){
		$c++;$g++;$all=$all+2;$cg++;
	    }
	    if ($base eq "-" && $id=~/^$arg1/){
		$indel=$indel+2;$all=$all+2;$ii++;
	    }
	}
	if ($a==$all||$t==$all||$c==$all||$g==$all||$indel==$all){$isSNP=0;}
	if ($a>0){$alleleA="A";}
	if ($t>0){$alleleT="T";}
	if ($c>0){$alleleC="C";}
	if ($g>0){$alleleG="G";}
	if ($indel>0){$alleleI="-";}
	$allele=$alleleA.$alleleT.$alleleC.$alleleG.$alleleI;
	@rarealleles=($a,$t,$c,$g,$indel); @rarealleles=sort{$b<=>$a}@rarealleles; 
	if ($rarealleles[1]==$a){
	    if ($rarealleles[0]==$t){$homo1="TT";$homo2="AA";$heter="AT";$nbho1=$tt;$nbho2=$aa;$nbhet=$at;}
	    elsif ($rarealleles[0]==$c){$homo1="CC";$homo2="AA";$heter="AC";$nbho1=$cc;$nbho2=$aa;$nbhet=$ac;}
	    elsif ($rarealleles[0]==$g){$homo1="GG";$homo2="AA";$heter="AG";$nbho1=$gg;$nbho2=$aa;$nbhet=$ag;}
	    else {$homo1="Indel";$homo2="AA";$heter="None";$nbho1=$ii;$nbho2=$aa;$nbhet=0;}
	}
	elsif ($rarealleles[1]==$t){
	    if ($rarealleles[0]==$a){$homo1="AA";$homo2="TT";$heter="AT";$nbho1=$aa;$nbho2=$tt;$nbhet=$at;}
	    elsif ($rarealleles[0]==$c){$homo1="CC";$homo2="TT";$heter="TC";$nbho1=$cc;$nbho2=$tt;$nbhet=$tc;}
	    elsif ($rarealleles[0]==$g){$homo1="GG";$homo2="TT";$heter="TG";$nbho1=$gg;$nbho2=$tt;$nbhet=$tg;}
	    else {$homo1="Indel";$homo2="TT";$heter="None";$nbho1=$ii;$nbho2=$tt;$nbhet=0;}
	}
	elsif ($rarealleles[1]==$c){
	    if ($rarealleles[0]==$a){$homo1="AA";$homo2="CC";$heter="AC";$nbho1=$aa;$nbho2=$cc;$nbhet=$ac;}
	    elsif ($rarealleles[0]==$t){$homo1="TT";$homo2="CC";$heter="TC";$nbho1=$tt;$nbho2=$cc;$nbhet=$tc;}
	    elsif ($rarealleles[0]==$g){$homo1="GG";$homo2="CC";$heter="CG";$nbho1=$gg;$nbho2=$cc;$nbhet=$cg;}
	    else {$homo1="Indel";$homo2="CC";$heter="None";$nbho1=$ii;$nbho2=$cc;$nbhet=0;}
	}
	elsif ($rarealleles[1]==$g){
	    if ($rarealleles[0]==$a){$homo1="AA";$homo2="GG";$heter="AG";$nbho1=$aa;$nbho2=$gg;$nbhet=$ag;}
	    elsif ($rarealleles[0]==$t){$homo1="TT";$homo2="GG";$heter="TC";$nbho1=$tt;$nbho2=$gg;$nbhet=$tc;}
	    elsif ($rarealleles[0]==$c){$homo1="CC";$homo2="GG";$heter="CG";$nbho1=$cc;$nbho2=$gg;$nbhet=$cg;}
	    else {$homo1="Indel";$homo2="GG";$heter="None";$nbho1=$ii;$nbho2=$gg;$nbhet=0;}
	}
	else {
	    if ($rarealleles[0]==$a){$homo1="AA";$homo2="Indel";$heter="None";$nbho1=$aa;$nbho2=$ii;$nbhet=0;}
	    elsif ($rarealleles[0]==$t){$homo1="TT";$homo2="Indel";$heter="None";$nbho1=$tt;$nbho2=$ii;$nbhet=0;}
	    elsif ($rarealleles[0]==$c){$homo1="CC";$homo2="Indel";$heter="None";$nbho1=$cc;$nbho2=$ii;$nbhet=0;}
	    else {$homo1="GG";$homo2="Indel";$heter="None";$nbho1=$gg;$nbho2=$ii;$nbhet=0;}
	}

	if ($all>0){$maf=$rarealleles[1]/$all;} else {$maf=0;}

	$n=$nbho1+$nbhet+$nbho2;

	if ($n>0) {
	    $p=(2*$nbho1+$nbhet)/(2*$n);$q=1-$p;$Enbho1=$p*$p*$n;$Enbhet=2*$p*$q*$n;$Enbho2=$q*$q*$n;
	    if ($Enbho1>0){$OEho1=($nbho1-$Enbho1)**2/$Enbho1} else{$OEho1=0;}
	    if ($Enbho2>0){$OEho2=($nbho2-$Enbho2)**2/$Enbho2} else{$OEho2=0;}
	    if ($Enbhet>0){$OEhet=($nbhet-$Enbhet)**2/$Enbhet} else{$OEhet=0;}
	    $chisquare=$OEho1+$OEho2+$OEhet;$Ht=2*$p*$q;
	}
	else {$chisquare=0;$Ht=0;}

	if ($chisquare>3.84){$reject5percent="yes";} else {$reject5percent="no";}
	if ($chisquare>6.64){$reject1percent="yes";} else {$reject1percent="no";}

	if ($isSNP==1){
	    print "$input2\t",$i+1,"\t$allele\t$all\t$a\t$t\t$c\t$g\t$indel\t$rarealleles[1]\t$maf\t$homo1\t$nbho1\t$homo2\t$nbho2\t$heter\t$nbhet\t$chisquare\t$reject5percent\t$reject1percent\n";
	}
    }
}
