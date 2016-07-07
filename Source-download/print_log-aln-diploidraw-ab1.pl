#!/usr/bin/env perl

# This script is part of the SeqQual pipeline which automatically process chromatogram data and ace assemblies while integrating quality.
# Copyright 2010 Tiange Lang and Pauline Garnier-Géré, INRA
# Last updated 26-April-2010
# SeqQual is a free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program. If not, see <http://www.gnu.org/licenses/>.

$phrap1=shift;
$phrap2=shift;
$phrap3=shift;
$phrap4=shift;
$phrap5=shift;
$phrap6=shift;
$phrap7=shift;
$phrap8=shift;
$phrap9=shift;
$phrap10=shift;
$phrap11=shift;
$phrap12=shift;
$phrap13=shift;
$phrap14=shift;
$phrap15=shift;
$phrap16=shift;
$phrap17=shift;
$phrap18=shift;
print "SeqQual process with diploidraw_ab1 routine.\n\n";
print "Alignment with Phrap and Polyphred.\n";
print "Phrap parameters:\n";
print "Default_qual=$phrap1\n";
print "Trim_start=$phrap2\n";
print "Force_level=$phrap3\n";
print "Bybass_level=$phrap4\n";
print "Maxgap=$phrap5\n";
print "Repeat_stringency=$phrap6\n";
print "Nodeseg=$phrap7\n";
print "Nodespace=$phrap8\n";
print "Qual_show=$phrap9\n";
print "Max_subclone_size=$phrap10\n";
print "Trim_score=$phrap11\n";
print "Trim_penalty=$phrap12\n";
print "Trim_qual=$phrap13\n";
print "Confirm_length=$phrap14\n";
print "Confirm_trim=$phrap15\n";
print "Confirm_penalty=$phrap16\n";
print "Confirm_score=$phrap17\n";
print "Indexwordsize=$phrap18\n";
