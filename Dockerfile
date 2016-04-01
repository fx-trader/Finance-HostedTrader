FROM ubuntu
MAINTAINER Joao Costa <joaocosta@zonalivre.org>

RUN apt-get update && apt-get -y install \
        curl \
        make \
        gcc \
        g++ \
        libssl-dev \
        git \
        libmariadbclient-dev

## Finance::FXCM::Simple dependency
WORKDIR /root
RUN curl -L http://fxcodebase.com/bin/forexconnect/1.3.2/ForexConnectAPI-1.3.2-Linux-x86_64.tar.gz | tar zxf - -C /root
ENV FXCONNECT_HOME /root/ForexConnectAPI-1.3.2-Linux-x86_64

RUN curl -L https://cpanmin.us | perl - --notest App::cpanminus

RUN cpanm --notest  Cpanel::JSON::XS \
                    JSON::MaybeXS \
                    Try::Tiny \
                    YAML::XS \
                    Dist::Zilla \
                    Dist::Zilla::Plugin::PodWeaver \
                    Dist::Zilla::PluginBundle::Git \
                    Pod::Elemental::Transformer::List \
                    DBI \
                    DBIx::Class \
                    DBD::mysql \
                    DateTime::Format::Strptime \
                    Finance::FXCM::Simple

## Finance::HostedTrader
ADD . Finance-HostedTrader

WORKDIR /root/Finance-HostedTrader

RUN dzil authordeps | cpanm --notest
RUN mkdir /etc/fxtrader && cp etc/fxtrader/fx* /etc/fxtrader/
RUN dzil install

WORKDIR /root
