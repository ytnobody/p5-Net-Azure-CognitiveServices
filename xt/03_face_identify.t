use strict;
use warnings;
use Test::More;
use Net::Azure::CognitiveServices;

### instantiate cognitive service
my $cognitive = Net::Azure::CognitiveServices->new(
    region     => $ENV{region},
    access_key => $ENV{access_key_face},
);
my $api = $cognitive->Face;

### Source data of Japanese popular persons
my %image = (
    'Yo Ooizumi'        => 'http://s3-ap-northeast-1.amazonaws.com/topicks/article_thumb/15584_original.jpg',
    'Takayuki Suzui'    => 'https://www.office-cue.com/image/portrait/xl_talent01.jpg',
    'Ken Yasuda'        => 'http://yononakanews.com/wp-content/uploads/2014/10/3658-1.jpg',
    'Takuma Otoo'       => 'http://image.pia.jp/images/news/img/ORG_20111128001518.jpg',
    'Hiroyuki Morisaki' => 'http://www.suruga-ya.jp/database/pics/game/g6235130.jpg',
);

### Definition of PersonGroup ID
my $person_group_id = 'dummy';

### Create a PersonGroup
$api->PersonGroup->create($person_group_id, name => 'Super Star');

### Register persons to Face API
for my $name (keys %image) {
    sleep 1; ## Care for Request Rate Limit
    my $person = $api->Person->create($person_group_id, name => $name);
    $api->Person->add_face($person_group_id, $person->{personId}, $image{$name});
}

### Train a PersonGroup
$api->PersonGroup->train($person_group_id);

### Wait a moment to finish training...
for (1 .. 12) {
    sleep 1;
    my $status = $api->PersonGroup->training_status($person_group_id);
    last if $status->{status} eq "succeeded";
}

### Detect a face image of "Yo Ooizumi", and fetch it's faceId.  
my $face = $api->Face->detect('http://www.officiallyjd.com/wp-content/uploads/2012/02/20120227_akb_13.jpg');

### Identify the face image from PersonGroup by faceId
my $ident = $api->Face->identify(
    faceIds                    => [ $face->[0]{faceId} ],
    personGroupId              => $person_group_id,
    maxNumOfCandidatesReturned => 1,
    confidenceThreshold        => 0.5,
);

### Fetch a candidated data
my $candidate = $ident->[0]{candidates}[0];


### Get a person data by candidated personId
my $hit = $api->Person->get($person_group_id, $candidate->{personId});

### output a person data
isa_ok $hit, 'HASH';
is $hit->{name}, 'Yo Ooizumi', "detected person is 'Yo Ooizumi'";

### Remove a PersonGroup when finished each tasks
$api->PersonGroup->delete($person_group_id);

done_testing;