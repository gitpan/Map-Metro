use Map::Metro::Standard::Moops;

our $VERSION = '0.2200'; # VERSION
# PODNAME: Map::Metro::Exception::StationNameDoesNotExistInStationList

class Map::Metro::Exception::StationNameDoesNotExistInStationList with Map::Metro::Exception using Moose  {

    use Map::Metro::Exception -all;

    has station_name => (
        is => 'ro',
        isa => Any,
        traits => [Payload],
    );
    has info => (
        is => 'ro',
        isa => Str,
        lazy => 1,
        default => q{Station name [%{station_name}s] does not exist in station list (check segments or arguments)},
    );

}

__END__

=pod

=encoding UTF-8

=head1 NAME

Map::Metro::Exception::StationNameDoesNotExistInStationList

=head1 VERSION

Version 0.2200, released 2015-01-08.

=head1 SOURCE

L<https://github.com/Csson/p5-Map-Metro>

=head1 HOMEPAGE

L<https://metacpan.org/release/Map-Metro>

=head1 AUTHOR

Erik Carlsson <info@code301.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2015 by Erik Carlsson.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
