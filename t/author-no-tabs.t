
BEGIN {
  unless ($ENV{AUTHOR_TESTING}) {
    require Test::More;
    Test::More::plan(skip_all => 'these tests are for testing by the author');
  }
}

use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::NoTabs 0.09

use Test::More 0.88;
use Test::NoTabs;

my @files = (
    'lib/Map/Metro.pm',
    'lib/Map/Metro/Cmd.pm',
    'lib/Map/Metro/Cmd/AllRoutes.pm',
    'lib/Map/Metro/Cmd/Available.pm',
    'lib/Map/Metro/Cmd/Deserealize.pm',
    'lib/Map/Metro/Cmd/Dump.pm',
    'lib/Map/Metro/Cmd/Hoist.pm',
    'lib/Map/Metro/Cmd/Lines.pm',
    'lib/Map/Metro/Cmd/MetroToTube.pm',
    'lib/Map/Metro/Cmd/Route.pm',
    'lib/Map/Metro/Cmd/Serealize.pm',
    'lib/Map/Metro/Cmd/Stations.pm',
    'lib/Map/Metro/Emitter.pm',
    'lib/Map/Metro/Exception.pm',
    'lib/Map/Metro/Exception/DuplicateStationName.pm',
    'lib/Map/Metro/Exception/IllegalConstructorArguments.pm',
    'lib/Map/Metro/Exception/IncompleteParse.pm',
    'lib/Map/Metro/Exception/LineIdContainsIllegalCharacter.pm',
    'lib/Map/Metro/Exception/LineIdDoesNotExistInLineList.pm',
    'lib/Map/Metro/Exception/StationIdDoesNotExist.pm',
    'lib/Map/Metro/Exception/StationNameDoesNotExistInStationList.pm',
    'lib/Map/Metro/Graph.pm',
    'lib/Map/Metro/Graph/Connection.pm',
    'lib/Map/Metro/Graph/Line.pm',
    'lib/Map/Metro/Graph/LineStation.pm',
    'lib/Map/Metro/Graph/Route.pm',
    'lib/Map/Metro/Graph/Routing.pm',
    'lib/Map/Metro/Graph/Segment.pm',
    'lib/Map/Metro/Graph/Station.pm',
    'lib/Map/Metro/Graph/Step.pm',
    'lib/Map/Metro/Graph/Transfer.pm',
    'lib/Map/Metro/Hook.pm',
    'lib/Map/Metro/Plugin/Hook/PrettyPrinter.pm',
    'lib/Map/Metro/Plugin/Hook/StreamStations.pm',
    'lib/Map/Metro/Plugin/Map.pm',
    'lib/Map/Metro/Shim.pm',
    'lib/Map/Metro/Standard.pm',
    'lib/Map/Metro/Standard/Moops.pm',
    'lib/Map/Metro/Types.pm',
    'script/map-metro.pl',
    't/basic.t',
    't/share/test-map.metro'
);

notabs_ok($_) foreach @files;
done_testing;
