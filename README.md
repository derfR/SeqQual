# SeqQual
SeqQual
 is a suite of <b>Perl/Bioperl scripts</b> that aim at <b>integrating quality</b> at the nucleotide level and <b>prepare fasta alignment files</b> for further population genetic analyses. It also includes scripts for post-processing fasta alignment files in batch and computes some summary statistics for polymorphisms.

SeqQual is divided into 3 groups of scripts depending on input files and tasks (see the <A HREF= "SeqQual-Graphical-Overview.pdf"> Graphical-overview</A> and <a href="#help_documents">HELP documents</a> ):

1) Scripts dealing with <b>Ab1/Abd Chromatogram sequence data</b> from ABI sequencers for which very few automatic tools were/are available. These scripts helped validating sequence data in the resequencing project cited below (Lang et al. in preparation), by typically reducing the necessary time by a factor of 50 to 100. They migth still be useful for re-analyses or rare validation projects with this type of data. Input files are individual diploid or haploid <b>.ab1/. abd/.scf sequence files</b>, with or without corresponding .poly or .phd files. The main tasks consist in aligning sequences, and masking nucleotides below a user-defined quality threshold while identifying heterozygotes in diploid data. Output files are fasta alignments.

2) Scripts useful for <b>medium throughput sequence data</b> projects (such as Genotype-By-Sequencing (GBS) projects or Next-Generation Sequencing data from 454 or Illumina Biosystems) corresponding to 1 to a few tens of thousands alignments (test done with alignments of size up to 15 kb). Input files are <b>.ace assembly files</b> with or without .phdball or .qual files. The main tasks consist, in each contig, in masking nucleotides below a user-defined quality threshold and producing batches of fasta alignments for further post-treatment.

3) Scripts dealing with reasonable amounts of <b>fasta alignment files</b> (test performed with up to 50000, of ~1 kb average size) from low to high throughput sequencing projects and that need further post-processing and analyses in batch. Possible tasks include data filtering, various masking steps, data formatting, summary statistics computing across SNPs (for N or 2N data). Output files can be fasta alignments, data in different formats (e.g. <A HREF="http://cmpg.unibe.ch/software/arlequin35/">Arlequin</A> or <A HREF="http://www.ub.edu/dnasp/">DNAsp</A> input files), or result files on SNP statistics.

4) Perl scripts for processing raw reads from Next-Generation Sequencing technology. For example, Lang <i>et al.</i> 2018 processed fastq files for quality control and filtering of reads. This code has been compiled in the fastq.phd.split.and.filter.pl (see in <A HREF="NGS.tools"> NGS.tools</A>)
<br />

<h2 id="help_documents">HELP documents</h2>

A description of each script and its usage can be found <A HREF= "SeqQual_pdf/"> here</A> in 3 documents relating to part <b>1),</b>  <b> 2),</b> or <b>3) (Fastools) </b>. For several scripts, log files can be printed from associated  "print_log*.pl" scripts described <A HREF= "SeqQual_pdf/"> here</A>. Then all you need to get started is to download the zip that include the script(s) you are interested in on the download page below, and unzip them under your home directory. The scripts will be located by default under the ~/SeqQual folder.

<b>Examples</b> of Linux <A HREF="SeqQual_shell_ex"> Shell command files</A> are also given with added comments to help organize the scripts into user-defined pipelines. For example, 1.0-diploid-ab1.sh and 3.1-fasta-diploid-data.sh have been used in Lang et al. below. A few examples of input data are also provided for *.ab1, *.ace and *.fas files (see <A HREF="Data-examples"> Data-examples</A>), with corresponding result output files (see <A HREF="Results-examples"> Results-examples</A>).

The Perl language and <A HREF="http://bioperl.org/">BioPerl</A> modules are needed to run all scripts for the tasks performed for <b>1), 2)</b> and <b>3)</b> above. Additionnally, please note that for the scripts in <b>part-1)</b>, the <A HREF="http://www.phrap.org/consed/consed.html#howToGet">phred/phrap/consed </A> software suite are required and easy to obtain and install by following the authors’ instructions. The <A HREF="http://droog.gs.washington.edu/polyphred/">polyphred</A>  software is only needed if you deal with Chromatogram abd/ab1 files from diploid DNA. 

More advices on installing and using the scripts can be found in the <A HREF= "SeqQual_pdf/"> User-Documentation.pdf</A> file. 

<h2><A HREF="Source-download" >Download page</A> </h2>

<h2>References</h2>
<i>Application to ab1/abd sequence data files and fasta alignments post-processing and analyzing:
</i> 

> Lang T, Abadie P, Léger V, Decourcelle T, Frigerio J-M, Burban C, Bodénès C, Guichoux E, Le Provost G, Robin C, Tani N, Léger P, Lepoittevin C, El Mujtar VA, Hubert F, Tibbits J, Paiva J, Franc A, Raspail F, Mariette S, Reviron M-P, Plomion C, Kremer A, Desprez-Loustau M-L, Garnier-Géré P. High-quality GBS-SNPs from genic regions highlight introgression patterns and a large heterogeneity in both diversity and differentiation among European white oaks (<i>Quercus petraea</i> and <i>Q. robur</i>). 

First published in BioRxiv, the last version of the manuscript has been peer-reviewed and recommended by the Peer Community in Forest & Wood Sciences, and is available <A HREF="https://www.biorxiv.org/content/10.1101/388447v4.full.pdf"> here</A>

<i>Examples of SeqQual applications to larger *.ace assembly and fasta alignment files:</i> 

> El Mujtar VA, Gallo LA, Lang T, Garnier‐Géré P (2014) Development of genomic resources for Nothofagus species using next‐generation sequencing data. Molecular Ecology Resources 14(6) : 1281–1295. <A HREF="http://onlinelibrary.wiley.com/doi/10.1111/1755-0998.12276">(Link to journal site)</A>

> Brousseau L, Tinaut A, Duret C, Lang T, Garnier-Gere P, Scotti I (2014) High-throughput transcriptome sequencing and preliminary functional analysis in four Neotropical tree species. BMC genomics 15 (1): 238. <A HREF="http://bmcgenomics.biomedcentral.com/articles/10.1186/1471-2164-15-238">(Link to journal site)</A>

<i>Application to fastq sequence data files (here from Hiseq2000 illumina technology)</i>

>Zhang X, Hu Y, Liu M, Lang T (2018) Optimization of Assembly Pipeline may Improve the Sequence of the Chloroplast Genome in <i>Quercus spinosa</i>. Scientific Reports, 8, 8906.


## Contacts </br>
Pauline Garnier-Géré pauline.garnier-gere@inrae.fr (<A HREF="https://scholar.google.com/citations?user=O_652X4AAAAJ&hl=en"> Google Scholar site)</A> <br />
Tiange Lang langtiange@jnu.edu.cn

## License </br>
The content of this repository is licensed under <A HREF="https://choosealicense.com/licenses/gpl-3.0/">(GNU GPLv3)</A>

## Links ##
Arlequin           http://cmpg.unibe.ch/software/arlequin35/  <br />
DNAsp              http://www.ub.edu/dnasp/ <br />
Bioperl            http://bioperl.org/) <br />
phred/phrap/consed http://www.phrap.org/consed/consed.html#howToGet <br />
polyphred          http://droog.gs.washington.edu/polyphred/
