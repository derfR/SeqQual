#!/bin/sh

echo SeqQual process for ace and quality files.
perl ~/SeqQual/checkdir_Output.pl         # from SeqQual-part1-scripts
mkdir Output
cd Output
mkdir aln
cd ..

     # Split one or more large phd ball file(s) containing quality information
     # from next-generation type data of various sources, so that when connecting it to each contig in the ace, 
     # the large file does no have to be screened entirely each time, increase speed of analysis

echo ======================================================================
echo Split phd.ball.1
echo ======================================================================
perl ~/SeqQual/print_source-largephd_split.pl inputfile > source-largephd_split.txt
source source-largephd_split.txt
perl ~/SeqQual/print_log-largephd_split.pl >> log.txt

     # Split large ace assembly file(s) from next-generation type data of various sources, in order to increase 
     # speed of analysis, one ace file is produced for each contig
 #echo ======================================================================
 #echo Split ace.
 #echo ======================================================================
#perl ~/SeqQual/print_source-largeace_split.pl inputfile > source-largeace_split.txt
#source source-largeace_split.txt
#perl ~/SeqQual/print_log-largeace_split.pl >> log.txt


     # This step below is needed if some ace files have the extension *.ace.1, changes it to *.ace
     # if the files have the correct extension, the step is skipped
echo ======================================================================
echo Change extensions of ace files.
echo ======================================================================
perl ~/SeqQual/print_source-ace_changename.pl inputfile > source-ace_changename.txt
source source-ace_changename.txt
perl ~/SeqQual/print_log-ace_changename.pl >> log.txt

echo ======================================================================
echo Create working directories/files.
echo ======================================================================
perl ~/SeqQual/print_source-acedealing-qual.pl inputfile > source-acedealing.txt
source source-acedealing.txt
perl ~/SeqQual/print_log-acedealing-qual.pl >> log.txt

echo ======================================================================
echo Write fasta alignment files #--> analogous to using print_source-write_aln-onlyqual.pl from SeqQual-part1-scripts
echo ======================================================================
# value after "inputfile" refer to the Phred score equivalent for pyrosequencing type data
# From empirical comparisons, a value of 20 can be used for quality values from NGS reads but this can be 
# adapted to your type of data and quality parameter 
 
perl ~/SeqQual/print_source-write_aln-qual.pl inputfile 20 > source-write_aln.txt
source source-write_aln.txt
# the same value here than above need to be put before ">>"
perl ~/SeqQual/print_log-write_aln-qual.pl 20 >> log.txt

echo ======================================================================
echo Take alignment files into directory Output/aln.
echo ======================================================================
perl ~/SeqQual/print_source-take_aln.pl inputfile > source-take_aln.txt
source source-take_aln.txt

echo ======================================================================
echo Take log file into directory Output.
echo ======================================================================
perl ~/SeqQual/take_log_to_output.pl
