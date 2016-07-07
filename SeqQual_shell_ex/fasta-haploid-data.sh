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
perl ~/SeqQual/print_source-fasta.pl inputfile > source-fastadealing.txt
source source-fastadealing.txt
perl ~/SeqQual/print_log-fasta.pl >> log.txt

      # Although the "replace isolated nucleotides" option is normally used on the SeqQual outputs from 
      # chromatogram data, a new run of "replace isolated nucleotides" can be used on edited fasta if needed.
      # this will by default replace isolated nucleotides which are surrounded by at least 5 
      # "?????" by ? also, for up to 3 isolated nucleotides, to use with caution
 #echo ======================================================================
 #echo Replace isolated nucleotides in alignment files.
 #echo ======================================================================
      # value after "inputfile" refers to the max number of isolated nucleotides 
      # considered (1, 2 or 3)
#perl ~/SeqQual/print_source-replace.pl inputfile 3 > source-replace.txt
#source source-replace.txt
      # same value here than above needs to be put before ">>" 
#perl ~/SeqQual/print_log-replace.pl 3 >> log.txt

      # Although the "truncate" option is normally used on the SeqQual outputs from 
      # raw data, a new run of truncate can be used on edited fasta if needed.
 #echo ======================================================================
 #echo Truncate start and end of alignment files.
 #echo ======================================================================
      # parameter value after "inputfile" means that columns (bases in alignment) 
      # with so many ? at both start and end of sequences will be truncated 
#perl ~/SeqQual/print_source-truncate.pl inputfile 1 > source-truncate.txt
#source source-truncate.txt
      # same value here than above needs to be put before ">>" 
#perl ~/SeqQual/print_log-truncate.pl 1 >> log.txt

   # Although the "remove1" option is normally used on the SeqQual outputs from 
      # raw data, a new run of "remove1" can be used on edited fasta if needed.
      # WARNING: this works on alignments with a consensus sequence, which is the format given in SeqQual outputs
      # WARNING2: this option cant' be used at the same time than the "remove2" option below
 #echo ======================================================================
 #echo Remove bad columns with deletion in consensus.
 #echo ======================================================================
       # This option will remove any column corresponding to one base in the alignment that includes only ? and deletion (-) 
       # with a deletion (-) in the consensus sequence
#perl ~/SeqQual/print_source-remove1.pl inputfile > source-remove1.txt
#source source-remove1.txt
#perl ~/SeqQual/print_log-remove1.pl >> log.txt

      # Although the "remove2" option can normally be also used on the SeqQual outputs from 
      # raw data, a new run of "remove2" can be used on edited fasta if needed.
      # WARNING: this works on alignments with a consensus sequence, which is the format given in SeqQual outputs
      # WARNING2: this option cant' be used at the same time than the "remove1" option above
      # WARNING3: all that is being corrected by "remove2" includes what would be corrected using "remove1"
 #echo ======================================================================
 #echo Remove bad columns with base A, G, C or T in consensus.
 #echo ======================================================================
       # This option will remove any column corresponding to one base in the alignment that includes only ? and deletion (-) 
       # with a base (A, G, C or T) or not (-) in the consensus sequence
#perl ~/SeqQual/print_source-remove2.pl inputfile > source-remove2.txt
#source source-remove2.txt
#perl ~/SeqQual/print_log-remove2.pl >> log.txt

    #if either the truncate, remove1, remove2 or replace options are used, run also the following, 
    #ifnot, comment this one out and go to next option 
 #echo ======================================================================
 #echo Take alignment files into directory Output/aln.
 #echo ======================================================================
#perl ~/SeqQual/print_source-take_aln.pl inputfile > source-take_aln.txt
#source source-take_aln.txt

 echo ======================================================================
 echo Write SNP alignment files.
 echo ======================================================================
     # Fasta alignments will be created that contain only the polymorphic sites and their positions
perl ~/SeqQual/print_source-write_SNP-fasta_aln.pl inputfile > source-writeSNP.txt
source source-writeSNP.txt

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
 echo Create arlequin for haploid data input files only. 
 echo ======================================================================
    # the chain of character "qp qr" after "inputfile" below needs to be edited with a chain of character corresponding 
    # to your clusters for performing AMOVA in Arlequin
    # up to 20 clusters/groups can be mentionned - The program will search for this chain of character at the start of each sequence identifier
    # any sequence qhich does not start by either qp or qr or any other defined cluster won't be included in the arlequin file
perl ~/SeqQual/print_source-arlequin-haploid.pl inputfile qp qr > source-write_arlequin.txt
source source-write_arlequin.txt
 echo ======================================================================
 echo Take arlequin input files for haploid data into directory Output/arlequin .
 echo ======================================================================
perl ~/SeqQual/print_source-take_arp_haploid.pl inputfile > source-take_arp_haploid.txt
source source-take_arp_haploid.txt
   # the chain of character used above needs to be the same below - here in the example it was "qp qr"
perl ~/SeqQual/print_log-arlequin-haploid.pl qp qr >> log.txt

echo ======================================================================
echo Take log file into directory Output.
echo ======================================================================
perl ~/SeqQual/take_log_to_output.pl
