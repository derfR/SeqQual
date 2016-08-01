#!/bin/sh

# program to run before running the SeqQual pipeline in order to check 
# that the list of folder targeted exist or are not uncorrectly spelled.

echo Checking folder list before SeqQual analysis

perl ~/SeqQual/checkinput.pl inputfile
