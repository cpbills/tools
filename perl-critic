#!/usr/bin/perl

use strict;
use warnings;
use Perl::Critic;

my $file = $ARGV[0];
my $critic = Perl::Critic->new();
my @violations = $critic->critique($file);
print @violations;
