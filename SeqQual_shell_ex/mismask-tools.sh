#!/bin/sh
# Examples of use for various SeqQual scripts 

# Use within the folder where fasta *.aln are located
echo Merging F and R fragments - same ID
perl ~/SeqQual-additions/merge_multinput_F_R.pl

perl ~/SeqQual-additions/merge_multinput_IUPAC.pl pop1  # will merge any sequences/reads starting which names starts with "pop1"

perl ~/SeqQual-additions/merge_multinput.pl 10  # will merge any sequences/reads starting with 10 similar characters

# Picks only sequences/reads starting with pop1 and pop2 in batch in different fasta *.aln (before making consensus for example)
perl ~/SeqQual/pick-seq.pl pop1 pop2 *.aln  

## For making consensus, use command line within folder with files

# if needed, remove the first sequence if it is already a consensus sequence or the sequence of 
# a reference species, use within folder where fasta *.aln are
perl ~/SeqQual/remove_first.pl

perl ~/SeqQual/make_consensus_IUPAC_2N.pl

perl ~/SeqQual/make_consensus_maxallele_N.pl

perl ~/SeqQual/make_consensus_maxallele_2N.pl

# Gets first sequence (assumed to be te consensus) in a set of fasta *.aln, to use within the files' folder
perl ~/SeqQual/get_first.pl

## Examples below of using scripts for masking/filtering fasta alignments in batch
##======================================================================================
## Step of masking singletons and expected false-positives with "?" by using maskAln.pl
##======================================================================================

# usage example: perl maskAln.pl --man=1 --man_if_depth=10 --maf=0.05 --indel_only=no
# this means that:
# all singletons wil be masked with "?" if there is at least 10 sequences,
# that nucleotides below or equal to 5% will be masked as well, and this is true for all types of SNPs (including indels or not)
# default man=1
# default man-if-depth=15
# default maf=0.05
# defaul indel-only=no (if yes, means that only indels are treated)

# first go to subfolder in which either original *.aln or last modified *.aln are located then run maskAln
cd Output/alnmod1/
perl ~/SeqQual/maskAln.pl --man=1 --man_if_depth=10 --maf=0.05 #--indel_only=yes
mv aln_mask/*.clean.aln ../../Output/alnmod2/    # fas files with extension ".clean.aln" are moved to another subfolder /alnmod2
 #rm *.aln # delete all *.aln filed that remain
cd ../..

 echo ======================================================================
 echo removes positions/columns with only "?" and deletions with remove-false-pos_aln.pl
 echo ======================================================================
 # usage remove-false-pos_aln.pl arg
 # with 0 for arg as below: it will remove any columns/positions corresponding to one base in the alignment that includes only ? and deletion (-)
 # with 1 for arg, it will do the same and also remove positions where singletons insertions are present, with arg=2 where 2 inserted nucleotides are present etc...

cd Output/alnmod2/
perl ~/SeqQual/remove-false-pos_aln.pl 0 # creates a new folder aln_remove where modified fasta *.aln are moved








