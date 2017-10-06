use strict;
use warnings;
use Test::More;
use Net::Azure::CognitiveServices;
use JSON;

my $cognitive = Net::Azure::CognitiveServices->new(
    region     => $ENV{region},
    access_key => $ENV{access_key_cv},
);

my $cv = $cognitive->ComputerVision;
my $res = $cv->analyze_image(
    'https://pbs.twimg.com/media/C6O0Ej7VAAAQvBS.jpg', 
    visualFeatures => 'Categories,Description,Adult,Faces',
    detail         => 'Celebrities',
);

isa_ok $res, 'HASH';
is $res->{adult}{isAdultContent}, JSON::true, 'It is an adult content';
is $res->{description}{captions}[0]{text}, 'a woman wearing a costume', "caption text is 'a woman wearing a costume'";

done_testing;