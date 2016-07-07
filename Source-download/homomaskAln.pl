#!/usr/bin/env perl
# This script is part of the SeqQual pipeline which automatically process chromatogram data and ace assemblies while integrating quality.
# Copyright 2014 Tiange Lang and Pauline Garnier-Gere, INRA
# Last updated 22-April-2014
# SeqQual is a free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details  at http://www.gnu.org/licenses/.


$arg=shift;

if (-d "aln_homomasked"){die "already exist dir aln_homomasked\n";}
system ("mkdir aln_homomasked");

use Bio::SeqIO;
@ids=qx{ls};
foreach $input(@ids){
    chomp $input;
    next unless $input =~ /\.aln/;
    $input2=$input;
    $input2=~s/\.aln//;
    print $input2,"\tBad insertions:\n";
    $goal="$input2".".homomasked".".aln";
 
    $in = Bio::SeqIO -> new (-file => "$input", -format => 'Fasta');
    $seqnumber=0;@seqs=();@idseqs=();
    while ($seqobj = $in -> next_seq()){
	$id = $seqobj -> id;
	$seq = $seqobj -> seq;
	$len = $seqobj -> length;
	if ($id=~/^Contig/){$consensus_id=$id;$consensus_seq=$seq;}
	else{$seqnumber++; push(@idseqs,$id); push(@seqs,$seq);}
    }   
    for ($i=0;$i<$len;$i++){
	$base_no_a=0;$base_no_t=0;$base_no_c=0;$base_no_g=0;$base_no_i=0;$base_no_real=0;@nb=();
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
	    if($base eq "-"){$base_no_i++;}
	    unless($base eq "?"){$base_no_real++;}
	}
	@nb=($base_no_a,$base_no_t,$base_no_c,$base_non_g);
	@nb=sort{$b<=>$a}@nb;
	if ($nb[0]==0){$site="-";}
	elsif ($nb[0]==$base_no_a && $nb[1]==0){$site="A";}
	elsif ($nb[0]==$base_no_t && $nb[1]==0){$site="T";}
	elsif ($nb[0]==$base_no_c && $nb[1]==0){$site="C";}
	elsif ($nb[0]==$base_no_g && $nb[1]==0){$site="G";}
	else {$site="M";}
       	for ($j=0;$j<$seqnumber;$j++){
	    $same_no=0;$same_no_f=0;$same_no_b=0;$basef1="";$basef2="";$basef3="";$basef4="";$basef5="";$baseb1="";$baseb2="";$baseb3="";$baseb4="";$baseb5="";
	    $base=substr($seqs[$j],$i,1);
	    if($base eq "-"){
		if($site eq "A" || $site eq "T" || $site eq "C" || $site eq "G"){
		    if($i>=1){
			$basef1=substr($seqs[$j],$i-1,1);
			if(uc$basef1 eq $site){
			    $same_no++; 
			    if($i>=2){
				$basef2=substr($seqs[$j],$i-2,1);
				if(uc$basef2 eq $site){
				    $same_no++; 
				    if($i>=3){
					$basef3=substr($seqs[$j],$i-3,1);
					if(uc$basef3 eq $site){
					    $same_no++; 
					    if($i>=4){
						$basef4=substr($seqs[$j],$i-4,1); 
						if(uc$basef4 eq $site){
						    $same_no++; 
						    if($i>=5){
							$basef5=substr($seqs[$j],$i-5,1);
							if(uc$basef5 eq $site){
							    $same_no++;
							}
						    }
						}
					    }
					}
				    }
				}
			    }
			}
		    }
		    $baseb1=substr($seqs[$j],$i+1,1);
		    if(uc$baseb1 eq $site){
			$same_no++; $baseb2=substr($seqs[$j],$i+2,1);
			if(uc$baseb2 eq $site){
			    $same_no++; $baseb3=substr($seqs[$j],$i+3,1);
			    if(uc$baseb3 eq $site){
				$same_no++; $baseb4=substr($seqs[$j],$i+4,1); 
				if(uc$baseb4 eq $site){
				    $same_no++; $basef5=substr($seqs[$j],$i+5,1);
				    if(uc$baseb5 eq $site){
					$same_no++; 
				    }
				}
			    }
			}
		    }
		}
		if($site eq "M"){
		    if($i>=1){
			$basef1=substr($seqs[$j],$i-1,1); 
			if(uc$basef1 eq "A" || uc$basef1 eq "T" || uc$basef1 eq "C" || uc$basef1 eq "G"){
			    $same_no_f++;
			    if($i>=2){
				$basef2=substr($seqs[$j],$i-2,1);
				if(uc$basef2 eq uc$basef1){
				    $same_no_f++; 
				    if($i>=3){
					$basef3=substr($seqs[$j],$i-3,1);
					if(uc$basef3 eq uc$basef1){
					    $same_no_f++; 
					    if($i>=4){
						$basef4=substr($seqs[$j],$i-4,1); 
						if(uc$basef4 eq uc$basef1){
						    $same_no_f++; 
						    if($i>=5){
							$basef5=substr($seqs[$j],$i-5,1);
							if(uc$basef5 eq uc$basef1){
							    $same_no_f++;
							}
						    }
						}
					    }
					}
				    }
				}
			    }
			}
		    }
		    $baseb1=substr($seqs[$j],$i+1,1);
		    if(uc$baseb1 eq "A" || uc$basef1 eq "T" || uc$basef1 eq "C" || uc$basef1 eq "G"){
			$same_no_b++; $baseb2=substr($seqs[$j],$i+2,1);
			if(uc$baseb2 eq uc$baseb1){
			    $same_no_b++; $baseb3=substr($seqs[$j],$i+3,1);
			    if(uc$baseb3 eq uc$baseb1){
				$same_no_b++; $baseb4=substr($seqs[$j],$i+4,1); 
				if(uc$baseb4 eq uc$baseb1){
				    $same_no_b++; $basef5=substr($seqs[$j],$i+5,1);
				    if(uc$baseb5 eq uc$baseb1){
					$same_no_b++; 
				    }
				}
			    }
			}
		    }
		    if(uc$basef1 eq uc$baseb1){$same_no=$same_no_f+$same_no_b;}
		    else{$same_no=$same_no_f>$same_no_b?$same_no_f:$same_no_b;}
		}
		print "Pos:",$i,"\tSeqNb:",$j,"\tNeighbourRepeatNb:",$same_no_f,"\tInsertion:",$site,"\n";
		if($same_no>=$arg){$seqs[$j]=substr($seqs[$j],0,$i)."?".substr($seqs[$j],$i+1,$len);}
	    }
	}       
    }
    open OUT, ">$goal";
    if ($consensus_id=~/^Contig/){print OUT ">",$consensus_id,"\n",$consensus_seq,"\n";}
    for ($j=0;$j<$seqnumber;$j++){
	print OUT ">",$idseqs[$j],"\n",$seqs[$j],"\n";
    }
    close OUT;
    system ("mv $goal aln_homomasked/");
}
