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
        libemail-simple-perl \
        libemail-sender-perl \
        libfinance-quotehist-perl \
        libdatetime-format-rfc3339-perl \
        ssmtp \
        && rm -rf /var/lib/apt/lists/*


RUN sed -ri -e 's/^(mailhub=).*/\1smtp/' \
    -e 's/^#(FromLineOverride)/\1/' /etc/ssmtp/ssmtp.conf

## Finance::FXCM::Simple dependency
ENV FXCONNECT_HOME /root/ForexConnectAPI-1.3.2-Linux-x86_64
WORKDIR /root
RUN curl -L http://fxcodebase.com/bin/forexconnect/1.3.2/ForexConnectAPI-1.3.2-Linux-x86_64.tar.gz | tar zxf - -C /root
RUN curl -L http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz | tar zxf - -C /root

COPY . Finance-HostedTrader

WORKDIR /root/Finance-HostedTrader

ENV PATH="/src/Finance-HostedTrader/bin:/root/Finance-HostedTrader/bin:${PATH}"
ENV PERL5LIB="/src/Finance-HostedTrader/lib:/root/Finance-HostedTrader/lib:${PERL5LIB}"
ENV LD_LIBRARY_PATH="/usr/local/lib:${FXCONNECT_HOME}/lib"

WORKDIR /root/ta-lib
RUN ./configure && make install

# librest-client-perl doesn't seem to be available in ubuntu ? install via cpanm
RUN TALIB_CFLAGS='-I/usr/local/include/ta-lib' TALIB_LIBS='-L/usr/local/lib -lta_lib' cpanm --notest Finance::FXCM::Simple Finance::TA

WORKDIR /root
