use Map::Metro::Standard::Moops;

our $VERSION = '0.2200'; # VERSION
# PODNAME: Map::Metro::Exception::LineIdContainsIllegalCharacter

class Map::Metro::Exception::LineIdContainsIllegalCharacter with Map::Metro::Exception using Moose {

    use Map::Metro::Exception -all;

    has line_id => (
        is => 'ro',
        isa => Str,
        traits => [Payload],
    );
    has illegal_character => (
        is => 'ro',
        isa => Any,
        traits => [Payload],
    );
    has info => (
        is => 'ro',
        isa => Str,
        lazy => 1,
        default => q{Line id [%{line_id}s] contains illegal character [%{illegal_character}s]},
    );
}

__END__

=pod

=encoding UTF-8

=head1 NAME

Map::Metro::Exception::LineIdContainsIllegalCharacter

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
