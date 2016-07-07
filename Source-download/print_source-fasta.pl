#!/usr/bin/env perl

# This script is part of the SeqQual pipeline which automatically process chromatogram data and ace assemblies while integrating quality.
# Copyright 2010 Tiange Lang and Pauline Garnier-Géré, INRA
# Last updated 26-April-2010
# SeqQual is a free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program. If not, see <http://www.gnu.org/licenses/>.

$input=shift;
open (IN, "<$input");
while (<IN>){
    chomp;
    next unless(/\S/);
    print "cd $_\n";
    print "echo --------------------------------------------------\n";
    print "echo Dealing $_\n";
    print "echo --------------------------------------------------\n";
    print "perl ~/SeqQual/checkdir_mydata.pl\n";
    print "mkdir mydata\n";
    print "cd mydata\n";
    print "mkdir aln_final\n";
    print "cp ../* aln_final\n";
    print "cd ../../\n\n\n";
}
