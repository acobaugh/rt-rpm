package DateTime::Helpers;

use strict;
use warnings;

our $VERSION = '1.25';

use Scalar::Util ();

sub can {
    my $object = shift;
    my $method = shift;

    return unless Scalar::Util::blessed($object);
    return $object->can($method);
}

sub isa {
    my $object = shift;
    my $method = shift;

    return unless Scalar::Util::blessed($object);
    return $object->isa($method);
}

1;
