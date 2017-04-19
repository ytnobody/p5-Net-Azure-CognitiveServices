use strict;
use warnings;
use Test::More;
use Net::Azure::CognitiveServices;

my $cognitive = Net::Azure::CognitiveServices->new(access_key => 'MYSECRET');
my $pg = $cognitive->Face->PersonGroup;
isa_ok $pg, 'Net::Azure::CognitiveServices::Face::PersonGroup';
can_ok $pg, qw/_delete_request/;

my $req = $pg->_delete_request("machida_pm");

isa_ok $req, 'HTTP::Request';
is $req->uri, "https://westus.api.cognitive.microsoft.com/face/v1.0/persongroups/machida_pm";
is $req->method, 'DELETE';
is $req->header('Content-Type'), 'application/json';
is $req->header('Ocp-Apim-Subscription-Key'), 'MYSECRET';

done_testing;