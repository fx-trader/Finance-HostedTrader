FROM ubuntu
MAINTAINER Joao Costa <joaocosta@zonalivre.org>

RUN apt-get update && apt-get -y install \
        curl \
        make \
        gcc \
        g++ \
        gdb \
        valgrind \
        git \
        libdatetime-format-strptime-perl \
        libdbd-mysql-perl \
        libyaml-libyaml-perl \
        libtry-tiny-perl \
        libjson-maybexs-perl \
        libcpanel-json-xs-perl \
        libmoosex-log-log4perl-perl \
        libmoo-perl \
        libdate-manip-perl \
        cpanminus \
        libconfig-any-perl \
        libparse-recdescent-perl \
        libredis-perl \
        libstatistics-descriptive-perl \
        libdevel-stacktrace-perl \
        liburi-query-perl \
        && rm -rf /var/lib/apt/lists/*

## Finance::FXCM::Simple dependency
ENV FXCONNECT_HOME /root/ForexConnectAPI-1.3.2-Linux-x86_64
WORKDIR /root
RUN curl -L http://fxcodebase.com/bin/forexconnect/1.3.2/ForexConnectAPI-1.3.2-Linux-x86_64.tar.gz | tar zxf - -C /root

# librest-client-perl doesn't seem to be available in ubuntu ? install via cpanm
RUN cpanm --notest Finance::FXCM::Simple REST::Client

ENV PATH="/src/Finance-HostedTrader/bin:${PATH}"
ENV PERL5LIB="/src/Finance-HostedTrader/lib:${PERL5LIB}"

RUN mkdir /etc/fxtrader && cp etc/fxtrader/fx* /etc/fxtrader/

WORKDIR /root
