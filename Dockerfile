FROM ubuntu
MAINTAINER Joao Costa <joaocosta@zonalivre.org>

RUN apt-get update && apt-get -y install \
        curl \
        make \
        gcc \
        g++ \
        gdb \
        valgrind \
        libssl-dev \
        git \
        libmysqlclient-dev \
        && rm -rf /var/lib/apt/lists/*

## Finance::FXCM::Simple dependency
ENV FXCONNECT_HOME /root/ForexConnectAPI-1.3.2-Linux-x86_64
WORKDIR /root
RUN curl -L http://fxcodebase.com/bin/forexconnect/1.3.2/ForexConnectAPI-1.3.2-Linux-x86_64.tar.gz | tar zxf - -C /root

RUN curl -L https://cpanmin.us | perl - --notest App::cpanminus

RUN cpanm --notest  Cpanel::JSON::XS \
                    JSON::MaybeXS \
                    Try::Tiny \
                    YAML::XS \
                    DBI \
                    DBD::mysql \
                    DateTime::Format::Strptime \
                    Finance::FXCM::Simple

## Finance::HostedTrader
COPY . Finance-HostedTrader

WORKDIR /root/Finance-HostedTrader

ENV PATH="/root/Finance-HostedTrader/bin:${PATH}"
ENV PERL5LIB="/root/Finance-HostedTrader/lib:${PERL5LIB}"

RUN mkdir /etc/fxtrader && cp etc/fxtrader/fx* /etc/fxtrader/

WORKDIR /root
