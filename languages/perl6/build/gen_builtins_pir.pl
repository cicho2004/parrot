#!/usr/bin/perl
# Copyright (C) 2008, The Perl Foundation.
# $Id: gen_junction_pir.pl 32768 2008-11-17 16:19:41Z infinoid $

use strict;
use warnings;

my @files = @ARGV;

print <<"END_PRELUDE";
# This file automatically generated by $0.

END_PRELUDE

foreach my $file (@files) {
    print ".include '$file'\n";
}

