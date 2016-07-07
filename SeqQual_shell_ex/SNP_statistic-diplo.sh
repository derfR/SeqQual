#!/bin/sh
# The scripts called here are part of the SeqQual pipeline post-processing programs which automatically process chromatogram data and ace assemblies while integrating quality.
# Copyright 2010 Tiange Lang and Pauline Garnier-Gere, INRA
# Last updated 12-05-2010
# SeqQual post-processing programs are free programs: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program. If not, see <http://www.gnu.org/licenses/>.

# SNP-statistics: Program that computes in batch basic SNP statistics, allelic frequencies and differentiation (Gst, Gst') , HW Chi2 test.
# usage: put all *.pl in folder SNP_statistic under your home folder
# organise all *.aln (alignment fasta files) in one or more folders
# above that/those folder(s): create a text file named "inputfile" which contains the folder(s) name(s) 
# then launch the program by typing "source SNP_statistic.sh" (same logic than for SeqQual)

# The line below can be modified according to your input file:
# you can put either zero (nothing), one or 2 character chains corresponding
# to prefix identifying populations or groups of sequences in your files. In the example below "qp qr" means 
# that all sequences starting with "qp" and "qr" will be considered in the analysis and also that 
# the differentiation parameters will be computed (as well as statistics in each group)
# if nothing is written, all sequences will be considered, and no differentiation is computed
# if only one character chain is put, only those sequences will be considered, no differentiation computed


echo SNP_statistic routine.
perl ~/SNP_statistic/print_source-SNP_statistic.pl inputfile qp qr > source-SNP_statistic.txt
source source-SNP_statistic.txt

