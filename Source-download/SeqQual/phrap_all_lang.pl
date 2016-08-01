#!/usr/bin/env perl

# This script is part of the SeqQual pipeline which automatically process DNA sequences from chromatogram *.ab1/abd/scf files and ace assemblies while integrating quality.
# Copyright 2010 Tiange Lang and Pauline Garnier-Gere, INRA
# Last updated April 2010
# SeqQual scripts are free to be distributed and/or changed under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version. These scripts are distributed in the hope that they will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details at <http://www.gnu.org/licenses/>.

$input=shift;
$default_qual=shift;		#1
$trim_start=shift;		#2
$force_level=shift;		#3
$bypass_level=shift;		#4
$maxgap=shift;			#5
$repeat_stringency=shift;	#6
$nodeseg=shift;			#7
$nodespace=shift;		#8
$qual_show=shift;		#9
$max_subclone_size=shift;	#10
$trim_score=shift;		#11
$trim_penalty=shift;		#12
$trim_qual=shift;		#13
$confirm_length=shift;		#14
$confirm_trim=shift;		#15
$confirm_penalty=shift;		#16
$confirm_score=shift;		#17
$indexwordsize=shift;		#18

open IN,"<$input";
while (<IN>){
    chomp;
    system ("phrap $_ -ace -maxgap $maxgap -repeat_stringency $repeat_stringency -node_space $nodespace -node_seg $nodeseg -tags -default_qual $default_qual -qual_show $qual_show -retain_duplicates -max_subclone_size $max_subclone_size -trim_penalty $trim_penalty -trim_score $trim_score -trim_qual $trim_qual -confirm_length $confirm_length -confirm_trim $confirm_trim -confirm_penalty $confirm_penalty -confirm_score $confirm_score -indexwordsize $indexwordsize -trim_start $trim_start -forcelevel $force_level -bypasslevel $bypass_level");
}

`rm -f *.contigs*`; `rm -f *.log`; `rm -f *.problems*`; `rm -f *.singlets`; 


