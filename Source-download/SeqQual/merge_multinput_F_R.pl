#!/usr/bin/env perl

# This script is part of the SeqQual pipeline which automatically process DNA sequences from chromatogram *.ab1/abd/scf files and ace assemblies while integrating quality.
# Copyright 2016 Tiange Lang and Pauline Garnier-Gere, INRA
# Last updated July 2016
# SeqQual scripts are free to be distributed and/or changed under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version. These scripts are distributed in the hope that they will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details at <http://www.gnu.org/licenses/>.

if (-d "aln_merged"){die "already exist dir aln_merged\n";}
if (-d "log_merged"){die "already exist dir log_merged\n";}

system ("mkdir aln_merged");
system ("mkdir log_merged");

use Bio::SeqIO;
@files=qx{ls};
foreach $input(@files){
    chomp $input;
    next unless $input=~ /\.aln/;
    $input2=$input;
    $input2=~s/\.aln//g;
    print $input2,"\n";
    $goal1="$input2".".merged.aln";
    $goal2="$input2".".merged.log";

    open OUT, ">$goal1";
    open OUT2, ">$goal2";
    $in = Bio::SeqIO -> new (-file => "$input", -format => 'Fasta');
    @ids=();@seqs=(); $case=0;
    while ($seqobj = $in -> next_seq()){
	$id = $seqobj -> id; 
	$seq = $seqobj -> seq; 
	push (@ids,$id);push (@seqs,$seq);
    }
    $no_of_seqs=scalar@ids;
    $no_of_merge=0;
    for ($i=0;$i<scalar@ids;$i++){
	$merge=0;
	$seqfinal=$seqs[$i];
	$idcompare1=$ids[$i];
	$idcompare1=~s/-P30//;
	$idcompare1=~s/_\d+-F//;
	$idcompare1=~s/_\d+-R//;
	next if $ids[$i] eq "null";
	for ($j=$i+1;$j<scalar@ids;$j++){
	    $idcompare2=$ids[$j];
	    $idcompare2=~s/-P30//;
	    $idcompare2=~s/_\d+-F//;
	    $idcompare2=~s/_\d+-R//;
	    next unless $idcompare1 eq $idcompare2;
	    $no_of_merge++;
	    $idback=$ids[$j];
	    $ids[$j]="null";
	    $merge++;
	    $discrepancy=0;
	    print OUT2 $input2,"\t",$ids[$i]," and ",$idback,"\t";
	    @seqfinal0=();
	    @seqfinal1=split(//,$seqfinal);
	    @seqfinal2=split(//,$seqs[$j]);
	    $len=scalar@seqfinal1>scalar@seqfinal2?scalar@seqfinal1:scalar@seqfinal2;
	    for ($k=0;$k<$len;$k++){
		if (uc$seqfinal1[$k] eq "A" && uc$seqfinal2[$k] eq "A"){push (@seqfinal0, "a");}
		elsif (uc$seqfinal1[$k] eq "T" && uc$seqfinal2[$k] eq "T"){push (@seqfinal0, "t");}
		elsif (uc$seqfinal1[$k] eq "C" && uc$seqfinal2[$k] eq "C"){push (@seqfinal0, "c");}
		elsif (uc$seqfinal1[$k] eq "G" && uc$seqfinal2[$k] eq "G"){push (@seqfinal0, "g");}
		elsif (uc$seqfinal1[$k] eq "R" && uc$seqfinal2[$k] eq "R"){push (@seqfinal0, "R");}
		elsif (uc$seqfinal1[$k] eq "W" && uc$seqfinal2[$k] eq "W"){push (@seqfinal0, "W");}
		elsif (uc$seqfinal1[$k] eq "M" && uc$seqfinal2[$k] eq "M"){push (@seqfinal0, "M");}
		elsif (uc$seqfinal1[$k] eq "K" && uc$seqfinal2[$k] eq "K"){push (@seqfinal0, "K");}
		elsif (uc$seqfinal1[$k] eq "Y" && uc$seqfinal2[$k] eq "Y"){push (@seqfinal0, "Y");}
		elsif (uc$seqfinal1[$k] eq "S" && uc$seqfinal2[$k] eq "S"){push (@seqfinal0, "S");}

		elsif (uc$seqfinal1[$k] eq "A" && $seqfinal2[$k] eq "?"){push (@seqfinal0, "a");}
		elsif (uc$seqfinal1[$k] eq "?" && uc$seqfinal2[$k] eq "A"){push (@seqfinal0, "a");}
		elsif (uc$seqfinal1[$k] eq "T" && $seqfinal2[$k] eq "?"){push (@seqfinal0, "t");}
		elsif (uc$seqfinal1[$k] eq "?" && uc$seqfinal2[$k] eq "T"){push (@seqfinal0, "t");}
		elsif (uc$seqfinal1[$k] eq "C" && $seqfinal2[$k] eq "?"){push (@seqfinal0, "c");}
		elsif (uc$seqfinal1[$k] eq "?" && uc$seqfinal2[$k] eq "C"){push (@seqfinal0, "c");}
		elsif (uc$seqfinal1[$k] eq "G" && $seqfinal2[$k] eq "?"){push (@seqfinal0, "g");}
		elsif (uc$seqfinal1[$k] eq "?" && uc$seqfinal2[$k] eq "G"){push (@seqfinal0, "g");}
		elsif (uc$seqfinal1[$k] eq "R" && $seqfinal2[$k] eq "?"){push (@seqfinal0, "R");}
		elsif (uc$seqfinal1[$k] eq "?" && uc$seqfinal2[$k] eq "R"){push (@seqfinal0, "R");}
		elsif (uc$seqfinal1[$k] eq "W" && $seqfinal2[$k] eq "?"){push (@seqfinal0, "W");}
		elsif (uc$seqfinal1[$k] eq "?" && uc$seqfinal2[$k] eq "W"){push (@seqfinal0, "W");}
		elsif (uc$seqfinal1[$k] eq "M" && $seqfinal2[$k] eq "?"){push (@seqfinal0, "M");}
		elsif (uc$seqfinal1[$k] eq "?" && uc$seqfinal2[$k] eq "M"){push (@seqfinal0, "M");}
		elsif (uc$seqfinal1[$k] eq "K" && $seqfinal2[$k] eq "?"){push (@seqfinal0, "K");}
		elsif (uc$seqfinal1[$k] eq "?" && uc$seqfinal2[$k] eq "K"){push (@seqfinal0, "K");}
		elsif (uc$seqfinal1[$k] eq "Y" && $seqfinal2[$k] eq "?"){push (@seqfinal0, "Y");}
		elsif (uc$seqfinal1[$k] eq "?" && uc$seqfinal2[$k] eq "Y"){push (@seqfinal0, "Y");}
		elsif (uc$seqfinal1[$k] eq "S" && $seqfinal2[$k] eq "?"){push (@seqfinal0, "S");}
		elsif (uc$seqfinal1[$k] eq "?" && uc$seqfinal2[$k] eq "S"){push (@seqfinal0, "S");}

		elsif (uc$seqfinal1[$k] eq "A" && $seqfinal2[$k] eq "-"){push (@seqfinal0, "N");}
		elsif (uc$seqfinal1[$k] eq "-" && uc$seqfinal2[$k] eq "A"){push (@seqfinal0, "N");}
		elsif (uc$seqfinal1[$k] eq "T" && $seqfinal2[$k] eq "-"){push (@seqfinal0, "N");}
		elsif (uc$seqfinal1[$k] eq "-" && uc$seqfinal2[$k] eq "T"){push (@seqfinal0, "N");}
		elsif (uc$seqfinal1[$k] eq "C" && $seqfinal2[$k] eq "-"){push (@seqfinal0, "N");}
		elsif (uc$seqfinal1[$k] eq "-" && uc$seqfinal2[$k] eq "C"){push (@seqfinal0, "N");}
		elsif (uc$seqfinal1[$k] eq "G" && $seqfinal2[$k] eq "-"){push (@seqfinal0, "N");}
		elsif (uc$seqfinal1[$k] eq "-" && uc$seqfinal2[$k] eq "G"){push (@seqfinal0, "N");}
		elsif (uc$seqfinal1[$k] eq "R" && $seqfinal2[$k] eq "-"){push (@seqfinal0, "N");}
		elsif (uc$seqfinal1[$k] eq "-" && uc$seqfinal2[$k] eq "R"){push (@seqfinal0, "N");}
		elsif (uc$seqfinal1[$k] eq "W" && $seqfinal2[$k] eq "-"){push (@seqfinal0, "N");}
		elsif (uc$seqfinal1[$k] eq "-" && uc$seqfinal2[$k] eq "W"){push (@seqfinal0, "N");}
		elsif (uc$seqfinal1[$k] eq "M" && $seqfinal2[$k] eq "-"){push (@seqfinal0, "N");}
		elsif (uc$seqfinal1[$k] eq "-" && uc$seqfinal2[$k] eq "M"){push (@seqfinal0, "N");}
		elsif (uc$seqfinal1[$k] eq "K" && $seqfinal2[$k] eq "-"){push (@seqfinal0, "N");}
		elsif (uc$seqfinal1[$k] eq "-" && uc$seqfinal2[$k] eq "K"){push (@seqfinal0, "N");}
		elsif (uc$seqfinal1[$k] eq "Y" && $seqfinal2[$k] eq "-"){push (@seqfinal0, "N");}
		elsif (uc$seqfinal1[$k] eq "-" && uc$seqfinal2[$k] eq "Y"){push (@seqfinal0, "N");}
		elsif (uc$seqfinal1[$k] eq "S" && $seqfinal2[$k] eq "-"){push (@seqfinal0, "N");}
		elsif (uc$seqfinal1[$k] eq "-" && uc$seqfinal2[$k] eq "S"){push (@seqfinal0, "N");}

		elsif (uc$seqfinal1[$k] eq "A" && $seqfinal2[$k] eq "~"){push (@seqfinal0, "N");}
		elsif (uc$seqfinal1[$k] eq "~" && uc$seqfinal2[$k] eq "A"){push (@seqfinal0, "N");}
		elsif (uc$seqfinal1[$k] eq "T" && $seqfinal2[$k] eq "~"){push (@seqfinal0, "N");}
		elsif (uc$seqfinal1[$k] eq "~" && uc$seqfinal2[$k] eq "T"){push (@seqfinal0, "N");}
		elsif (uc$seqfinal1[$k] eq "C" && $seqfinal2[$k] eq "~"){push (@seqfinal0, "N");}
		elsif (uc$seqfinal1[$k] eq "~" && uc$seqfinal2[$k] eq "C"){push (@seqfinal0, "N");}
		elsif (uc$seqfinal1[$k] eq "G" && $seqfinal2[$k] eq "~"){push (@seqfinal0, "N");}
		elsif (uc$seqfinal1[$k] eq "~" && uc$seqfinal2[$k] eq "G"){push (@seqfinal0, "N");}
		elsif (uc$seqfinal1[$k] eq "R" && $seqfinal2[$k] eq "~"){push (@seqfinal0, "N");}
		elsif (uc$seqfinal1[$k] eq "~" && uc$seqfinal2[$k] eq "R"){push (@seqfinal0, "N");}
		elsif (uc$seqfinal1[$k] eq "W" && $seqfinal2[$k] eq "~"){push (@seqfinal0, "N");}
		elsif (uc$seqfinal1[$k] eq "~" && uc$seqfinal2[$k] eq "W"){push (@seqfinal0, "N");}
		elsif (uc$seqfinal1[$k] eq "M" && $seqfinal2[$k] eq "~"){push (@seqfinal0, "N");}
		elsif (uc$seqfinal1[$k] eq "~" && uc$seqfinal2[$k] eq "M"){push (@seqfinal0, "N");}
		elsif (uc$seqfinal1[$k] eq "K" && $seqfinal2[$k] eq "~"){push (@seqfinal0, "N");}
		elsif (uc$seqfinal1[$k] eq "~" && uc$seqfinal2[$k] eq "K"){push (@seqfinal0, "N");}
		elsif (uc$seqfinal1[$k] eq "Y" && $seqfinal2[$k] eq "~"){push (@seqfinal0, "N");}
		elsif (uc$seqfinal1[$k] eq "~" && uc$seqfinal2[$k] eq "Y"){push (@seqfinal0, "N");}
		elsif (uc$seqfinal1[$k] eq "S" && $seqfinal2[$k] eq "~"){push (@seqfinal0, "N");}
		elsif (uc$seqfinal1[$k] eq "~" && uc$seqfinal2[$k] eq "S"){push (@seqfinal0, "N");}

		elsif (uc$seqfinal1[$k] eq "A" && $seqfinal2[$k] eq ""){push (@seqfinal0, "a");}
		elsif (uc$seqfinal1[$k] eq "" && uc$seqfinal2[$k] eq "A"){push (@seqfinal0, "a");}
		elsif (uc$seqfinal1[$k] eq "T" && $seqfinal2[$k] eq ""){push (@seqfinal0, "t");}
		elsif (uc$seqfinal1[$k] eq "" && uc$seqfinal2[$k] eq "T"){push (@seqfinal0, "t");}
		elsif (uc$seqfinal1[$k] eq "C" && $seqfinal2[$k] eq ""){push (@seqfinal0, "c");}
		elsif (uc$seqfinal1[$k] eq "" && uc$seqfinal2[$k] eq "C"){push (@seqfinal0, "c");}
		elsif (uc$seqfinal1[$k] eq "G" && $seqfinal2[$k] eq ""){push (@seqfinal0, "g");}
		elsif (uc$seqfinal1[$k] eq "" && uc$seqfinal2[$k] eq "G"){push (@seqfinal0, "g");}
		elsif (uc$seqfinal1[$k] eq "R" && $seqfinal2[$k] eq ""){push (@seqfinal0, "R");}
		elsif (uc$seqfinal1[$k] eq "" && uc$seqfinal2[$k] eq "R"){push (@seqfinal0, "R");}
		elsif (uc$seqfinal1[$k] eq "W" && $seqfinal2[$k] eq ""){push (@seqfinal0, "W");}
		elsif (uc$seqfinal1[$k] eq "" && uc$seqfinal2[$k] eq "W"){push (@seqfinal0, "W");}
		elsif (uc$seqfinal1[$k] eq "M" && $seqfinal2[$k] eq ""){push (@seqfinal0, "M");}
		elsif (uc$seqfinal1[$k] eq "" && uc$seqfinal2[$k] eq "M"){push (@seqfinal0, "M");}
		elsif (uc$seqfinal1[$k] eq "K" && $seqfinal2[$k] eq ""){push (@seqfinal0, "K");}
		elsif (uc$seqfinal1[$k] eq "" && uc$seqfinal2[$k] eq "K"){push (@seqfinal0, "K");}
		elsif (uc$seqfinal1[$k] eq "Y" && $seqfinal2[$k] eq ""){push (@seqfinal0, "Y");}
		elsif (uc$seqfinal1[$k] eq "" && uc$seqfinal2[$k] eq "Y"){push (@seqfinal0, "Y");}
		elsif (uc$seqfinal1[$k] eq "S" && $seqfinal2[$k] eq ""){push (@seqfinal0, "S");}
		elsif (uc$seqfinal1[$k] eq "" && uc$seqfinal2[$k] eq "S"){push (@seqfinal0, "S");}

		elsif ($seqfinal1[$k] eq "-" && $seqfinal2[$k] eq "-"){push (@seqfinal0, "-");}
		elsif ($seqfinal1[$k] eq "-" && $seqfinal2[$k] eq "?"){push (@seqfinal0, "-");}
		elsif ($seqfinal1[$k] eq "?" && $seqfinal2[$k] eq "-"){push (@seqfinal0, "-");}
		elsif ($seqfinal1[$k] eq "-" && $seqfinal2[$k] eq ""){push (@seqfinal0, "-");}
		elsif ($seqfinal1[$k] eq "" && $seqfinal2[$k] eq "-"){push (@seqfinal0, "-");}
		elsif ($seqfinal1[$k] eq "-" && $seqfinal2[$k] eq "~"){push (@seqfinal0, "-");}
		elsif ($seqfinal1[$k] eq "~" && $seqfinal2[$k] eq "-"){push (@seqfinal0, "-");}
		elsif ($seqfinal1[$k] eq "~" && $seqfinal2[$k] eq "~"){push (@seqfinal0, "-");}
		elsif ($seqfinal1[$k] eq "~" && $seqfinal2[$k] eq "?"){push (@seqfinal0, "-");}
                elsif ($seqfinal1[$k] eq "?" && $seqfinal2[$k] eq "~"){push (@seqfinal0, "-");}
		elsif ($seqfinal1[$k] eq "~" && $seqfinal2[$k] eq ""){push (@seqfinal0, "-");}
		elsif ($seqfinal1[$k] eq "" && $seqfinal2[$k] eq "~"){push (@seqfinal0, "-");}
		elsif ($seqfinal1[$k] eq "?" && $seqfinal2[$k] eq "?"){push (@seqfinal0, "?");}
		elsif ($seqfinal1[$k] eq "?" && $seqfinal2[$k] eq ""){push (@seqfinal0, "?");}
		elsif ($seqfinal1[$k] eq "" && $seqfinal2[$k] eq "?"){push (@seqfinal0, "?");}
	   	else {
		    push (@seqfinal0, "N");
		    $discrepancy++;
		    print OUT2 "Position:",$k+1,"-Nucleotides:",$seqfinal1[$k],$seqfinal2[$k],"|";
		}
	    }
	    $seqfinal0=join(/""/,@seqfinal0);
	    $seqfinal=$seqfinal0;
    	    print OUT2 "Cases:",$discrepancy,"\n";
	    $case=$case+$discrepancy;
	}
	if ($merge==0){print OUT ">",$ids[$i],"\n"; print OUT2 $input2,"\tSingle: ",$ids[$i],"\n";}
	else {print OUT ">",$idcompare1,"-M",$merge+1,"\n";}
	print OUT $seqfinal,"\n";
    }
    print OUT2 "==========\n",$input2,"\tStatistics: No of seqs:",$no_of_seqs,"\tNo of merge:",$no_of_merge,"\tNo of discrepancy cases:",$case,"\tSequence length:",$len,"\n";
    system ("mv $goal1 aln_merged");
    system ("mv $goal2 log_merged");
}
