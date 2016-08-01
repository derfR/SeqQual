#!/usr/bin/env perl

# This script is part of the SeqQual pipeline which automatically process DNA sequences from chromatogram *.ab1/abd/scf files and ace assemblies while integrating quality.
# Copyright 2014 Tiange Lang and Pauline Garnier-Gere, INRA
# Last updated 22 April 2014
# SeqQual scripts are free to be distributed and/or changed under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version. These scripts are distributed in the hope that they will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details at <http://www.gnu.org/licenses/>.

if (-d "aln_cons_maxal"){die "already exist dir aln_cons_maxal\n";}
system ("mkdir aln_cons_maxal");

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
	last;
    }
    
    $consensus="";
    for ($i=0;$i<$len;$i++){
	$a=0;$t=0,$c=0;$g=0;$ins=0;$site="N";@nb=();
	$in = Bio::SeqIO -> new (-file => "$input", -format => 'Fasta');
	while ($seqobj = $in -> next_seq()){
	    $id = $seqobj -> id; 
	    $seq = $seqobj -> seq; 
	    next if $id=~/^Contig/;
	    $base=substr($seq,$i,1);
	    if (uc$base eq "A"){$a++;}
	    if (uc$base eq "T"){$t++;}
	    if (uc$base eq "C"){$c++;}
	    if (uc$base eq "G"){$g++;}
	    if ($base eq "-"){$ins++;}
	}
	@nb=($a,$t,$c,$g,$ins);
	@nb=sort{$b<=>$a}@nb;
	if ($nb[0]==0){$site="N";}
	else {
	    if ($nb[0]==$a){$site="A";}
	    elsif ($nb[0]==$t){$site="T";}
	    elsif ($nb[0]==$c){$site="C";}
	    elsif ($nb[0]==$g){$site="G";}
	    else {$site="-";}
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
    system ("mv $goal aln_cons_maxal/");
}
