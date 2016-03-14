%define install_base %{_tmppath}/%{name}-%{version}-%{release}-install-base

Name:		rt
Version:	4.4.0
Release:	1%{?dist}.atc
Summary:	A shipwright vessel for Request Tracker %{version} which installs into /opt/rt

Group:		Applications/Productivity
License:	GPLv2
URL:		http://bestpractical.com/rt/
Source0:	rt-shipyard.tar.gz
BuildRoot:	%(mktemp -ud %{_tmppath}/%{name}-%{version}-%{release}-XXXXXX)

BuildRequires:	gcc, make, gcc-c++
Requires:	glibc
AutoReqProv:	no

%description
This is a self-contained, relocatable distribution of Bestpractical's RT.
It currently installs into /opt/rt<version>

%prep
%setup -q -n rt-shipyard


%build
rm -rf %{install_base}
mkdir %{install_base}

rm -f __install_base
./bin/shipwright-builder --install-base %{install_base}

%install
mkdir -p %{buildroot}/opt/rt
rsync -av %{install_base}/ %{buildroot}/opt/rt

cp -Rp dists/RT/etc/upgrade %{buildroot}/opt/rt/etc

pushd %{buildroot}/opt/rt/as/Linux
ln -s ../../etc etc
ln -s ../../var var
ln -s ../../share share

# fix the fontcache problem, where fc will create the cache directories
#  which then screws with the shipwright wrappers
sed -i 's/.*cachedir.*//' %{buildroot}/opt/rt/etc/fonts/fonts.conf

%clean
rm -rf %{buildroot}
rm -rf %{install_base}

%files
%defattr(-,root,root,-)
%config(noreplace) /opt/rt/etc/RT_SiteConfig.pm
%doc dists/RT/COPYING dists/RT/README dists/RT/docs/*
/opt/rt/as/
/opt/rt/__as
/opt/rt/bin
/opt/rt/docs
/opt/rt/include
/opt/rt/lib
/opt/rt/libexec
/opt/rt/Linux_installed.yml
/opt/rt/local
/opt/rt/man
/opt/rt/rt-tests
/opt/rt/sbin
/opt/rt/share
/opt/rt/tools
/opt/rt/var
/opt/rt/etc/acl.*
/opt/rt/etc/fonts
/opt/rt/etc/initialdata
/opt/rt/etc/RT_Config.pm
/opt/rt/etc/schema.*
/opt/rt/etc/shipwright-perl-wrapper
/opt/rt/etc/shipwright-script-wrapper
/opt/rt/etc/upgrade


%changelog
* Mon Mar 14 2016 Andy Cobaugh <andrewcobaugh@gmail.com> 4.4.0-1
- Refresh SPECfile, update the shipyard to RT 4.4.0 plus deps from upstream

* Mon Sep 21 2015 Andy Cobaugh <atc135@psu.edu> 4.0.13-4
- Patch for CVE-2015-1464 and CVE-2014-9472

* Thu Apr 24 2014 Andy Cobaugh <atc135@psu.edu> 4.0.13-3
- Just install into /opt/rt without the version in the directory,
  this will simplify things greatly

* Wed Apr 23 2014 Andy Cobaugh <atc135@psu.edu> 4.0.13-2
- Bump shipyard release to 2, which adds Net::LDAP and Unix::Syslog

* Sun Feb 25 2013 Andy Cobaugh <atc135@psu.edu> 4.0.10-1
- Upgrade cpan:HTML:RewriteAttributes
- Bump version to 4.0.10

* Sat Jul 28 2012 Andy Cobaugh <atc135@psu.edu> 4.0.6-3
- Import cpan:GraphViz and its perl module dependencies

* Sat Jul 28 2012 Andy Cobaugh <atc135@psu.edu> 4.0.6-2
- Updated cpan-HTML-Format in shipyard to fix UNIVERSAL->import warning
- Define rtrelease so we can have different shipyard versions that correspond
  to package Release tag

* Fri Jul 27 2012 Andy Cobaugh <atc135@psu.edu> 4.0.6-1
- Initial build
