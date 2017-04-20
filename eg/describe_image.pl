use strict;
use warnings;
use Net::Azure::CognitiveServices;
use Data::Dumper;

my $cognitive = Net::Azure::CognitiveServices->new(
    region     => $ARGV[0],
    access_key => $ARGV[1],
);

my $cv = $cognitive->ComputerVision;
warn Dumper($cv->describe_image(
    'https://pbs.twimg.com/media/C6O0Ej7VAAAQvBS.jpg', 
    maxCandidate => 3,
));