# SeqQual
SeqQual  
SeqQual is a suite of <b>Perl/Bioperl scripts</b> for bioinformatic analyses with the general aim of <b>integrating quality</b> at the nucleotide level and <b>prepare fasta alignment</b> files for further population genetic analyses. 

Different tasks can be performed in batch across contigs including: data validation integrating quality scores, data filtering in different steps, production of fasta alignment files, post-processing of fasta alignments for further statistical analyses( Graphical overview).

Programs in SeqQual mainly perform 3 groups of tasks (see HELP documents):
1)  Processing of *.ab1/*.abd/*.scf/*.phd/*.poly/*.ace/*.phd-like/*.fasta files by masking nucleotides below a user-defined quality threshold and identifying heterozygotes in diploid data. Output files are fasta alignments.
2)  Filtering/masking steps/formatting data. Output files are fasta alignments or  <A HREF="http://cmpg.unibe.ch/software/arlequin35/">Arlequin</A> or DNAsp formatted data files…
3)  Computing summary statistics across SNPs (for diploid or haploid data)

SeqQual can be useful for :
<b>Ab1/Abd Chromatogram sequence data</b> from ABI sequencers for which very little automatic tools are available. It typically reduces the time spent to validate sequence data by a factor of 50 to 100. Input files are individual diploid/haploid *.ab1/*.abd and *.phd files, alignment are performed
<b>Medium throughput sequence data</b> projects (such as Genotype-by-Sequencing projects or NGS data from 454 or Illumina systems) and can be useful for 1 to a few tens of thousands alignments (max size tested: ~15 kb). Input files are *.ace assembly files with or without *.qual files 
Reasonable amounts of <b>fasta alignment files</b> (e.g. < 50000 of ~1 kb average size) from low to high throughput sequencing projects or resulting from other programs that need further post-processing/analyses

HELP documents 
Details for installing and using the scripts can be found here. For tasks 1) above, the softwares Phred/Phrap softwares are required and easy to obtain by following instructions on their websites. The PolyPhred software is only needed if you deal with Chromatogram abd/ab1 files from diploid DNA. The Perl language and BioPerl modules are needed to run all scripts. 

Examples of Linux <b>Shell command files</b> are given here to help organize the scripts into user-defined pipelines.

A <b>summary description</b> of each script can be found here.

Download page

References

Application to ab1/abd sequence data files and fasta alignments post-processing and analyzing:
Lang T, Abadie P, Léger V, Decourcelle T, Frigerio J-M, Burban C, Bodénès C, Guichoux E, Le Provost G, Robin C, Léger P, Lepoittevin C, El Mujtar VA, Hubert F, Tibbits J, Paiva J, Franc A, Raspail F, Mariette S, Tani N, Reviron M-P, Plomion C, Kremer A, Desprez-Loustau M-L, Garnier-Géré P. High quality SNP development … in European White oak pecies”. (in preparation)

Examples of SeqQual applications to larger *.ace assembly and fasta alignment files: 
El Mujtar VA, Gallo LA, Lang T, Garnier‐Géré P (2014) Development of genomic resources for Nothofagus species using next‐generation sequencing data. Molecular Ecology Resources 14(6) : 1281–1295. (Link to journal site)
Brousseau L, Tinaut A, Duret C, Lang T, Garnier-Gere P, Scotti I (2014) High-throughput transcriptome sequencing and preliminary functional analysis in four Neotropical tree species. BMC genomics 15 (1): 238. (link to journal site)

Contacts
Please send feedback or ask for assistance to: 
<A HREF="mailto:pauline.garnier-gere@pierroton.inra.fr"> Pauline Garnier-Géré</A>
<A HREF="mailto:langtiange@xtbg.org.cn"> Tiange Lang</A>

Links
Arlequin http://cmpg.unibe.ch/software/arlequin35/
DNAsp http://www.ub.edu/dnasp/
Bioperl http://www.bioperl.org/wiki/Installing_BioPerl_on_Unix
Phred/Phrap http://www.phrap.org/consed/consed.html#howToGet
PolyPhred http://droog.gs.washington.edu/polyphred/
Paper MER http://onlinelibrary.wiley.com/doi/10.1111/1755-0998.12276/full
Paper BMC genomics http://bmcgenomics.biomedcentral.com/articles/10.1186/1471-2164-15-238
