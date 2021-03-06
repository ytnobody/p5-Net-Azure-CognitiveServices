package Net::Azure::CognitiveServices::Base::Feature;
use strict;
use warnings;
use Class::Accessor::Lite (
    new => 1,
    ro  => [qw[access_key endpoint]],
);
use LWP::UserAgent;
use JSON;
use Carp;
use URI;
use HTTP::Request;

sub path {''};

sub uri {
    my ($self, $path, %query) = @_;
    my $uri = URI->new($self->endpoint);
    $uri->path($path ? join('/', $self->path, $path) : $self->path);
    if (keys %query) {
        $uri->query_form(%query);
    }
    $uri;
}

sub json {
    my $self = shift;
    $self->{json} ||= JSON->new->utf8(1);
    $self->{json};
}

sub agent {
    my $self = shift;
    $self->{agent} ||= LWP::UserAgent->new(agent => __PACKAGE__, timeout => 60);
    $self->{agent};
}

sub request {
    my ($self, $req) = @_;
    my $res;
    my $try = 0;
    while (1) {
        $res = $self->agent->request($req);
        $try++;
        if ($try > 10 || $res->code != 429) {
            last;
        }
        carp sprintf('Retry. Because API said %s', $res->content);
    }
    my $body;
    if ($res->content) {
        if ($res->content_type !~ /application\/json/) {
            $body = $res->content; 
        }
        $body = $self->json->decode($res->content);
    }
    if (!$res->is_success) {
        croak($body->{error}{message} ? $body->{error}{message} : $body->{message});
    }
    wantarray ? ($body, $res->headers) : $body;
}

sub build_headers {
    my ($self, @headers) = @_;
    (
        "Content-Type"              => "application/json", 
        "Ocp-Apim-Subscription-Key" => $self->access_key,
        @headers, 
    );
}

sub build_request {
    my ($self, $method, $uri_param, $header, $hash) = @_;
    my $uri  = $self->uri(@$uri_param);
    my $body = $hash ? $self->json->encode($hash) : undef;
    my @headers = $self->build_headers(defined $header ? @$header : ());
    HTTP::Request->new($method => $uri, [@headers], $body);
}

1;

__END__

=encoding utf-8

=head1 NAME

Net::Azure::CognitiveServices::Feature - Base class of Cognitive Services Features

=head1 DESCRIPTION

This is a base class for writting wrapper classes of Face APIs more easy. 

=head1 ATTRIBUTES

=head2 access_key

The access key for accessing to Azure Cognitive Services APIs

=head2 endpoint

Endpoint URL string

=head1 METHODS

=head2 path

An interface that returns the endpoint path string.

    my $path_string = $obj->path;

=head2 uri

Build an URI object.

    my $uri = $obj->uri('/base/uri', name => 'foobar', page => 3); ## => '/base/uri?name=foobar&page=3'

=head2 json

Returns a JSON.pm object.

    my $hash = $obj->json->decode('{"name":"foobar","page":3}'); ## => {name => "foobar", page => 3}

=head2 agent

Returns a LWP::UserAgent object.

    my $res = $obj->agent->get('http://example.com');

=head2 request

Send a http request, and returns a json content as a hashref.

    my $req  = HTTP::Request->new(...);
    my $hash = $obj->request($req);

=head2 build_headers

Build and returns http headers with authorization header.

    my @headers = $obj->build_headers('Content-Length' => 60);

=head2 build_request

Build and returns a HTTP::Request object.

    ### arguments
    my $path      = '/foo/bar';
    my %param     = (page => 2, name => 'hoge');
    my @headers   = ("X-HTTP-Foobar" => 123);
    my $json_data = {url => 'http://example.com'};
    ### build request object
    my $req = $obj->build_request([$path, %param], [@headers], $json_data);

=head1 LICENSE

Copyright (C) ytnobody.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

ytnobody E<lt>ytnobody@gmail.comE<gt>

=cut