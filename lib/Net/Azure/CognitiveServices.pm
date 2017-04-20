package Net::Azure::CognitiveServices;
use 5.008001;
use strict;
use warnings;
use Class::Load qw(is_class_loaded load_class);
use Class::Accessor::Lite (
    ro => [qw[access_key endpoint]],
    rw => [qw[instance]],
    new => 0
);

our $VERSION = "0.01";
our $BASEDOMAIN = 'api.cognitive.microsoft.com';
our $AUTOLOAD;

sub new {
    my ($class, %params) = @_;
    $params{endpoint} ||= sprintf('https://%s.%s', delete($params{region}), $BASEDOMAIN);
    $params{instance} = {};
    bless {%params}, $class;
}

sub AUTOLOAD {
    my $self = shift;
    my $api_class = $AUTOLOAD;
    if (!is_class_loaded($api_class)) {
        load_class($api_class);
    }
    $self->instance->{$api_class} ||= $api_class->new(
        access_key => $self->access_key, 
        endpoint => $self->endpoint
    );
    $self->instance->{$api_class};
}

1;
__END__

=encoding utf-8

=head1 NAME

Net::Azure::CognitiveServices - API Client Manager for Microsoft Azure Cognitive Services API

=head1 SYNOPSIS

    use Net::Azure::CognitiveServices;
    my $cognitive = Net::Azure::CognitiveServices->new(
        access_key => 'YOURSECRET',
        region     => 'westus',
    );
    my $faceapi   = $cognitive->Face;
    $faceapi->detect(...);

=head1 DESCRIPTION

Net::Azure::CognitiveServices is a client manager class for Azure Cognitive Services API.

=head1 LICENSE

Copyright (C) ytnobody.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

ytnobody E<lt>ytnobody@gmail.comE<gt>

=cut

