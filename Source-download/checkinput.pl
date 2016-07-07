#!/usr/bin/env perl

# This script is part of the SeqQual pipeline which automatically process chromatogram data and ace assemblies while integrating quality.
# Copyright 2010 Tiange Lang and Pauline Garnier-Géré, INRA
# Last updated 26-April-2010
# SeqQual is a free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program. If not, see <http://www.gnu.org/licenses/>.

@dirs=qx{ls -d *};
while(<>){
    chomp;
    next unless(/\S/);
    $warn=0;
    foreach $unit(@dirs){
	chomp $unit;
	if($_ eq $unit){$warn=1;}
    }
}
if ($war==0){print "One or more folders don't exist or are not spelled correctly. Please check your list. Note that the spelling is case-sensitive.\n"}




