use feature ':5.20';
use Moops;

our $VERSION = '0.2200'; # VERSION
# PODNAME: Map::Metro::Types

library  Map::Metro::Types

extends  Types::Standard,
         Types::Path::Tiny

declares Connection,
         Line,
         LineStation,
         Route,
         Routing,
         Segment,
         Station,
         Step,
         Transfer
    {

    class_type Connection   => { class => 'Map::Metro::Graph::Connection' };
    class_type Line         => { class => 'Map::Metro::Graph::Line' };
    class_type LineStation  => { class => 'Map::Metro::Graph::LineStation' };
    class_type Route        => { class => 'Map::Metro::Graph::Route' };
    class_type Routing      => { class => 'Map::Metro::Graph::Routing' };
    class_type Segment      => { class => 'Map::Metro::Graph::Segment' };
    class_type Station      => { class => 'Map::Metro::Graph::Station' };
    class_type Step         => { class => 'Map::Metro::Graph::Step' };
    class_type Transfer     => { class => 'Map::Metro::Graph::Transfer' };
}

__END__

=pod

=encoding UTF-8

=head1 NAME

Map::Metro::Types

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
