#!/usr/bin/env perl 
#===============================================================================
#
#         FILE:  cleanAln
#
#        USAGE:  ./cleanAln --file=fasta_file.fas [> result.fas]
#   For applying on many files:
#      $for file in *.aln; do cleannAln --file=$file > $file.result;done;
#
#  DESCRIPTION:  
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  jmf, Jean-Marc.Frigerio@pierroton.inra.fr
#      COMPANY:  INRA
#      VERSION:  1.0
#      CREATED:  13/04/2010 15:39:52
#     REVISION:  ---
#===============================================================================
#1/ Ordonner les reads par ordre de position dans le contig A FAIRE
#
#2/ Remplacer les gaps d'alignement "-" en début et en fin de séquence par des "?" (attention, ne pas remplacer les INDELs en milieu de séquence)  
#3 mettre au carré A FAIRE
#
#clean454.1 sur frontend le jeudi 29 avril 2010 10:34
#clean454.2  
#clean454.3  sur frontend le jeudi 29 avril 2010 15:10
#
#clean454.4
#clean454.5
# Go object Snp, SnpIO and Allele
#clean454.6
#   DEVIENT cleanAln.1
#   cleanAln.2
#   inclure --man et --man-if-depth


use strict;
use warnings;
use Carp;
use Getopt::Long;

use Bio::SeqIO;
use Bio::LocatableSeq;
use Bio::SimpleAlign;
use Bio::AlignIO;

use Bio::Snp;
use Bio::SnpIO;
use Bio::Allele;

my $file;
my $man           = 2;
my $maf           = 10;
my $man_if_depth  = 0;
GetOptions(
    "file=s"          => \$file,
    "man=s"           => \$man,
    "man-if-depth=s"  => \$man_if_depth,
    "maf=s"           => \$maf);
defined $file  or die qq{Usage: cleanAln --maf --man --man-if-depth --file=fasta_file.fas [> result.fas]\nFor applying on many files:\n for file in *.aln; do cleanAln --file=\$file > \$file.result;done;\n};

local $SIG{__WARN__} = sub
{
  return;
  return if $_[0] eq
"\n--------------------- WARNING ---------------------
MSG: Got a sequence with no letters in it cannot guess alphabet
---------------------------------------------------\n";

  return if $_[0] =~ /WARNING/; 

  print STDERR "$_[0]";
};

my %seq;

my $seqin =  Bio::SeqIO->new('-file' => $file, '-format' => 'fasta');

my @length;
my $seq;
my @empty_seq;
while ($seq = $seqin->next_seq)
{
  $_    = $seq->seq;
 #au début
  if ((/^(-+)/))
  { 
    substr($_,0,length $&) = '?' x length $&;
    $seq->{begin_length} = length $&
  }

  
  $seq->{begin_length} ||= 0;

#à la fin au cas ou
  substr($_, pos() - length $&,length $&) = '?' x length $& if /(-+)$/g;

  s/N/?/g;
  warn "\n--------------------- WARNING ---------------------
MSG: Only ACGT? allowed ----- in ", $seq->id,"\n" if (s/[^-ACGT?]/N/g);
  $seq->seq($_);

  if ($seq->seq eq '' or $seq->seq !~ /[ACGTN]/ )
  {
    push @empty_seq,$seq;
    next;
  }

  $seq{$seq->id} = $seq;
  push @length,$seq->length;
}
my $maxlen = (sort {$b<=>$a}@length)[0];

my @locatable;

for (sort {$seq{$a}->{begin_length} <=> $seq{$b}->{begin_length}} keys %seq)
{ 
  if ($seq{$_}->length < $maxlen)
  { 
    my $s = $seq{$_}->seq;
    $s .= '?' x ($maxlen - $seq{$_}->length);
    $seq{$_}->seq($s);
  }
  push @locatable,Bio::LocatableSeq->new(
                  '-id'     => $seq{$_}->id,
                  '-seq'    => $seq{$_}->seq);
}

my $aln   = Bio::SimpleAlign->new('-seqs' => \@locatable);
my $snpio = SnpIO->new(aln => $aln, no_doubt => 'TRUE');
local $| = 1;
while( my $snp = $snpio->next_snp)
{
  next unless $snp->isa('Snp');
  print STDERR ".";
  my $minor_allele  = $snp->minor_allele;
  my $al_man        = $minor_allele->number;
  my $depth         = scalar keys %{$snp->alleles};
print STDERR $snp->col, " DEPTH $depth\n";
  while ($al_man <= $man and $depth >= $man_if_depth)
  {
    for (@{$minor_allele->ids})
    {
      my $seq = $snpio->aln->get_seq_by_id($_);
      my $s   = $seq->seq;
      next if $minor_allele->base eq '?';
      substr($s,$snp->col - 1,1) = '?';
      print STDERR "MAN = $al_man, masquing ",$minor_allele->base,
      " at ",$snp->col," on $_\n";
      $snp->delete($_); #no_doubt
      $snp->alleles(%{$snp->alleles});
      $seq->seq($s);
      $seq = $snpio->aln->get_seq_by_id($_);
      $minor_allele  = $snp->minor_allele;
      $al_man        = $minor_allele->number;
    }
  }

  my $al_maf        = $minor_allele->frequency;
  while ($al_maf <= $maf)
  {
    for (@{$minor_allele->ids})
    {
      my $seq = $snpio->aln->get_seq_by_id($_);
      my $s   = $seq->seq;
      next if $minor_allele->base eq '?';
      substr($s,$snp->col - 1,1) = '?';
      print STDERR "MAF = $al_maf, masquing ",$minor_allele->base,
      " at ",$snp->col," on $_\n";
      $snp->delete($_); #no_doubt
      $snp->alleles(%{$snp->alleles});
      $seq->seq($s);
      $seq = $snpio->aln->get_seq_by_id($_);
      $minor_allele  = $snp->minor_allele;
      $al_maf        = $minor_allele->frequency;
    }
  }
}

my $seqout = Bio::SeqIO->new('-fh'  => \*STDOUT,'-format'  => 'fasta');

#my $aln_out =  Bio::AlignIO->new('-fh'  => \*STDOUT, '-format'  => 'fasta' );

for ($aln->each_seq,@empty_seq)
{
  $seqout->write_seq($_);
}
__END__
for (@empty_seq)
{
  $seqout->write_seq($_);
}


