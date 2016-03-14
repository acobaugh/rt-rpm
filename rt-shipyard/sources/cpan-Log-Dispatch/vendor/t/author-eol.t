
BEGIN {
  unless ($ENV{AUTHOR_TESTING}) {
    require Test::More;
    Test::More::plan(skip_all => 'these tests are for testing by the author');
  }
}

use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::EOL 0.18

use Test::More 0.88;
use Test::EOL;

my @files = (
    'lib/Log/Dispatch.pm',
    'lib/Log/Dispatch/ApacheLog.pm',
    'lib/Log/Dispatch/Base.pm',
    'lib/Log/Dispatch/Code.pm',
    'lib/Log/Dispatch/Conflicts.pm',
    'lib/Log/Dispatch/Email.pm',
    'lib/Log/Dispatch/Email/MIMELite.pm',
    'lib/Log/Dispatch/Email/MailSend.pm',
    'lib/Log/Dispatch/Email/MailSender.pm',
    'lib/Log/Dispatch/Email/MailSendmail.pm',
    'lib/Log/Dispatch/File.pm',
    'lib/Log/Dispatch/File/Locked.pm',
    'lib/Log/Dispatch/Handle.pm',
    'lib/Log/Dispatch/Null.pm',
    'lib/Log/Dispatch/Output.pm',
    'lib/Log/Dispatch/Screen.pm',
    'lib/Log/Dispatch/Syslog.pm',
    'lib/Log/Dispatch/Vars.pm',
    't/00-compile.t',
    't/00-report-prereqs.dd',
    't/00-report-prereqs.t',
    't/author-eol.t',
    't/author-mojibake.t',
    't/author-no-tabs.t',
    't/author-pod-spell.t',
    't/author-pod-syntax.t',
    't/author-test-dependents.t',
    't/author-test-version.t',
    't/basic.t',
    't/binmode.t',
    't/close-after-write.t',
    't/email-exit-helper.pl',
    't/email-exit.t',
    't/file-locked.t',
    't/lib/Log/Dispatch/TestUtil.pm',
    't/release-cpan-changes.t',
    't/release-pod-coverage.t',
    't/release-portability.t',
    't/release-tidyall.t',
    't/screen-helper.pl',
    't/screen.t',
    't/sendmail',
    't/short-syntax.t',
    't/syslog-lock-without-preloaded-threads.t',
    't/syslog-threads.t',
    't/syslog.t'
);

eol_unix_ok($_, { trailing_whitespace => 1 }) foreach @files;
done_testing;
