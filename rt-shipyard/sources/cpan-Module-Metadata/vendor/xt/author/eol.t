use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::EOL 0.17

use Test::More 0.88;
use Test::EOL;

my @files = (
    'lib/Module/Metadata.pm',
    't/00-report-prereqs.dd',
    't/00-report-prereqs.t',
    't/contains_pod.t',
    't/encoding.t',
    't/endpod.t',
    't/lib/0_1/Foo.pm',
    't/lib/0_2/Foo.pm',
    't/lib/ENDPOD.pm',
    't/metadata.t',
    't/taint.t',
    't/version.t'
);

eol_unix_ok($_, { trailing_whitespace => 1 }) foreach @files;
done_testing;
