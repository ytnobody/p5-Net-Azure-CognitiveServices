package Net::Azure::CognitiveServices::Base::API;
use 5.008001;
use strict;
use warnings;
use Class::Load qw(is_class_loaded load_class);
use Class::Accessor::Lite (
    ro => [qw[access_key endpoint]],
    rw => [qw[instance]],
    new => 0
);

our $VERSION  = "0.01";
our $AUTOLOAD;

sub new {
    my ($class, %params) = @_;
    $params{instance} = {};
    bless {%params}, $class;
}

sub AUTOLOAD {
    my $self = shift;
    my $feature_class = $AUTOLOAD;
    if (!is_class_loaded($feature_class)) {
        load_class($feature_class);
    }
    $self->instance->{$feature_class} ||= $feature_class->new(access_key => $self->access_key, endpoint => $self->endpoint);
    $self->instance->{$feature_class}; 
}

1;
__END__

=encoding utf-8

=head1 NAME

Net::Azure::CognitiveServices::Base::API - A base wrapper class for API of Azure Cognitive Services

=head1 SYNOPSIS

    package Net::Azure::CognitiveServices::Face;
    use parent 'Net::Azure::CognitiveServices::Base::API';


=head1 DESCRIPTION

Net::Azure::CognitiveServices::Base::API is a base class for API class.

=head1 LICENSE

Copyright (C) ytnobody.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

ytnobody E<lt>ytnobody@gmail.comE<gt>

=cut

