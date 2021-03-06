use strict;
use warnings;
use Test::More;
use Net::Azure::CognitiveServices;

my $cognitive = Net::Azure::CognitiveServices->new(region => 'westus', access_key => 'MYSECRET');
my $face = $cognitive->Face->Face;
isa_ok $face, 'Net::Azure::CognitiveServices::Face::Face';
can_ok $face, qw/_verify_request/;

my $req = $face->_verify_request(
    faceId1 => "foo",
    faceId2 => "bar", 
);

isa_ok $req, 'HTTP::Request';
is $req->uri, 'https://westus.api.cognitive.microsoft.com/face/v1.0/verify';
is $req->method, 'POST';
is $req->header('Content-Type'), 'application/json';
is $req->header('Ocp-Apim-Subscription-Key'), 'MYSECRET';
like $req->content, qr|"faceId1":"foo"|;
like $req->content, qr|"faceId2":"bar"|;

done_testing;