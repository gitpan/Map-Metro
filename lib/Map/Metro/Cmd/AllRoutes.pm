use Map::Metro::Standard::Moops;

our $VERSION = '0.2200'; # VERSION
# PODNAME: Map::Metro::Cmd::AllRoutes

class Map::Metro::Cmd::AllRoutes extends Map::Metro::Cmd using Moose {

    use MooseX::App::Command;
    use experimental 'postderef';

    parameter cityname => (
        is => 'rw',
        isa => Str,
        documentation => 'The name of the city',
        required => 1,
    );

    command_short_description 'Display routes for *all* pairs of stations (slow)';

    method run {
        my %hooks = (hooks => ['PrettyPrinter']);
        my $graph = $self->cityname !~ m{\.} ? Map::Metro->new($self->cityname, %hooks)->parse : Map::Metro::Shim->new($self->cityname, %hooks)->parse;
        my $all = $graph->all_pairs;

    }
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Map::Metro::Cmd::AllRoutes

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
