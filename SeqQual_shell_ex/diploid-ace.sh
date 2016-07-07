#!/bin/sh

 echo SeqQual process with diploid_ace routine.
 echo SeqQual process for *.ace files with IUPAC codes. 
    # This would be useful in the rare case where *.ace files in which IUPAC codes 
    # would occur (for example from diploid DNA from Sanger data), would be available
    # but for which the user don't have access to the chromatogram data (*.ab1 files).
    # Quality information from the original *.phd.1 files and heterozygote detection 
    # from *.poly files will be integrated in the output alignments using the information 
    # for the relative alignmnts of all the reads/sequences contained in the *.ace files.. 
    # All the *.phd.1 and *.poly files need to be in the same directory than the *.ace file(s)

perl ~/SeqQual/checkdir_Output.pl
mkdir Output
cd Output
mkdir aln
cd ..

 echo ======================================================================
 echo Create working directories/files and run polyphred.
 echo ======================================================================
perl ~/SeqQual/print_source-acedealing-diploid.pl inputfile 60 20 > source-acedealing.txt
source source-acedealing.txt
perl ~/SeqQual/print_log-acedealing-diploid.pl >> log.txt

     # option below may be used in case of *.phd.1 file
     # which does not have the correct abd/ab1/scf extension  
 #echo ======================================================================
 #echo Rename phd files.
 #echo ======================================================================
#perl ~/SeqQual/print_source-renamephd.pl inputfile > source-renamephd.txt
#source source-renamephd.txt
#perl ~/SeqQual/print_log-renamephd.pl >> log.txt

 echo ======================================================================
 echo Write fasta alignment files.
 echo ======================================================================
     # value after "inputfile" refer to the Phred score needed in the Phred software
     # and to the heterozygote score needed to assess heterozygotes from the polyphred
     # software.
perl ~/SeqQual/print_source-write_aln-diploid.pl inputfile 30 90 > source-write_aln.txt
source source-write_aln.txt
     # the same value here than above need to be put before ">>"
perl ~/SeqQual/print_log-write_aln-diploid.pl 30 90 >> log.txt

 echo ======================================================================
 echo Replace isolated nucleotides in alignment files.
 echo ======================================================================
     # this will by default replace isolated nucleotides which are surrounded by at least 5 
     # "?????" by ? also, for up to 3 isolated nucleotides, to use with caution
     # value after "inputfile" refers to the max number of isolated nucleotides 
     # considered (1, 2 or 3)
perl ~/SeqQual/print_source-replace.pl inputfile 3 > source-replace.txt
source source-replace.txt
     # the same value here than above need to be put before ">>"
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
