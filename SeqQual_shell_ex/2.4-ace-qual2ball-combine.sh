
#!/bin/sh

# SeqQual process for ace and quality files in the case of a non-standard format for the ace file, i.e. one ace
# from the MIRA software for example, with poorly aligned nucleotides that will be masked as N and few edited reads from the original sequences
# These commands were used in ElMujtar et al. 2014 (see SeqQual main website page)

perl ~/SeqQual/checkdir_Output.pl         # from SeqQual-part1-scripts
mkdir Output
cd Output
mkdir aln
cd ..

# In this example, below the working folder, in a folder called /acequal, you have:
# The original assembly ace file was called Notho_clip4_out.ace (from next-generation type data of various sources)
# The original fasta and qual files were called Notho_clip4.fasta and Notho_clip4.fasta.qual 
# in the working folder, create the text file inputfile that contains acequal 

## A) first produce a new ace file including masked nucleotides for bad alignment quality regions

perl ~/SeqQual/changeMIRAace1.pl acequal/Notho_clip4_out.ace > acequal/Notho_clip4_out-intermediate.ace
perl ~/SeqQual/changeMIRAace2.pl acequal/Notho_clip4_out-intermediate.ace > acequal/Notho_clip4_out-new.ace

     # keeping only the new ace:
rm acequal/Notho_clip4_out.ace
rm acequal/Notho_clip4_out-intermediate.ace  

     # Split the new ace assembly file(s)  in order to increase 
     # speed of analysis, one ace file is produced for each contig
 #echo ======================================================================
 #echo Split ace.
 #echo ======================================================================
#perl ~/SeqQual/print_source-largeace_split.pl inputfile > source-largeace_split.txt
#source source-largeace_split.txt
#perl ~/SeqQual/print_log-largeace_split.pl >> log.txt


## B) Second produce the fasta alignments from the new ace file (no filter for quality)

echo ======================================================================
echo Create working directories/files.
echo ======================================================================
perl ~/SeqQual/print_source-aceonly.pl inputfile > source-acedealing.txt
source source-acedealing.txt
perl ~/SeqQual/print_log-aceonly.pl >> log.txt

echo ======================================================================
echo Write fasta alignment files.  # will call the write_acealn-nonqual_multinput.pl script
echo ======================================================================
perl ~/SeqQual/print_source-write_aln-aceonly.pl inputfile > source-write_aln.txt
source source-write_aln.txt

echo ======================================================================
echo Take *nonqual.aln alignment files into directory Output/aln.
echo ======================================================================
perl ~/SeqQual/print_source-take_aln.pl inputfile > source-take_aln.txt
source source-take_aln.txt


## C) third produce the fasta alignments from the large new ace file, filtering for quality information from the phd files 

     # Use qual2ball_mod.pl script to change fasta.qual format

perl ~/SeqQual/qual2ball_mod.pl acequal/Notho_clip4.fasta > acequal/Notho_clip4.phdball 

     # Split the large phd ball file created (or more than one) containing quality information
     # from next-generation type data of various sources, so that when connecting it to each contig in the ace, 
     # the large file does no have to be screened entirely each time, this increases the speed of analysis

echo ======================================================================
echo Split phd.ball.1
echo ======================================================================
perl ~/SeqQual/print_source-largephd_split.pl inputfile > source-largephd_split.txt
source source-largephd_split.txt
perl ~/SeqQual/print_log-largephd_split.pl >> log.txt

rm acequal/Notho_clip.phdball  # removing large phdball file
 
echo ======================================================================
echo Create working directories/files.
echo ======================================================================
perl ~/SeqQual/print_source-acedealing-qual.pl inputfile > source-acedealing.txt
source source-acedealing.txt
perl ~/SeqQual/print_log-acedealing-qual.pl >> log.txt

     # integrate quality into fasta alignment on a per nucleotide basis
echo ======================================================================
echo Write fasta alignment files #--> analogous to using print_source-write_aln-haploid.pl from SeqQual-part1-scripts
echo ======================================================================
# value after "inputfile" refer to the Phred score equivalent for your NGS data whatever their origin
# From empirical comparisons, a value of 20 can be used for quality values from NGS reads but this has to be 
# adapted to your type of data and quality parameter 
 
perl ~/SeqQual/print_source-write_aln-qual.pl inputfile 20 > source-write_aln.txt
source source-write_aln.txt
# the same value here than above need to be put before ">>"
perl ~/SeqQual/print_log-write_aln-qual.pl 20 >> log.txt

echo ======================================================================
echo Take *phred*.aln alignment files into directory Output/aln.
echo ======================================================================
perl ~/SeqQual/print_source-take_aln.pl inputfile > source-take_aln.txt
source source-take_aln.txt


## D) use combine_aln_byace.pl to integrate quality into fasta.aln derived from new ace
    # dealing with edited sequences from the ace format from MIRA if needed

cd Output/aln
perl ~/SeqQual/combine_aln_byace.pl 

## the last fasta *.aln are in Output/aln/aln_combined
