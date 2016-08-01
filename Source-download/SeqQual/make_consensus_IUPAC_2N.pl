#!/usr/bin/env perl

# This script is part of the SeqQual pipeline which automatically process DNA sequences from chromatogram *.ab1/abd/scf files and ace assemblies while integrating quality.
# Copyright 2016 Tiange Lang and Pauline Garnier-Gere, INRA
# Last updated July 2016
# SeqQual scripts are free to be distributed and/or changed under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version. These scripts are distributed in the hope that they will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details at <http://www.gnu.org/licenses/>.

if (-d "aln_cons_IUPAC"){die "already exist dir aln_cons_IUPAC\n";}
system ("mkdir aln_cons_IUPAC");

use Bio::SeqIO;
@ids=qx{ls};
foreach $input(@ids){
    chomp $input;
    next unless $input =~ /\.aln/;
    $input2=$input;
    $input2=~s/\.aln//g;
    print $input2,"\n";
    $goal="$input2".".nc".".aln";
 
    $in = Bio::SeqIO -> new (-file => "$input", -format => 'Fasta');
    while ($seqobj = $in -> next_seq()){
	$len = $seqobj -> length; 
	next;
    }
    
    $consensus="";
    for ($i=0;$i<$len;$i++){
	$a=0;$t=0,$c=0;$g=0;$indel=0;$site="N";@nb=();
	$in = Bio::SeqIO -> new (-file => "$input", -format => 'Fasta');
	while ($seqobj = $in -> next_seq()){
	    $id = $seqobj -> id; 
	    $seq = $seqobj -> seq; 
	    next if $id=~/^Contig/;
	    $base=substr($seq,$i,1);
	    if (uc$base eq "A"){$a=$a+2;}
	    if (uc$base eq "T"){$t=$t+2;}
	    if (uc$base eq "C"){$c=$c+2;}
	    if (uc$base eq "G"){$g=$g+2;}
	    if (uc$base eq "R"){$a++;$g++;}
	    if (uc$base eq "W"){$a++;$t++;}
	    if (uc$base eq "M"){$a++;$c++;}
	    if (uc$base eq "K"){$g++;$t++;}
	    if (uc$base eq "Y"){$c++;$t++;}
	    if (uc$base eq "S"){$c++;$g++;}
	    if ($base eq "-"){$indel=$indel+2;}
	}
	@nb=($a,$t,$c,$g,$indel);
	@nb=sort{$b<=>$a}@nb;
	if ($nb[0]==0){$site="N";}
	elsif ($nb[0]==$a){
	    if ($nb[1]==0){$site="A";}
	    elsif ($nb[1]==$t){$site="W";}
	    elsif ($nb[1]==$c){$site="M";}
	    elsif ($nb[1]==$g){$site="R";}
	    else {$site="a";}
	}
	elsif ($nb[0]==$t){
	    if ($nb[1]==0){$site="T";}
	    elsif ($nb[1]==$a){$site="W";}
	    elsif ($nb[1]==$c){$site="Y";}
	    elsif ($nb[1]==$g){$site="K";}
	    else {$site="t";}
	}
	elsif ($nb[0]==$c){
	    if ($nb[1]==0){$site="C";}
	    elsif ($nb[1]==$t){$site="Y";}
	    elsif ($nb[1]==$a){$site="M";}
	    elsif ($nb[1]==$g){$site="S";}
	    else {$site="c";}
	}
	elsif ($nb[0]==$g){
	    if ($nb[1]==0){$site="G";}
	    elsif ($nb[1]==$t){$site="K";}
	    elsif ($nb[1]==$c){$site="S";}
	    elsif ($nb[1]==$a){$site="R";}
	    else {$site="g";}
	}
	else {
	    if ($nb[1]==0){$site="-";}
	    elsif ($nb[1]==$t){$site="t";}
	    elsif ($nb[1]==$c){$site="c";}
	    elsif ($nb[1]==$g){$site="g";}
	    else {$site="a";}
	}
	$consensus=$consensus.$site;
    }
   
    open OUT, ">$goal";
    print OUT ">",$input2,"_consensus\n",$consensus,"\n";
    $in = Bio::SeqIO -> new (-file => "$input", -format => 'Fasta');
    while ($seqobj = $in -> next_seq()){
	$id = $seqobj -> id; 
        $seq = $seqobj -> seq; 
	print OUT ">",$id,"\n",$seq,"\n";
    }
    system ("mv $goal aln_cons_IUPAC/");
}
