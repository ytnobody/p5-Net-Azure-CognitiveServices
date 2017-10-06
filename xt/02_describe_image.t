use strict;
use warnings;
use Test::More;
use Net::Azure::CognitiveServices;

my $cognitive = Net::Azure::CognitiveServices->new(
    region     => $ENV{region},
    access_key => $ENV{access_key_cv},
);

my $cv = $cognitive->ComputerVision;
my $res = $cv->describe_image(
    'https://pbs.twimg.com/media/C6O0Ej7VAAAQvBS.jpg', 
    maxCandidate => 3,
);

isa_ok $res, 'HASH';
is $res->{description}{captions}[0]{text}, 'a woman wearing a costume', "caption text is 'a woman wearing a costume'";
done_testing;