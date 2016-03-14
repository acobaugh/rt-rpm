use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::NoTabs 0.13

use Test::More 0.88;
use Test::NoTabs;

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
    't/version.t',
    'xt/author/00-compile.t',
    'xt/author/compat_lc.t',
    'xt/author/eol.t',
    'xt/author/no-tabs.t',
    'xt/release/changes_has_content.t',
    'xt/release/cpan-changes.t',
    'xt/release/distmeta.t',
    'xt/release/kwalitee.t',
    'xt/release/minimum-version.t',
    'xt/release/mojibake.t',
    'xt/release/pod-coverage.t',
    'xt/release/pod-no404s.t',
    'xt/release/pod-syntax.t',
    'xt/release/portability.t'
);

notabs_ok($_) foreach @files;
done_testing;
