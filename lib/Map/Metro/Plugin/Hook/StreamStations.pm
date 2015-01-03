use feature ':5.20';

package Map::Metro::Plugin::Hook::StreamStations {
$Map::Metro::Plugin::Hook::StreamStations::VERSION = '0.2001';
use Moose;
    use Types::Standard -types;

    has station_names => (
        is => 'rw',
        isa => ArrayRef,
        traits => ['Array'],
        handles => {
            add_station_name => 'push',
            all_station_names => 'elements',
            get_station_name => 'get',
        },
    );

    sub register {
        before_add_station => sub {
            my $self = shift;
            my $station = shift;

            say $station->name;
            $self->add_station_name($station->name);
        };
    }
}

1;
