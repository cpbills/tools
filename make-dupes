#!/usr/bin/perl

use warnings;
use strict;
use File::Copy;

my $count = get('how many dupes');
my $prefix = get('prefix');

opendir(DIR,'.');
my @files = grep { !/^\.\.?$/ } readdir(DIR);
closedir DIR;


for my $i (1 .. $count) {
    my $dupe = $files[rand($#files)];
    my ($ext) = $dupe =~ /\.([^.]+)$/;
    $ext = lc($ext);
    my $new = sprintf("%s-%05g.%s",$prefix,$i,$ext);
    copy($dupe,$new);
}


sub get {
    my $prompt = shift;
    print "$prompt: ";
    my $input = <STDIN>;
    chomp($input);
    return ($input);
}
