#!/bin/sh

echo Split/transfer *.ace only files into fasta alignments.
perl ~/SeqQual/checkdir_Output.pl
mkdir Output
cd Output
mkdir aln
cd ..
     # in all scripts below,  "inputfile" is the argument corresponding to the txt file containing the sub-folder (or list of subfolder if many) 
     # where the ace file(s) are located. 

echo ======================================================================
echo Create/check working directories/files .
echo ======================================================================
perl ~/SeqQual/print_source-aceonly.pl inputfile > source-acedealing.txt
source source-acedealing.txt
perl ~/SeqQual/print_log-aceonly.pl >> log.txt

echo ======================================================================
echo Write fasta alignment files.
echo ======================================================================
perl ~/SeqQual/print_source-write_aln-aceonly.pl inputfile > source-write_aln.txt
source source-write_aln.txt

# step below is needed if for example, you want to extract alignments/contigs 
# which start at a certain depth, here the 1 value ensures all data are exported
echo ======================================================================
echo Truncate start and end of alignment files. 
echo ======================================================================
    # parameter value after "inputfile" means that columns (bases in alignment) 
    # with so many ? at both start and end of sequences will be truncated 
perl ~/SeqQual/print_source-truncate.pl inputfile 1 > source-truncate.txt
source source-truncate.txt
    # The same value here than above need to be put before ">>"
perl ~/SeqQual/print_log-truncate.pl 1 >> log.txt

echo ======================================================================
echo Take alignment files into directory Output/aln.
echo ======================================================================
perl ~/SeqQual/print_source-take_aln.pl inputfile > source-take_aln.txt
source source-take_aln.txt

echo ======================================================================
echo Take log file into directory Output.
echo ======================================================================
perl ~/SeqQual/take_log_to_output.pl
