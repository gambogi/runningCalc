#!/usr/bin/env perl

use strict;
use warnings; 
use v5.10;

sub getDistance {
    my ($time, $pace) = @_;
    my $dist = toSeconds($time)/toSeconds($pace);
    return sprintf("%.2f mi", $dist);
}

sub getPace {
    my ($time, $dist) = @_;
    my $pace = toSeconds($time)/$dist;
    return toTime($pace) . " min/mi";
}

sub getTime {
    my ($dist, $pace) = @_;
    my $time = $dist*toSeconds($pace);
    return toTime($time);
}

sub toSeconds {
        my $t = shift;
        if (isTime($t)){
            my @time = split(/:/, $t);
            my $secs = $time[0]*60+$time[1];
            return $secs;
        }
}

sub toTime {
    my $time = shift;
    return sprintf( "%d:%02d", int($time/60),($time/60 - int($time/60))*60);
}

sub isTime {
    my $t = shift;
    return ($t =~ /([0-9]|[0-9][0-9]):[0-5][0-9]/)
}

if (isTime($ARGV[0]) && isTime($ARGV[1])){
    say getDistance($ARGV[0], $ARGV[1]);
}
elsif (isTime($ARGV[0])){
    say getPace($ARGV[0], $ARGV[1]);
}
elsif (isTime($ARGV[1])){
    say getTime($ARGV[0], $ARGV[1]);
}
