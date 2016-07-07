#!/bin/sh
     # This small utility program will remove all the previous mydata directory 
     # (including the last one) and corresponding subdirectories created during 
     # SeqQual for the list of fragments/genes directories listed in the "inputfile" 
     # text document

echo ======================================================================
echo SeqQual clean.
echo ======================================================================
perl ~/SeqQual/clean_all.pl inputfile
