#!/usr/bin/env perl

# This script is part of the SeqQual pipeline which automatically process DNA sequences from chromatogram *.ab1/abd/scf files and ace assemblies while integrating quality.
# Copyright 2014 Tiange Lang and Pauline Garnier-Gere, INRA
# Last updated 22 April 2014
# SeqQual scripts are free to be distributed and/or changed under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version. These scripts are distributed in the hope that they will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details at <http://www.gnu.org/licenses/>.

unless ( open( INB, "$ARGV[0]" ) || open( INB, "$ARGV[0].fna" ) ) {
    die "can't open $ARGV[0] or $ARGV[0].fna\n";
}

unless ( open( INQ, "$ARGV[0].qual" ) ) {
    die "can't open $ARGV[0].qual\n";
}

$headb = <INB>;
chomp($headb);
$headq = <INQ>;
chomp($headq);

while ( !eof INB ) {

    # read base calls
    $nbase = 0;
    while ( $lineb = <INB> ) {
        chomp($lineb);
        if ( $lineb =~ /^>/ ) {
            last;
        }
        @bases = split( //, $lineb );
        foreach $base (@bases) {
            $conb[ $nbase++ ] = $base;
        }
    }

    # read quality scores
    $nqual = 0;
    while ( $lineq = <INQ> ) {
        chomp($lineq);
        if ( $lineq =~ /^>/ ) {
            last;
        }
        @qnos = split( ' ', $lineq );
        foreach $qual (@qnos) {
            $conq[ $nqual++ ] = $qual;
        }
    }

    unless ( ( $lineb =~ /^>/ || eof INB ) && ( $lineq =~ /^>/ || eof INQ ) ) {
        die "failed to parse $ARGV[0]\n";
    }

    # parse FASTA name from header
    ($fname) = ( $headb =~ />(\S+)/ );

    $now = localtime;
    print("BEGIN_SEQUENCE $fname\n\n");
    print("BEGIN_COMMENT\n\n");
    print("CHROMAT_FILE: none\n");
    print("QUALITY_LEVELS: 99\n");
    print("TIME: $now\n");
    print("TRACE_ARRAY_MIN_INDEX: 0\n");
    print("TRACE_ARRAY_MAX_INDEX: 0\n");
    print("CHEM: 454\n");
    print("END_COMMENT\n\n");
    print("BEGIN_DNA\n");

    for ( $base = 0 ; $base < $nbase ; $base++ ) {
        print("$conb[$base] $conq[$base] 0\n");
    }
    print("END_DNA\n\n");
    print("END_SEQUENCE\n");

    $headb = $lineb;
    $headq = $lineq;
}
