use strict;
use warnings;
use Net::Azure::CognitiveServices;
use Data::Dumper;

my $cognitive = Net::Azure::CognitiveServices->new(
    region     => $ARGV[0],
    access_key => $ARGV[1],
);

my $cv = $cognitive->ComputerVision;
my $operation_id = $cv->recognize_text(
    'http://www.scottedelman.com/wordpress/wp-content/uploads/2011/03/PaulLevitzReject1.jpg', 
    handwritten => 'true'
);
my $data = $cv->poll_text_operation($operation_id);
my @lines = $cv->extract_handwritten_texts($data);
warn Dumper(@lines);