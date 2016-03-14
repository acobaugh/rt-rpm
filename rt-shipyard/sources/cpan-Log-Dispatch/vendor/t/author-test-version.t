
BEGIN {
  unless ($ENV{AUTHOR_TESTING}) {
    require Test::More;
    Test::More::plan(skip_all => 'these tests are for testing by the author');
  }
}

use strict;
use warnings;
use Test::More;

# generated by Dist::Zilla::Plugin::Test::Version 1.05
use Test::Version;

my @imports = qw( version_ok );

my $params = {
    is_strict      => 0,
    has_version    => 1,
    multiple       => 0,

};

push @imports, $params
    if version->parse( $Test::Version::VERSION ) >= version->parse('1.002');


Test::Version->import(@imports);

version_ok('lib/Log/Dispatch.pm');
version_ok('lib/Log/Dispatch/ApacheLog.pm');
version_ok('lib/Log/Dispatch/Base.pm');
version_ok('lib/Log/Dispatch/Code.pm');
version_ok('lib/Log/Dispatch/Email.pm');
version_ok('lib/Log/Dispatch/Email/MIMELite.pm');
version_ok('lib/Log/Dispatch/Email/MailSend.pm');
version_ok('lib/Log/Dispatch/Email/MailSender.pm');
version_ok('lib/Log/Dispatch/Email/MailSendmail.pm');
version_ok('lib/Log/Dispatch/File.pm');
version_ok('lib/Log/Dispatch/File/Locked.pm');
version_ok('lib/Log/Dispatch/Handle.pm');
version_ok('lib/Log/Dispatch/Null.pm');
version_ok('lib/Log/Dispatch/Output.pm');
version_ok('lib/Log/Dispatch/Screen.pm');
version_ok('lib/Log/Dispatch/Syslog.pm');
version_ok('lib/Log/Dispatch/Vars.pm');
done_testing;