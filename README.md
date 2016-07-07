# SeqQual
SeqQual
SeqQual is a suite of <b>Perl/Bioperl scripts</b> for bioinformatic analyses with the general aim of <b>integrating quality</b> at the nucleotide level and <b>prepare fasta alignment files</b> for further population genetic analyses. It also includes many scripts for post-processing batches of fasta alignment files and compute some summary statistics.

SeqQual is divided into 3 groups of scripts depending on the input files(see the Graphical-overview.pdf and <a href="#help_documents">HELP documents</a> ):

<b> 1) Ab1/Abd Chromatogram sequence data</b> from ABI sequencers for which very few automatic tools are available. Scripts help to validate sequence data by typically reducing the necessary time by a factor of 50 to 100. Input files are individual diploid or haploid *.ab1/*.abd/*.scf sequence files, with or without corresponding *.poly or *.phd files. The main tasks consist in aligning sequences, and masking nucleotides below a user-defined quality threshold while identifying heterozygotes in diploid data. Output files are fasta alignments.\n
<b>2) Medium throughput sequence data</b> projects (such as Genotype-By-Sequencing (GBS) projects or Next-Generation Sequencing data from 454 or Illumina Biosystems) corresponding to 1 to a few tens of thousands alignments (workable size tested for one alignment of ~15 kb). Input files are *.ace assembly files with or without *.phdball or *.qual files. The main tasks consist, in each contig, in masking nucleotides below a user-defined quality threshold and producing batches of fasta alignments for further post-treatment.\n
<b>3)</b> Reasonable amounts of <b>fasta alignment files</b> (test performed with less than 50000, of ~1 kb average size) from low to high throughput sequencing projects and that need further post-processing and analyses in batch. Many possible tasks include data filtering, various masking steps, data formatting, summary statistics computing across SNPs (for N or 2N data). Output files can be fasta alignments, data in different format (e.g. <A HREF="http://cmpg.unibe.ch/software/arlequin35/">Arlequin</A> or <A HREF="http://www.ub.edu/dnasp/">DNAsp</A> output files), or result output files.\n



Programs in SeqQual mainly perform 3 groups of tasks (see <a href="#help_documents">HELP documents</a> ):
1)  Processing of *.ab1/*.abd/*.scf/*.phd/*.poly/*.ace/*.phd-like/*.fasta files by masking nucleotides below a user-defined quality threshold and identifying heterozygotes in diploid data. Output files are fasta alignments.
2)  Filtering/masking steps/formatting data. Output files are fasta alignments or  <A HREF="http://cmpg.unibe.ch/software/arlequin35/">Arlequin</A> or <A HREF="http://www.ub.edu/dnasp/">DNAsp</A>  formatted data files…
3)  Computing summary statistics across SNPs (for diploid or haploid data)

SeqQual can be useful for :
<b>Ab1/Abd Chromatogram sequence data</b> from ABI sequencers for which very little automatic tools are available. It typically reduces the time spent to validate sequence data by a factor of 50 to 100. Input files are individual diploid/haploid *.ab1/*.abd and *.phd files, alignment are performed
<b>Medium throughput sequence data</b> projects (such as Genotype-by-Sequencing projects or NGS data from 454 or Illumina systems) and can be useful for 1 to a few tens of thousands alignments (max size tested: ~15 kb). Input files are *.ace assembly files with or without *.qual files 
Reasonable amounts of <b>fasta alignment files</b> (e.g. < 50000 of ~1 kb average size) from low to high throughput sequencing projects or resulting from other programs that need further post-processing/analyses

<h2 id="help_documents">HELP documents</h2>
Details for installing and using the scripts can be found here. For tasks 1) above, the softwares  <A HREF="http://www.phrap.org/consed/consed.html#howToGet">Phred/Phrap</A>  softwares are required and easy to obtain by following instructions on their websites. The  <A HREF="http://droog.gs.washington.edu/polyphred/">PolyPhred</A> software is only needed if you deal with Chromatogram abd/ab1 files from diploid DNA. The Perl language and <A HREF="hhttp://www.bioperl.org/wiki/Installing_BioPerl_on_Unix">BioPerl</A> modules are needed to run all scripts. 

Examples of Linux <b>Shell command files</b> are given here to help organize the scripts into user-defined pipelines.

A <b>summary description</b> of each script can be found here.

<h2>Download page</h2>

<h2>References</h2>

Application to ab1/abd sequence data files and fasta alignments post-processing and analyzing:
Lang T, Abadie P, Léger V, Decourcelle T, Frigerio J-M, Burban C, Bodénès C, Guichoux E, Le Provost G, Robin C, Léger P, Lepoittevin C, El Mujtar VA, Hubert F, Tibbits J, Paiva J, Franc A, Raspail F, Mariette S, Tani N, Reviron M-P, Plomion C, Kremer A, Desprez-Loustau M-L, Garnier-Géré P. High quality SNP development … in European White oak pecies”. (in preparation)

Examples of SeqQual applications to larger *.ace assembly and fasta alignment files: 
El Mujtar VA, Gallo LA, Lang T, Garnier‐Géré P (2014) Development of genomic resources for Nothofagus species using next‐generation sequencing data. Molecular Ecology Resources 14(6) : 1281–1295. <A HREF="http://onlinelibrary.wiley.com/doi/10.1111/1755-0998.12276/full">(Link to journal site)</A>

Brousseau L, Tinaut A, Duret C, Lang T, Garnier-Gere P, Scotti I (2014) High-throughput transcriptome sequencing and preliminary functional analysis in four Neotropical tree species. BMC genomics 15 (1): 238. <A HREF="http://bmcgenomics.biomedcentral.com/articles/10.1186/1471-2164-15-238">(Link to journal site)</A>


<h2>Contacts</h2>
Please send feedback or ask for assistance to: 
<A HREF="mailto:pauline.garnier-gere@pierroton.inra.fr"> Pauline Garnier-Géré</A>, 
<A HREF="mailto:langtiange@xtbg.org.cn"> Tiange Lang</A>
