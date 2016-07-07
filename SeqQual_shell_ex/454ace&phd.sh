#!/bin/sh

echo SeqQual process with 454 routine.
perl ~/SeqQual/checkdir_Output.pl
mkdir Output
cd Output
mkdir aln
cd ..

     # This will allow to plit the very large file containing the quality information
     # from the 454 pyrosequencing type data, so that when connecting it to each contig, 
     # the large file does no have to be screened entirely each time

echo ======================================================================
echo Separate phd.ball.
echo ======================================================================
perl ~/SeqQual/print_source-454phd_separate.pl inputfile > source-454phd_separate.txt
source source-454phd_separate.txt
perl ~/SeqQual/print_log-454phd_separate.pl >> log.txt

     # This option can be useful in case of a very large ace assembly from 454 data which
     # would increase the length of the analysis, one ace file is produced for each contig
 #echo ======================================================================
 #echo Separate ace.
 #echo ======================================================================
#perl ~/SeqQual/print_source-454ace_separate.pl inputfile > source-454ace_separate.txt
#source source-454ace_separate.txt
#perl ~/SeqQual/print_log-454ace_separate.pl >> log.txt


     # This is needed since the ace files 
echo ======================================================================
echo Change name of 454 ace file.
echo ======================================================================
perl ~/SeqQual/print_source-454ace_changename.pl inputfile > source-454ace_changename.txt
source source-454ace_changename.txt
perl ~/SeqQual/print_log-454ace_changename.pl >> log.txt

echo ======================================================================
echo Create working directories/files.
echo ======================================================================
perl ~/SeqQual/print_source-acedealing-haploid.pl inputfile > source-acedealing.txt
source source-acedealing.txt
perl ~/SeqQual/print_log-acedealing-haploid.pl >> log.txt

echo ======================================================================
echo Write fasta alignment files.
echo ======================================================================
# value after "inputfile" refer to the Phred score equivalent for pyrosequencing type data
# From empirical comparisons, a value of 40 is recommended to get an equivalent 
# phd score of 30 if sanger data were bing analysed.
perl ~/SeqQual/print_source-write_aln-haploid.pl inputfile 30 > source-write_aln.txt
source source-write_aln.txt
# the same value here than above need to be put before ">>"
perl ~/SeqQual/print_log-write_aln-haploid.pl 30 >> log.txt

echo ======================================================================
echo Replace isolated nuclotides in alignment files.
echo ======================================================================
    # this will by default replace isolated nucleotides which are surrounded by at least 5 
    # "?????" by ? also, for up to 3 isolated nucleotides, to use with caution
    # value after "inputfile" refers to the max number of isolated nucleotides 
    # considered (1, 2 or 3)
perl ~/SeqQual/print_source-replace.pl inputfile 3 > source-replace.txt
source source-replace.txt
    # The same value here than above need to be put before ">>"
perl ~/SeqQual/print_log-replace.pl 3 >> log.txt

echo ======================================================================
echo Truncate start and end of alignment files.
echo ======================================================================
    # parameter value after "inputfile" means that columns (bases in alignment) 
    # with so many ? at both start and end of sequences will be truncated 
perl ~/SeqQual/print_source-truncate.pl inputfile 1 > source-truncate.txt
source source-truncate.txt
    # The same value here than above need to be put before ">>"
perl ~/SeqQual/print_log-truncate.pl 1 >> log.txt

      # WARNING: the option remove1 cant' be used at the same time than the "remove2" option below
 echo ======================================================================
 echo Remove bad columns with deletion in consensus.
 echo ======================================================================
       # This option will remove any column corresponding to one base in the alignment that includes only ? and deletion (-) 
       # with a deletion (-) in the consensus sequence
perl ~/SeqQual/print_source-remove1.pl inputfile > source-remove1.txt
source source-remove1.txt
perl ~/SeqQual/print_log-remove1.pl >> log.txt

      # WARNING: the option "remove2" cant' be used at the same time than the "remove1" option above
      # so comment out the option above in order to use this one 
      # WARNING2: all that is being corrected by "remove2" includes what would be corrected using "remove1"
 #echo ======================================================================
 #echo Remove bad columns with base A, G, C or T in consensus.
 #echo ======================================================================
       # This option will remove any column corresponding to one base in the alignment that includes only ? and deletion (-) 
       # with a base (A, G, C or T) or not (-) in the consensus sequence
#perl ~/SeqQual/print_source-remove2.pl inputfile > source-remove2.txt
#source source-remove2.txt
#perl ~/SeqQual/print_log-remove2.pl >> log.txt

echo ======================================================================
echo Delete empty alignment files.
echo ======================================================================
    # due to the integration of quality and truncate/removed options, some alignments may
    # be empty at the end of the pipeline, and these will be deleted
perl ~/SeqQual/print_source-delete_files.pl inputfile > source-delete_files.txt
source source-delete_files.txt

echo ======================================================================
echo Take alignment files into directory Output/aln.
echo ======================================================================
perl ~/SeqQual/print_source-take_aln.pl inputfile > source-take_aln.txt
source source-take_aln.txt

echo ======================================================================
echo Take log file into directory Output.
echo ======================================================================
perl ~/SeqQual/take_log_to_output.pl
