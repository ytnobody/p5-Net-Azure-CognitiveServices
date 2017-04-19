# NAME

Net::Azure::CognitiveServices - API Client Manager for Microsoft Azure Cognitive Services API

# SYNOPSIS

    use Net::Azure::CognitiveServices;
    my $cognitive = Net::Azure::CognitiveServices->new(access_key => 'YOURSECRET');
    my $faceapi   = $cognitive->Face;
    $faceapi->detect(...);

# DESCRIPTION

Net::Azure::CognitiveServices is a client manager class for Azure Cognitive Services API.

# LICENSE

Copyright (C) ytnobody.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

ytnobody <ytnobody@gmail.com>
