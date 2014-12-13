use 5.20.0;
use Map::Metro::Standard;

package Map::Metro {
$Map::Metro::VERSION = '0.1800';
use Moose;
    use Module::Pluggable search_path => ['Map::Metro::Plugin::Map'], require => 1, sub_name => 'system_maps';
    use MooseX::AttributeShortcuts;
    use aliased 'Map::Metro::Exception::IllegalConstructorArguments';
    use Types::Standard -types;
    use Types::Path::Tiny -types;
    use List::AllUtils 'any';
    use experimental qw/postderef signatures/;

    use Map::Metro::Graph;

    has map => (
        is => 'ro',
        traits => ['Array'],
        isa => ArrayRef,
        predicate => 1,
        handles => {
            get_map => 'get',
        },
    );
    has filepath => (
        is => 'rw',
        isa => Maybe[AbsFile],
        default => undef,
        init_arg => undef,
    );
    has hooks => (
        is => 'ro',
        isa => ArrayRef[ Str ],
        traits => ['Array'],
        default => sub { [] },
        handles => {
            all_hooks => 'elements',
        },
    );
    has _plugin_ns => (
        is => 'ro',
        isa => Str,
        default => 'Plugin::Map',
        init_arg => undef,
    );

    around BUILDARGS => sub {
        my ($orig, $class, @args) = @_;
        my %args;
        if(scalar @args == 1) {
            $args{'map'} = shift @args;
        }
        elsif(scalar @args % 2 != 0) {
            my $map = shift @args;
            %args = @args;
            $args{'map'} = $map;
        }
        else {
            %args = @args;
        }

        if(exists $args{'map'} && !ArrayRef->check($args{'map'})) {
            $args{'map'} = [$args{'map'}];
        }
        if(exists $args{'hooks'} && !ArrayRef->check($args{'hooks'})) {
            $args{'hooks'} = [$args{'hooks'}];
        }

        return $class->$orig(%args);
    };

    sub BUILD($self, @args) {

        if($self->has_map) {
            my @system_maps = map { s{^Map::Metro::Plugin::Map::}{}; $_ } $self->system_maps;

            if(any { $_ eq $self->get_map(0) } @system_maps) {
                my $mapclass = 'Map::Metro::Plugin::Map::'.$self->get_map(0);
                $self->filepath($mapclass->new->mapfile);
            }
        }
    }

    # Borrowed from Mojo::Util
    sub decamelize($self, $string) {
        return $string if $string !~ m{[A-Z]};
        return join '_' => map {
                                  join ('_' => map { lc } grep { length } split m{([A-Z]{1}[^A-Z]*)})
                               } split '::' => $string;
    }

    sub parse($self) {
        return Map::Metro::Graph->new(filepath => $self->filepath, wanted_hook_plugins => [$self->all_hooks])->parse;
    }

    sub available_maps($self) {
        return sort $self->_plugin_locator->plugins;
    }
}

__END__

=encoding utf-8

=head1 NAME

Map::Metro - Public transport graphing

=for html <p><a style="float: left;" href="https://travis-ci.org/Csson/p5-Map-Metro"><img src="https://travis-ci.org/Csson/p5-Map-Metro.svg?branch=master">&nbsp;</a>

=head1 SYNOPSIS

    # Install a map
    $ cpanm Map::Metro::Plugin::Map::Stockholm

    # And then
    my $graph = Map::Metro->new('Stockholm', hooks => ['PrettyPrinter'])->parse;

    my $routing = $graph->routes_for('Universitetet', 'Kista');

prints

    From Universitetet to Kista
    ===========================

    -- Route 1 (cost 15) ----------
    [   T14 ] Universitetet
    [   T14 ] Tekniska högskolan
    [   T14 ] Stadion
    [   T14 ] Östermalmstorg
    [   T14 ] T-Centralen
    [ * T11 ] T-Centralen
    [   T11 ] Rådhuset
    [   T11 ] Fridhemsplan
    [   T11 ] Stadshagen
    [   T11 ] Västra skogen
    [   T11 ] Solna centrum
    [   T11 ] Näckrosen
    [   T11 ] Hallonbergen
    [   T11 ] Kista

    T11  Blue line
    T14  Red line

    *: Transfer to other line
    +: Transfer to other station

=head1 DESCRIPTION

The purpose of this distribution is to find the shortest L<unique|/"What is a unique path?"> route/routes between two stations in a transport network.

=head2 Methods

=head3 new($city, hooks => [])

B<C<$city>>

The name of the city you want to search connections in. Mandatory, unless you are only going to call L</"available_maps">.

B<C<$hooks>>

Array reference of L<Hooks|Map::Metro::Hook> that listens for events.

=head3 parse()

Returns a L<Map::Metro::Graph> object containing the entire graph.


=head3 available_maps()

Returns an array reference containing the names of all Map::Metro maps installed on the system.



=head2 What is a unique path?

The following rules are a guideline:

If the starting station and finishing station...

...is on the same line there will be no transfers to other lines.

...shares multiple lines (e.g., both stations are on both line 2 and 4), each line constitutes a route.

...are on different lines a transfer will take place at a shared station. No matter how many shared stations there are, there will only be one route returned (but which transfer station is used can differ between queries).

...has no shared stations, the shortest route/routes will be returned.


=head1 MORE INFORMATION

L<Map::Metro::Graph> - How to use graph object.

L<Map::Metro::Plugin::Map> - How to make your own maps.

L<Map::Metro::Hook> - How to extend Map::Metro via hooks/events.

L<Map::Metro::Cmd> - A guide to the command line application.

L<Map::Metro::Graph::Connection> - Defines a MMG::Connection.

L<Map::Metro::Graph::Line> - Defines a MMG::Line.

L<Map::Metro::Graph::LineStation> - Defines a MMG::LineStation.

L<Map::Metro::Graph::Route> - Defines a MMG::Route.

L<Map::Metro::Graph::Routing> - Defines a MMG::Routing.

L<Map::Metro::Graph::Segment> - Defines a MMG::Segment.

L<Map::Metro::Graph::Station> - Defines a MMG::Station.

L<Map::Metro::Graph::Step> - Defines a MMG::Step.

L<Map::Metro::Graph::Transfer> - Defines a MMG::Transfer.


=head2 Hierarchy

The following is a conceptual overview of the various parts of a graph:

At first, the map file is parsed. The four types of blocks (stations, transfers, lines and segments) are translated
into their respective object.

Next, lines and stations are put together into L<LineStations|Map::Metro::Graph::LineStation>. Every two adjacent LineStations
are put into two L<Connections|Map::Metro::Graph::Connection> (one for each direction).

Now the network is complete, and it is time to start traversing it.

Once a request to search for paths between two stations is given, we first search for the starting L<Station|Map::Metro::Graph::Station> given either a
station id or station name. Then we find all L<LineStations|Map::Metro::Graph::LineStation> for that station.

Then we do the same for the destination station.

And then we walk through the network, from L<LineStation|Map::Metro::Graph::LineStation> to L<LineStation|Map::Metro::Graph::LineStation>, finding their L<Connections|Map::Metro::Graph::Connection>
and turning them into L<Steps|Map::Metro::Graph::Step>, which we then add to the L<Route|Map::Metro::Graph::Route>.

All L<Routes|Map::Metro::Graph::Route> between the two L<Stations|Map::Metro::Graph::Station> are then put into a L<Routing|Map::Metro::Graph::Routing>, which is returned to the user.


=head1 Status

This is somewhat experimental. I don't expect that the map file format will I<break>, but it might be
extended. Only the documented api should be relied on, though breaking changes might occur.

For all maps in the Map::Metro::Plugin::Map namespace (unless noted):

=over 4

=item These maps are not an official source. Use accordingly.

=item Each map should state its own specific status with regards to coverage of the transport network.

=back

=head1 COMPATIBILITY

Currently only Perl 5.20+ is supported.

L<Map::Tube> works with Perl 5.6.

Included in this distribution is a script to convert C<Map::Metro> maps into C<Map::Tube> maps, if L<Map::Tube> misses one you need.

=head1 BUGS & ISSUES

The repository and issue tracker is at: L<https://github.com/Csson/p5-Map-Metro>

=head1 SEE ALSO

L<Map::Tube>


=head1 AUTHOR

Erik Carlsson E<lt>info@code301.comE<gt>

=head1 COPYRIGHT

Copyright 2014 - Erik Carlsson

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
