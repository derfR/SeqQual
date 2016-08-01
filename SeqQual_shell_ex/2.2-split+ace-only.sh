#!/bin/sh


echo Split/transfer *.ace only file(s) into fasta alignments.
perl ~/SeqQual/checkdir_Output.pl
mkdir Output
cd Output
mkdir aln
cd ..

     # Step below: split large ace assembly file(s) from next-generation type data of various sources, in order to increase 
     # speed of analysis, one ace file is produced for each contig
     # in all scripts below,  "inputfile" is the argument corresponding to the txt file containing the sub-folder (or list of subfolder if many) 
     # where the ace files are located. 

echo ======================================================================
echo Split ace.
echo ======================================================================
perl ~/SeqQual/print_source-largeace_split.pl inputfile > source-largeace_split.txt
source source-largeace_split.txt
perl ~/SeqQual/print_log-largeace_split.pl >> log.txt


echo ======================================================================
echo Create working directories/files.
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
perl ~/SeqQual/print_source-truncate.pl inputfile 1 > source-truncate.txt
source source-truncate.txt
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
