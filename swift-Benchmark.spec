Name:          swift-Benchmark
Version:       %{__version}
Release:       %{!?__release:1}%{?__release}%{?dist}
Summary:       Benchmark running times of Swift code

Group:         Development/Libraries
License:       MIT
URL:           https://github.com/my-mail-ru/%{name}
Source0:       https://github.com/my-mail-ru/%{name}/archive/%{version}.tar.gz#/%{name}-%{version}.tar.gz
BuildRoot:     %(mktemp -ud %{_tmppath}/%{name}-%{version}-%{release}-XXXXXX)

BuildRequires: swift
BuildRequires: swift-packaging

%swift_find_provides_and_requires

%description
The Benchmark library provides a number of functions to help you figure out
how long (both in terms of wallclock and CPU time) it takes to execute some code.

%{?__revision:Built from revision %{__revision}.}


%prep
%setup -q
%swift_patch_package


%build
%swift_build -Xlinker -lrt


%install
rm -rf %{buildroot}
%swift_install
%swift_install_devel


%clean
rm -rf %{buildroot}


%files
%defattr(-,root,root,-)
%{swift_libdir}/*.so
%{swift_moduledir}/*.swiftmodule
%{swift_moduledir}/*.swiftdoc
