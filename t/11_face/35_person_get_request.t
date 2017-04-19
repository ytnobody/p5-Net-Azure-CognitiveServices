use strict;
use warnings;
use Test::More;
use Net::Azure::CognitiveServices;

my $cognitive = Net::Azure::CognitiveServices->new(access_key => 'MYSECRET');
my $person = $cognitive->Face->Person;
isa_ok $person, 'Net::Azure::CognitiveServices::Face::Person';
can_ok $person, qw/_get_request/;

my $req = $person->_get_request("machida_pm", 'ytnobody');

isa_ok $req, 'HTTP::Request';
is $req->uri, "https://westus.api.cognitive.microsoft.com/face/v1.0/persongroups/machida_pm/persons/ytnobody";
is $req->method, 'GET';
is $req->header('Content-Type'), 'application/json';
is $req->header('Ocp-Apim-Subscription-Key'), 'MYSECRET';

done_testing;