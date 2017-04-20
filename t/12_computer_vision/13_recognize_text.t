use strict;
use warnings;
use Test::More;
use Net::Azure::CognitiveServices;

my $cognitive = Net::Azure::CognitiveServices->new(region => 'westus', access_key => 'MYSECRET');
my $cv = $cognitive->ComputerVision;
isa_ok $cv, 'Net::Azure::CognitiveServices::ComputerVision';
can_ok $cv, qw/_recognize_text_request/;

my $img = 'http://example.com/hoge.jpg';
my $req = $cv->_recognize_text_request($img, handwriting => "true");
isa_ok $req, 'HTTP::Request';
like $req->uri, qr|^https://westus.api.cognitive.microsoft.com/vision/v1.0/recognizeText|;
like $req->uri, qr|handwriting=true|;
is $req->method, 'POST';
is $req->header('Content-Type'), 'application/json';
is $req->header('Ocp-Apim-Subscription-Key'), 'MYSECRET';
is $req->content, '{"url":"http://example.com/hoge.jpg"}';

done_testing;