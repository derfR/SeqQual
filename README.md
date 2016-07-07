# SeqQual
SeqQual
SeqQual is a suite of <b>Perl/Bioperl scripts</b> for bioinformatic analyses with the general aim of <b>integrating quality</b> at the nucleotide level and <b>prepare fasta alignment files</b> for further population genetic analyses. It also includes many scripts for post-processing batches of fasta alignment files and compute some summary statistics.

SeqQual is divided into 3 groups of scripts depending on the input files(see the <A HREF= "SeqQual_pdf/Graphical-overview.pdf" Graphical-overview</A> and <a href="#help_documents">HELP documents</a> ):

<b> 1) Ab1/Abd Chromatogram sequence data</b> from ABI sequencers for which very few automatic tools are available. Scripts help to validate sequence data by typically reducing the necessary time by a factor of 50 to 100. Input files are individual diploid or haploid *.ab1/*.abd/*.scf sequence files, with or without corresponding *.poly or *.phd files. The main tasks consist in aligning sequences, and masking nucleotides below a user-defined quality threshold while identifying heterozygotes in diploid data. Output files are fasta alignments.
<br />
<b>2) Medium throughput sequence data</b> projects (such as Genotype-By-Sequencing (GBS) projects or Next-Generation Sequencing data from 454 or Illumina Biosystems) corresponding to 1 to a few tens of thousands alignments (workable size tested for one alignment of ~15 kb). Input files are *.ace assembly files with or without *.phdball or *.qual files. The main tasks consist, in each contig, in masking nucleotides below a user-defined quality threshold and producing batches of fasta alignments for further post-treatment.
<br />
<b>3)</b> Reasonable amounts of <b>fasta alignment files</b> (test performed with less than 50000, of ~1 kb average size) from low to high throughput sequencing projects and that need further post-processing and analyses in batch. Many possible tasks include data filtering, various masking steps, data formatting, summary statistics computing across SNPs (for N or 2N data). Output files can be fasta alignments, data in different format (e.g. <A HREF="http://cmpg.unibe.ch/software/arlequin35/">Arlequin</A> or <A HREF="http://www.ub.edu/dnasp/">DNAsp</A> output files), or result output files.
<br />

<h2 id="help_documents">HELP documents</h2>
Details for installing and using the scripts can be found in the main <b>User Documentation</b>. The Perl language and <A HREF="http://www.bioperl.org/wiki/Installing_BioPerl_on_Unix">BioPerl</A> modules are needed to run all the scripts for <b>tasks 1), 2)</b> and <b>3)</b> above. Additionnally, please note that for <b>tasks 1)</b>, the <A HREF="http://www.phrap.org/consed/consed.html#howToGet">phred/phrap/consed </A> software suite are required and easy to obtain by following the authors’ instructions. The <A HREF="http://droog.gs.washington.edu/polyphred/">polyphred</A>  software is only needed if you deal with Chromatogram abd/ab1 files from diploid DNA. 

<b>Details</b> for each script can be found here for <b>tasks 1),</b> here for <b>tasks 2),</b> here for <b>tasks 3)</b>. For several scripts, log files can be printed from print_log*.pl scripts described here.

<b>Examples</b> of Linux <b>Shell command files</b> are given to help organize the scripts into user-defined pipelines.

<h2>Download page of SeqQual (all the scripts)</h2>

<h2>References</h2>
Application to ab1/abd sequence data files and fasta alignments post-processing and analyzing:
Lang T, Abadie P, Léger V, Decourcelle T, Frigerio J-M, Burban C, Bodénès C, Guichoux E, Le Provost G, Robin C, Léger P, Lepoittevin C, El Mujtar VA, Hubert F, Tibbits J, Paiva J, Franc A, Raspail F, Mariette S, Tani N, Reviron M-P, Plomion C, Kremer A, Desprez-Loustau M-L, Garnier-Géré P. High quality SNP development … in European White oak pecies”. (in preparation)
<br />
Examples of SeqQual applications to larger *.ace assembly and fasta alignment files: 
El Mujtar VA, Gallo LA, Lang T, Garnier‐Géré P (2014) Development of genomic resources for Nothofagus species using next‐generation sequencing data. Molecular Ecology Resources 14(6) : 1281–1295.
<A HREF="http://onlinelibrary.wiley.com/doi/10.1111/1755-0998.12276/abstract">(Link to journal site)</A>
<br />
Brousseau L, Tinaut A, Duret C, Lang T, Garnier-Gere P, Scotti I (2014) High-throughput transcriptome sequencing and preliminary functional analysis in four Neotropical tree species. BMC genomics 15 (1): 238. <A HREF="http://bmcgenomics.biomedcentral.com/articles/10.1186/1471-2164-15-238">(Link to journal site)</A>
<br />
<h2>Contacts</h2>
Please send feedback or ask for assistance to: 
<A HREF="mailto:pauline.garnier-gere@pierroton.inra.fr"> Pauline Garnier-Géré</A>, 
<A HREF="mailto:langtiange@xtbg.org.cn"> Tiange Lang</A>
<h2>Links</h2>
<A HREF="http://cmpg.unibe.ch/software/arlequin35/" Arlequin </A>
<A HREF="http://www.ub.edu/dnasp/" DNAsp </A>
<A HREF="http://www.bioperl.org/wiki/Installing_BioPerl_on_Unix" Bioperl </A>
<A HREF="http://www.phrap.org/consed/consed.html#howToGet" phred/phrap/consed </A>
<A HREF="http://droog.gs.washington.edu/polyphred/" polyphred</A>
