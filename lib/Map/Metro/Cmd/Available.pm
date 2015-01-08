use Map::Metro::Standard::Moops;

our $VERSION = '0.2200'; # VERSION
# PODNAME: Map::Metro::Cmd::Available

class Map::Metro::Cmd::Available extends Map::Metro::Cmd using Moose {

    use MooseX::App::Command;

    command_short_description 'Display installed maps';

    method run {
        my $map = Map::Metro->new;

        say "The following maps are available:\n";
        say join "\n" => map { s{^Map::Metro::Plugin::Map::}{ }; $_ } grep { !/^Map::Metro::Plugin::Map$/ } $map->available_maps;
    }
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Map::Metro::Cmd::Available

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
