#!/usr/bin/env perl

use strict;
use warnings;

use Data::Dumper;
use File::Path qw( make_path );
use JSON qw( encode_json decode_json );
use Path::Class;
use Storable qw( freeze );
use Sys::Hostname;

use constant MAX_HISTORY => 100;
use constant FIELDS      => qw( name album artist );

exit 0 unless is_running( 'iTunes' );

my $db_dir = glob '~/Dropbox/hosts/' . get_hostname();
my $db = File::Spec->catfile( $db_dir, 'itunes.json' );
make_path( $db_dir );
my $data = -f $db ? load( $db ) : [];
my $track = eval { current_track() };

if ( my $err = $@ ) {
  warn $err;
  exit 0;
}

unless ( @$data && same_track( $track, $data->[0] ) ) {
  unshift @$data, $track;
  splice @$data, MAX_HISTORY if @$data > MAX_HISTORY;
  save( $db, $data );
}

sub same_track {
  my ( $a, $b ) = @_;
  for my $field ( FIELDS ) {
    return unless $a->{$field} eq $b->{$field};
  }
  return 1;
}

sub load {
  my $db = shift;
  return decode_json file( $db )->slurp;
}

sub save {
  my ( $db, $data ) = @_;
  my $fh = file( $db )->openw;
  print $fh encode_json $data;
}

sub current_track {
  my %rec = ( time => time );
  for my $field ( FIELDS ) {
    my @ret
     = osascript(
      "tell application \"iTunes\" to $field of current track as string"
     );
    $rec{$field} = $ret[0] if @ret;
  }
  return \%rec;
}

sub osascript {
  my $script = shift;
  my @cmd = ( osascript => '-e', $script );
  open my $ch, '-|', @cmd or die "Can't run script: $!";
  binmode $ch, ':utf8';
  chomp( my @ret = <$ch> );
  close $ch or die "Can't run script: $?";
  return @ret;
}

sub is_running {
  my $app = shift;
  my @ret = eval {
    osascript(
      "tell application \"System Events\" to (name of processes) contains \"$app\""
    );
  };
  return @ret && $ret[0] eq 'true';
}

sub get_hostname {
  ( my $hn = hostname ) =~ s/\..*//;
  return $hn;
}

# vim:ts=2:sw=2:sts=2:et:ft=perl

