use Map::Metro::Standard::Moops;

our $VERSION = '0.2200'; # VERSION
# PODNAME: Map::Metro::Cmd::Route

class Map::Metro::Cmd::Route extends Map::Metro::Cmd using Moose {

    use MooseX::App::Command;

    parameter cityname => (
        is => 'rw',
        isa => Str,
        documentation => 'The name of the city you want to search in',
        required => 1,
    );
    parameter origin => (
        is => 'rw',
        isa => Str,
        documentation => 'Start station',
        required => 1,
    );
    parameter destination => (
        is => 'rw',
        isa => Str,
        documentation => 'Final station',
        required => 1,
    );

    command_short_description 'Search in a map';

    method run {

        my %hooks = (hooks => ['PrettyPrinter']);
        my $graph = $self->cityname !~ m{\.} ? Map::Metro->new($self->cityname, %hooks)->parse : Map::Metro::Shim->new($self->cityname, %hooks)->parse;

        try {
            $graph->routing_for($self->origin,  $self->destination);
        }
        catch {
            my $error = $_;
            say sprintf q{Try search by station id. Run '%s stations %s' to see station ids.}, $0, $self->cityname;
            $error->does('Map::Metro::Exception') ? $error->out->fatal : die $error;
        };
    }
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Map::Metro::Cmd::Route

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
