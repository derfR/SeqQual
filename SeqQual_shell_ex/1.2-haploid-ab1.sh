#!/bin/sh

echo SeqQual processing for haploid *.ab1 chromatogram data.
    # Quality information from the *.phd.1 files will be added to output alignments
perl ~/SeqQual/checkdir_Output.pl
mkdir Output
cd Output
mkdir aln
cd ..

 echo ======================================================================
 echo Do alignment and create working directories/files.
 echo ======================================================================
    # "inputfile" is the txt file containing the subfolder or list of folders where the *.ab1/abd/scf
    # files are located (& eventually users' own *.phd.1 files).
    # all parameters which follow are the ones proposed for aligning and treating chromatograms, they can be changed.

    # Values following are for the Phrap software parameters, listed in same order as in the command line: 
    # default_qual
    # trim_start 
    # force_level
    # bypass_level
    # maxgap
    # repeat_stringency
    # nodeseg
    # nodespace
    # qual_show
    # max_subclone_size
    # trim_score
    # trim_penalty
    # trim_qual
    # confirm_length
    # confirm_trim
    # confirm_penalty
    # confirm_score
    # Indexwordsize

    # most are pretty robust to many cases and do not need to be changed usually, except RS (default 0.7) which can be lowered 
    # to force alignment and maxgap (default 30) which can be increased to force alignment in case of large indels. refer to SeqQual helpfile 
    # or the Phrap User documentation files for further details


perl ~/SeqQual/print_source-aln-haploid-ab1.pl inputfile 15 0 0 1 30 0.7 8 4 20 5000 20 -2 13 8 1 -5 30 10 > source-aln.txt
source source-aln.txt
     # All same values here than above need to be put before ">>", same for all print_log below
perl ~/SeqQual/print_log-aln-haploid-ab1.pl 15 0 0 1 30 0.7 8 4 20 5000 20 -2 13 8 1 -5 30 10 >> log.txt

 #Option b1, can be activated by removing the # sign in front of "echo" and the 3 command lines below
 #echo ======================================================================
 #echo Insert user phd files.
 #echo ======================================================================
     # Allows the user to use its own *.phd.1 files instead of producing them by 
     # the phred software. If some *.phd.1 files are missing, they will be produced by the pipeline and used
     # so that the analyses continue.

#perl ~/SeqQual/print_source-userphd-haploid-ab1.pl inputfile > source-userphd.txt
#source source-userphd.txt
#perl ~/SeqQual/print_log-userphd-haploid-ab1.pl >> log.txt

 # Option below needs to be activated if option b1 is used, it renames any phd.1 file
 # which does not have the correct abd/ab1/scf extension  
 #echo ======================================================================
 #echo Rename phd files.
 #echo ======================================================================
#perl ~/SeqQual/print_source-renamephd.pl inputfile > source-renamephd.txt
#source source-renamephd.txt
#perl ~/SeqQual/print_log-renamephd.pl >> log.txt


# This program is masking nucleotides from phred score lower than user-defined threshold and output fas files
 echo ======================================================================
 echo Write fasta alignment files.
 echo ======================================================================
     # the value after "inputfile" is the Phred score used by the Phred software, it can be changed

perl ~/SeqQual/print_source-write_aln-haploid.pl inputfile 30 > source-write_aln.txt
source source-write_aln.txt
perl ~/SeqQual/print_log-write_aln-haploid.pl 30 >> log.txt

# The 3 options poposed below allow minor automatic filtering/editing of fasta alignment for easier visualisation 
# and before any further editing

 echo ======================================================================
 echo Replace isolated nucleotides in alignment files.
 echo ======================================================================
     # Replacing isolated nucleotides which are surrounded by at least 5 
     # "?????" by ? also, for up to 3 isolated nucleotides, use with caution.
     # The value after "inputfile" = max number of isolated nucleotides 
     # considered (1, 2 or 3)
perl ~/SeqQual/print_source-replace.pl inputfile 3 > source-replace.txt
source source-replace.txt
perl ~/SeqQual/print_log-replace.pl 3 >> log.txt

 echo ======================================================================
 echo Truncate start and end of alignment files.
 echo ======================================================================
    # parameter value after "inputfile" means that positions in alignments 
    # at both start and end of sequences will be truncated only if a number of nucleotides used as argument (here 1) or a lower number is present  
    # (the rest being "?" either because of missing data or quality below the threshold decided by the user)

perl ~/SeqQual/print_source-truncate.pl inputfile 1 > source-truncate.txt
source source-truncate.txt
perl ~/SeqQual/print_log-truncate.pl 1 >> log.txt

 echo ======================================================================
 echo Remove low-qual positions with deletion in consensus.
 echo ======================================================================
       # This option will remove any position (column in the alignment) that includes only ? and deletion (-) 
       # with a deletion (-) in the consensus sequence
perl ~/SeqQual/print_source-remove1.pl inputfile > source-remove1.txt
source source-remove1.txt
perl ~/SeqQual/print_log-remove1.pl >> log.txt

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
