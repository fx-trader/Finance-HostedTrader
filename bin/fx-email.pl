#!/usr/bin/perl

# ABSTRACT: Send email alerts
# PODNAME: fx-email.pl

use Getopt::Long;
use Pod::Usage;
use Email::Simple;
use Email::Simple::Creator;
use Email::Sender::Simple qw(sendmail);


my ($help, $subject);

GetOptions(
    "subject=s",    \$subject,
    "help",         \$help,
) || pod2usage(1);

pod2usage(1) if ( $help || !$subject );

my $message_body = my $str = do { local $/; <STDIN> };

zap( { subject => $subject, message => $message_body } );

sub zap {
    my $obj = shift;

    my $email = Email::Simple->create(
        header => [
            From => 'FX Robot <robot@fxhistoricaldata.com>',
            To => 'joaocosta@zonalivre.org',
            Subject => "FXAPI: " . $obj->{subject},
        ],
        body => $obj->{message},
    );
    sendmail($email);
}

__END__

=pod

=encoding UTF-8

=head1 NAME

    fx-email.pl

=head1 SYNOPSIS

    echo "Hello World" | fx-email.pl --subject "Test email"

=head2 OPTIONS

=over

=item C<--subject>

The subject of the email to send.

=back

=cut

=cut
