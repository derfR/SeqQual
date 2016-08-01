#!/bin/sh
# Examples of command lines for diploid sequence data (change "pop1 pop2" according to your reads/sequences ID)
# put "pop1" for example for only one group to be considered.
# if no argument is given, all sequences will be used in computations 
# see SeqQual-fastools.pdf for further explanations

# example of commands for code adapted to diploid data --> activate command lines by removing #

#echo SNP_statistic computing.
#perl ~/SeqQual/print_source-SNP_statistic.pl inputfile pop1 pop2 > source-SNP_statistic.txt
#source source-SNP_statistic.txt

# example commands for haploid data

echo SNP_statistic routine.
perl ~/SeqQual/print_source-SNP_statistic_haplo.pl inputfile pop1 pop2 > source-SNP_statistic.txt
source source-SNP_statistic.txt
