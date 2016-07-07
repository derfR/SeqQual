#!/usr/bin/env perl
# This script is part of the SeqQual pipeline which automatically process chromatogram data and ace assemblies while integrating quality.
# Copyright 2014 Tiange Lang and Pauline Garnier-Gere, INRA
# Last updated 22-April-2014
# SeqQual is a free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details  at http://www.gnu.org/licenses/.

use Bio::SeqIO;
print "Contig\tPos\tAllele\tAll\ta\tt\tc\tg\ti\tman\tmaf\n"; # modif remove homoz and nbhomoz columns
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
	    if (uc$base eq "A"){
		$a++;$all++;
	    }
	    if (uc$base eq "C"){
		$c++;$all++;
	    }
	    if (uc$base eq "T"){
		$t++;$all++;
	    }
	    if (uc$base eq "G"){
		$g++;$all++;
	    }
	    if ($base eq "-"){
		$indel++;$all++;
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
		
	if ($all>0){$maf=$rarealleles[1]/$all;} else {$maf=0;}

	if ($isSNP==1){
	    print "$input2\t",$i+1,"\t$allele\t$all\t$a\t$t\t$c\t$g\t$indel\t$rarealleles[1]\t$maf\n";
	}
    }
}
