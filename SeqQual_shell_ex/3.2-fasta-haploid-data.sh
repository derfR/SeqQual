#!/bin/sh

echo Processing fasta alignments from validated haploid data.
perl ~/SeqQual/checkdir_Output.pl
mkdir Output
cd Output
#mkdir aln           # needed if either truncate, remove or replace options are being used again
mkdir SNP            # needed if SNP alignment wanted
mkdir arlequin       # needed if arlequin input files wanted - see below   
cd ..

echo ======================================================================
echo Create working directories/files.
echo ======================================================================
     # "inputfile" is the argument corresponding to the txt file containing the sub-folder (or list of subfolder if many) where the fasta alignments
     # are located. Output fasta alignments will have the same names with a suffix corresponding to each treatment below
     # the same "inputfile" argument below corresponds to the same list of sub-folders
perl ~/SeqQual/print_source-fasta.pl inputfile > source-fastadealing.txt
source source-fastadealing.txt
perl ~/SeqQual/print_log-fasta.pl >> log.txt

      # Activate the command lines below if a new run of replacing isolated nucleotides is needed.
      # option that replaces isolated nucleotides which are surrounded by at least 5 
      # "?????" by ? also, for up to 3 isolated nucleotides, to use with caution
 #echo ======================================================================
 #echo Replace isolated nucleotides in alignment files.
 #echo ======================================================================
      # value after "inputfile" = max number of isolated nucleotides considered (1, 2 or 3)
#perl ~/SeqQual/print_source-replace.pl inputfile 3 > source-replace.txt
#source source-replace.txt
      # same value here than above needs to be put before ">>" 
#perl ~/SeqQual/print_log-replace.pl 3 >> log.txt

      # Activate the command lines below if a new run of truncate is needed on edited fasta.
 #echo ======================================================================
 #echo Truncate start and end of alignment files.
 #echo ======================================================================
    # number after "inputfile" means that positions in alignments at both start and end of sequences will be truncated 
    # only if this or a lower number of nucleotides (here 1) is present,  
    # (the rest of bases being "?" either because of missing data or quality below a user-defined threshold)
#perl ~/SeqQual/print_source-truncate.pl inputfile 1 > source-truncate.txt
#source source-truncate.txt
#perl ~/SeqQual/print_log-truncate.pl 1 >> log.txt

      # activate lines below if a new run of "remove1" is needed on fasta files.
      # WARNING: this works on alignments with a consensus sequence, which is the format given in SeqQual outputs
      # other wise, use get_consensus....pl scripts  
 #echo ======================================================================
 #echo Remove low-qual positions with deletion in consensus.
 #echo ======================================================================
       # This option will remove any position (=column in the alignment) that includes only ? and deletion (-) 
       # with a deletion (-) in the consensus sequence
#perl ~/SeqQual/print_source-remove1.pl inputfile > source-remove1.txt
#source source-remove1.txt
#perl ~/SeqQual/print_log-remove1.pl >> log.txt

    #if either the replace, truncate, or remove1 options are used, run also the following, 
 #echo ======================================================================
 #echo Take alignment files into directory Output/aln.
 #echo ======================================================================
#perl ~/SeqQual/print_source-take_aln.pl inputfile > source-take_aln.txt
#source source-take_aln.txt

 echo ======================================================================
 echo Write SNP alignment files.
 echo ======================================================================
     # Fasta alignments will be created in a new folder that contain only the polymorphic sites and their positions
perl ~/SeqQual/print_source-write_SNP-fasta_aln.pl inputfile > source-writeSNP.txt
source source-writeSNP.txt

 # activate instead of above if fasta alignments do no include consensus first sequence
 #echo ======================================================================
 #echo Write SNP alignment files without consensus.
 #echo ======================================================================
#perl ~/SeqQual/print_source-write_SNP-fasta_aln-no_first.pl inputfile > source-writeSNP.txt
#source source-writeSNP.txt

 echo ======================================================================
 echo Take SNP alignment files into directory Output/SNP.
 echo ======================================================================
perl ~/SeqQual/print_source-take_SNP-fasta2snp.pl inputfile > source-take_SNP.txt
source source-take_SNP.txt
perl ~/SeqQual/print_log-write_SNP-fasta_aln.pl >> log.txt

 echo ======================================================================
 echo Create arlequin for haploid data fasta files. 
 echo ======================================================================
    # commands for producing input files for the Arlequin software in batch across fasta alignments
    # after "inputfile" below, characters identifying start of sequences/reads and corresponding to different groups  
    # can be edited for the User own groups - allows to perform for example an AMOVA in Arlequin  
    # up to 20 clusters/groups can be mentionned - The program will search for this chain of character at the start of each sequence identifier
    # if no character are given, the arlequin input fille will be created with all the sequences in one group
perl ~/SeqQual/print_source-arlequin-haploid.pl inputfile pop1 pop2 > source-write_arlequin.txt
source source-write_arlequin.txt

 echo ======================================================================
 echo Take arlequin input files for haploid data into directory Output/arlequin .
 echo ======================================================================
perl ~/SeqQual/print_source-take_arp_haploid.pl inputfile > source-take_arp_haploid.txt
source source-take_arp_haploid.txt
    # the chain of character below needs to be the same than before (here in the example it is "pop1 pop2")
perl ~/SeqQual/print_log-arlequin-haploid.pl pop1 pop2 >> log.txt

echo ======================================================================
echo Take log file into directory Output.
echo ======================================================================
perl ~/SeqQual/take_log_to_output.pl
