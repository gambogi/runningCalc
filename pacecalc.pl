#!/usr/bin/env perl

use strict;
use warnings; 
use v5.10;

sub get_distance {
    my ($time, $pace) = @_;
    my $dist = to_seconds($time)/to_seconds($pace);
    return sprintf("%.2f mi", $dist);
}

sub get_pace {
    my ($time, $dist) = @_;
    my $pace = to_seconds($time)/$dist;
    return to_time($pace) . " min/mi";
}

sub get_time {
    my ($dist, $pace) = @_;
    my $time = $dist*to_seconds($pace);
    return toTime($time);
}

sub to_seconds {
    my $t = shift;
        if (is_time($t)){
            my @time = split(/:/, $t);
            my $secs = $time[0]*60+$time[1];
            return $secs;
        }
}

sub usage {
    say('Useage\n' .
        'pacecalc {MM:SS | distance} {MM:SS | distance}');       
}

sub to_time {
    my $time = shift;
    return sprintf( "%d:%02d", int($time/60),($time/60 - int($time/60))*60);
}

sub is_time {
    my $t = shift;
    return ($t =~ /(?:[0-9]|[0-9][0-9]):[0-5][0-9]/)
}

if (@ARGV == 0){
    usage();
}
elsif (is_time($ARGV[0]) and is_time($ARGV[1])){
    say get_distance($ARGV[0], $ARGV[1]);
}
elsif (is_time($ARGV[0])){
    say get_pace($ARGV[0], $ARGV[1]);
}
elsif (is_time($ARGV[1])){
    say get_time($ARGV[0], $ARGV[1]);
}
else{
    usage();
}
