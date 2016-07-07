
#! /usr/bin/perl -w
# @(#)qual2ball.pl  2010-03-18  A.J.Travis

#
# Create Phred 'phd.ball' file from FASTA base-calls and quality scores
#

# base-calls
unless ( open( INB, "$ARGV[0]" ) || open( INB, "$ARGV[0].fna" ) ) {
    die "can't open $ARGV[0] or $ARGV[0].fna\n";
}

# quality scores
unless ( open( INQ, "$ARGV[0].qual" ) ) {
    die "can't open $ARGV[0].qual\n";
}

# read initial FASTA header
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
