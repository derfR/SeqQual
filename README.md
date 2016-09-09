# SeqQual
SeqQual
 is a suite of <b>Perl/Bioperl scripts</b> with the general aim of <b>integrating quality</b> at the nucleotide level and <b>prepare fasta alignment files</b> for further population genetic analyses. It also includes scripts for post-processing batches of fasta alignment files and computes some summary statistics for polymorphisms.

SeqQual is divided into 3 groups of scripts depending on input files and tasks (see the <A HREF= "SeqQual_pdf/SeqQual-Graphical-Overview-Website.pdf"> Graphical-overview</A> and <a href="#help_documents">HELP documents</a> ):

<b>1)<b> Scripts dealing with <b>Ab1/Abd Chromatogram sequence data</b> from ABI sequencers for which very few automatic tools were/are available. These scripts helped to validate sequence data in a previous resequencing project by typically reducing the necessary time by a factor of 50 to 100. They migth still be useful for re-analyses or rare validation projects with this type of data. Input files are individual diploid or haploid <b>.ab1/. abd/.scf sequence files</b>, with or without corresponding .poly or .phd files. The main tasks consist in aligning sequences, and masking nucleotides below a user-defined quality threshold while identifying heterozygotes in diploid data. Output files are fasta alignments.
<br />
<b>2)<b> Scripts useful for <b>medium throughput sequence data</b> projects (such as Genotype-By-Sequencing (GBS) projects or Next-Generation Sequencing data from 454 or Illumina Biosystems) corresponding to 1 to a few tens of thousands alignments (test done with alignments of size up to 15 kb). Input files are <b>.ace assembly files</b> with or without .phdball or .qual files. The main tasks consist, in each contig, in masking nucleotides below a user-defined quality threshold and producing batches of fasta alignments for further post-treatment.
<br />
<b>3)<b> Scripts dealing with reasonable amounts of <b>fasta alignment files</b> (test performed with less than 50000, of ~1 kb average size) from low to high throughput sequencing projects and that need further post-processing and analyses in batch. Possible tasks include data filtering, various masking steps, data formatting, summary statistics computing across SNPs (for N or 2N data). Output files can be fasta alignments, data in different formats (e.g. <A HREF="http://cmpg.unibe.ch/software/arlequin35/">Arlequin</A> or <A HREF="http://www.ub.edu/dnasp/">DNAsp</A> input files), or result files on SNP statistics.
<br />

<h2 id="help_documents">HELP documents</h2>

A description of each script and its usage can be found <A HREF= "SeqQual_pdf/"> here</A> in 3 documents relating to part <b>1),</b>  <b> 2),</b> or <b>3) (Fastools) </b>. For several scripts, log files can be printed from associated  "print_log*.pl" scripts described <A HREF= "SeqQual_pdf/"> here</A>. Then all you need to get started is to download the zip that include the script(s) you are interested in on the download page below, and unzip them under your home directory. The scripts will be located by default under the ~/SeqQual folder.

<b>Examples</b> of Linux <A HREF="SeqQual_shell_ex"> Shell command files</A> are also given with added comments to help organize the scripts into user-defined pipelines. For example, 1.0-diploid-ab1.sh and 3.1-fasta-diploid-data.sh have been used in Lang et al. below. A few examples of input data are also provided for *.ab1, *.ace and *.fas files (see <A HREF="Data-examples"> Data-examples</A>) folder, with corresponding result output files (see <A HREF="Results-examples"> Results-examples</A> folder).

The Perl language and <A HREF="http://bioperl.org/">BioPerl</A> modules are needed to run all scripts for the tasks performed for <b>1), 2)</b> and <b>3)</b> above. Additionnally, please note that for the scripts in <b>part-1)</b>, the <A HREF="http://www.phrap.org/consed/consed.html#howToGet">phred/phrap/consed </A> software suite are required and easy to obtain and install by following the authors’ instructions. The <A HREF="http://droog.gs.washington.edu/polyphred/">polyphred</A>  software is only needed if you deal with Chromatogram abd/ab1 files from diploid DNA. 

More advices on installing and using the scripts can be found in the <A HREF= "SeqQual_pdf/"> User-Documentation.pdf</A> file. 

<h2><A HREF="Source-download" >Download page</A> of SeqQual </h2>

<h2>References</h2>
<i>Application to ab1/abd sequence data files and fasta alignments post-processing and analyzing:</i> <br />
Lang T, Abadie P, Léger V, Decourcelle T, Frigerio J-M, Burban C, Bodénès C, Guichoux E, Le Provost G, Robin C, Léger P, Lepoittevin C, El Mujtar VA, Hubert F, Tibbits J, Paiva J, Franc A, Raspail F, Mariette S, Tani N, Reviron M-P, Plomion C, Kremer A, Desprez-Loustau M-L, Garnier-Géré P. High quality SNP development … in European White oak pecies”. (in preparation)
<br /><br />
<i>Examples of SeqQual applications to larger *.ace assembly and fasta alignment files:</i> <br />
El Mujtar VA, Gallo LA, Lang T, Garnier‐Géré P (2014) Development of genomic resources for Nothofagus species using next‐generation sequencing data. Molecular Ecology Resources 14(6) : 1281–1295.
<A HREF="http://onlinelibrary.wiley.com/doi/10.1111/1755-0998.12276/abstract">(Link to journal site)</A>
<br /><br />
Brousseau L, Tinaut A, Duret C, Lang T, Garnier-Gere P, Scotti I (2014) High-throughput transcriptome sequencing and preliminary functional analysis in four Neotropical tree species. BMC genomics 15 (1): 238. <A HREF="http://bmcgenomics.biomedcentral.com/articles/10.1186/1471-2164-15-238">(Link to journal site)</A>
<br />
<h2>Contacts</h2>
Please send feedback or ask for assistance to: 
<A HREF="mailto:pauline.garnier-gere@pierroton.inra.fr"> Pauline Garnier-Géré</A>, or 
<A HREF="mailto:langtiange@xtbg.org.cn"> Tiange Lang</A>

<!--<h2>Links</h2> -->
<h2>Links</h2>
Arlequin   <A HREF="http://cmpg.unibe.ch/software/arlequin35/" Arlequin </A> http://cmpg.unibe.ch/software/arlequin35/ <br />
DNAsp   <A HREF="http://www.ub.edu/dnasp/" DNAsp </A> http://www.ub.edu/dnasp/ <br />
Bioperl    <A HREF="http://bioperl.org/" Bioperl </A> http://bioperl.org/ <br />
phred/phrap/consed<A HREF="http://www.phrap.org/consed/consed.html#howToGet" phred/phrap/consed </A>  http://www.phrap.org/consed/consed.html#howToGet <br />
polyphred  <A HREF="http://droog.gs.washington.edu/polyphred/" polyphred</A>  http://droog.gs.washington.edu/polyphred/ <br />
