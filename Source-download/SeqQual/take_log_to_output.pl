#!/usr/bin/env perl


@months = qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);
@weekDays = qw(Sun Mon Tue Wed Thu Fri Sat Sun);
($second, $minute, $hour, $dayOfMonth, $month, $yearOffset, $dayOfWeek, $dayOfYear, $daylightSavings) = localtime();
$year = 1900 + $yearOffset;
$theTime = "$year-$months[$month]-$dayOfMonth-$weekDays[$dayOfWeek]-$hour:$minute:$second";
$name="log_".$theTime.".txt";

system ("mv log.txt Output/");
system ("mv Output/log.txt Output/$name");
    
