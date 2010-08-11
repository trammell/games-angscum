package Games::Angscum;

use strict;
use warnings;
use File::Copy 'copy';
use Params::Validate;      # FIXME

our $VERSION = 0.01;

=pod

=head1 NAME

Games::Angscum - savefile scummer for Angband

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHODS

=head2 $class->new()

=cut

sub new {
    my $class = shift;
    my $self = bless {}, $class;
    $self->init(@_);
    return $self;
}

=head2 $obj->init()

=cut

sub init {
    my ($self, @args) = @_;
    $self->ui->init();
}

=head2 $obj->run()

=cut

sub run {
    my $self = shift;
    while (1) {
        my $resp = $self->ui->prompt;
        last if $resp =~ /quit/i;
    }
}

=head2 $obj->save()

=cut

sub save {
    my $savefile = '/sw/var/games/angband-nox/lib/save/501.Johntrammell';
    my $scumdir = "$ENV{HOME}/.angscum/";
    my $scumfile = $scumdir . 'save.0';
    print "copying '$savefile' to '$scumfile'\n";
    copy($savefile, $scumfile) or die $!;
}

sub restore {
    my $n = shift;
    my $savefile = '/sw/var/games/angband-nox/lib/save/501.Johntrammell';
    my $scumdir = "$ENV{HOME}/.angscum/";
    my $scumfile = $scumdir . 'save.' . $n;
    print "copying '$scumfile' to '$savefile'\n";
    copy($scumfile, $savefile) or die $!;
}

sub ui {
    my $self = shift;
    $self->{ui} ||= do {
        my $ui_class = $self->config('ui');
        eval qq/ use $ui_class; /;
        $ui_class->new();
    };
}

1;
