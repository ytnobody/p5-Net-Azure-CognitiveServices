use strict;
use warnings;
use Test::More;
use Net::Azure::CognitiveServices;

my $cognitive = Net::Azure::CognitiveServices->new(region => 'westus', access_key => 'MYSECRET');
my $cv = $cognitive->ComputerVision;
isa_ok $cv, 'Net::Azure::CognitiveServices::ComputerVision';
can_ok $cv, qw/_describe_image_request/;

my $img = 'http://example.com/hoge.jpg';
my $req = $cv->_describe_image_request($img, maxCandidates => 3);
isa_ok $req, 'HTTP::Request';
like $req->uri, qr|^https://westus.api.cognitive.microsoft.com/vision/v1.0/describe|;
like $req->uri, qr|maxCandidates=3|;
is $req->method, 'POST';
is $req->header('Content-Type'), 'application/json';
is $req->header('Ocp-Apim-Subscription-Key'), 'MYSECRET';
is $req->content, '{"url":"http://example.com/hoge.jpg"}';

done_testing;