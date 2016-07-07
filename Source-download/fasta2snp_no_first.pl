#!/usr/bin/env perl

# This script is part of the SeqQual pipeline which automatically process chromatogram data and ace assemblies while integrating quality.
# Copyright 2010 Tiange Lang and Pauline Garnier-Géré, INRA
# Last updated 26-April-2010
# SeqQual is a free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program. If not, see <http://www.gnu.org/licenses/>.



use strict;
use warnings;

use Bio::SeqIO;
use Bio::AlignIO;

system("mkdir -p 'SNP'") == 0
    or die "Can't create SNP\n";

opendir DIR, '.' or die "can't open $_: $!\n";
while( my $file = readdir DIR)
{
  next unless $file =~ /\.aln$/;
  my $seqio   = Bio::SeqIO->new('-file' =>  $file,     '-format' => 'fasta');
  my $seqout  = Bio::SeqIO->new('-file' => ">$file.N", '-format' => 'fasta');
  my $aln_out = Bio::SeqIO->new('-file' => ">SNP/$file.snp", '-format' => 'fasta');
  $seqio->next_seq;
  while(my $seq = $seqio->next_seq)
  {
    next unless $seq->seq;
    my $s = uc $seq->seq;
    $s =~ tr/?/N/;
    $s =~ tr/~/-/;
    $s =~ tr/-/I/; # replace - by I for Bio::AlignIO
    $seq->seq($s);
    $seqout->write_seq($seq);
  }
  if (-z "$file.N")  { unlink "$file.N";die "No $file.N\n"; }

  my $aln =  Bio::AlignIO->new('-file' => "$file.N", '-format' => 'fasta')->next_aln;

  my @seq_snp;
  push @seq_snp,Bio::Seq->new(
      '-id'       => $_->id,
      '-verbose'  => -1) for $aln->each_seq;
  my @pos;
  for my $col (1 .. $aln->length)
  {
    my $mini_aln = $aln->slice($col,$col);
    my %base;
    my @base;
    for my $seq ($mini_aln->each_seq)
    {
      $base{$seq->seq}++;
      push @base,$seq->seq;
    }
    delete $base{'N'};
    next if scalar keys %base <= 1 ;
    push @pos,$col;

    my $base = 0;
    for my $seq_snp (@seq_snp)
    {
      $base[$base] =~ tr/I/-/;
      $base[$base] =~ tr/N/?/;
      defined $seq_snp->seq  ? $seq_snp->seq($seq_snp->seq.$base[$base]) :
                               $seq_snp->seq($base[$base]);     
      $base++;
    }
  }
  my $header = Bio::Seq->new('-id'   =>"#SNP", '-format' => 'fasta',
                        '-desc' => scalar @pos."  SNP pos: @pos");

  $aln_out->write_seq($header);
  for my $seq_snp (@seq_snp)
  {
   $aln_out->write_seq($seq_snp);
  }
  unlink "$file.N";
}
