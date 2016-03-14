package Regexp::IPv6;

our $VERSION = '0.03';

use strict;
use warnings;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw($IPv6_re);

my $IPv4 = "((25[0-5]|2[0-4][0-9]|[0-1]?[0-9]{1,2})[.](25[0-5]|2[0-4][0-9]|[0-1]?[0-9]{1,2})[.](25[0-5]|2[0-4][0-9]|[0-1]?[0-9]{1,2})[.](25[0-5]|2[0-4][0-9]|[0-1]?[0-9]{1,2}))";
my $G = "[0-9a-fA-F]{1,4}";

my @tail = ( ":",
	     "(:($G)?|$IPv4)",
             ":($IPv4|$G(:$G)?|)",
             "(:$IPv4|:$G(:$IPv4|(:$G){0,2})|:)",
	     "((:$G){0,2}(:$IPv4|(:$G){1,2})|:)",
	     "((:$G){0,3}(:$IPv4|(:$G){1,2})|:)",
	     "((:$G){0,4}(:$IPv4|(:$G){1,2})|:)" );

our $IPv6_re = $G;
$IPv6_re = "$G:($IPv6_re|$_)" for @tail;
$IPv6_re = qq/:(:$G){0,5}((:$G){1,2}|:$IPv4)|$IPv6_re/;
$IPv6_re =~ s/\(/(?:/g;
$IPv6_re = qr/$IPv6_re/;

1;
__END__

=head1 NAME

Regexp::IPv6 - Regular expression for IPv6 addresses

=head1 SYNOPSIS

  use Regexp::IPv6 qw($IPv6_re);

  $address =~ /^$IPv6_re$/ and print "IPv6 address\n";

=head1 DESCRIPTION

This module exports the $IPv6_re regular expression that matches any
valid IPv6 address as described in "RFC 2373 - 2.2 Text Representation
of Addresses" but C<::>. Any string not compliant with such RFC will
be rejected.

To match full strings use C</^$IPv6_re$/>.

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009, 2010 by Salvador FandiE<ntilde>o
(sfandino@yahoo.com)

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.0 or,
at your option, any later version of Perl 5 you may have available.

Additionally, you are allowed to use the regexp generated by the
module in any way you want, without any restriction. For instance, you
are allowed to copy it verbating in your program.

=cut