package Games::Angscum;

use strict;
use warnings;
use AppConfig;
use File::Copy 'copy';
use File::HomeDir;
use File::Spec;
use File::Which;
#use Params::Validate;      # FIXME

our $VERSION = 0.01;

=head2 repl()

Read/Eval/Print Loop

=cut

sub new {
    my $class = shift;
    my $self = bless {}, $class;
    $self->init(@_);
    return $self;
}

sub init {
    my ($self, @args) = @_;
    $self->ui->init();
}

sub config {
    my $self = shift;
    my $config ||= do {
        my $app = AppConfig->new();
        $app->define(ui => { DEFAULT => 'Games::Angscum::TUI' });
        $app->file($self->config_file);
        $app;
    };
}

sub config_file {
    my $self = shift;
    if (@_) {
        $self->{config_file} = shift;
    }
    $self->{config_file} ||= do {
        my $home = File::HomeDir->my_home;
        my $file = File::Spec->catfile($home, qw/ .angscum config /);
        # FIXME: is there a 'touch' command?
        if (not -e $file) {
            open(my $fh, q(>), $file) or die $!;
            print {$fh} "";
            $fh->close();
        }
        $file;
    };
}

sub run {
    my $self = shift;
    while (1) {
        my $resp = $self->ui->prompt;
        last if $resp =~ /quit/i;
    }
}

sub angband {
    my $self = shift;
    if (@_) {
        $self->{angaband} = shift;
    }
    $self->{angband} ||= do {
        File::Which::which('angband');
    };
}

sub read_config {
    my $self = shift;
    $self->{config} ||= do {
        my %x;
        \%x;
    };
}

sub save {
    my $gamefile = '/sw/var/games/angband-nox/lib/save/501.Johntrammell';
    my $savedir = "$ENV{HOME}/.angscum/";
    my $savefile = $savedir . 'save.0';
    print "copying '$gamefile' to '$savefile'\n";
    copy($gamefile, $savefile) or die $!;
}

sub restore {
    my $n = shift;
    my $gamefile = '/sw/var/games/angband-nox/lib/save/501.Johntrammell';
    my $savedir = "$ENV{HOME}/.angscum/";
    my $savefile = $savedir . 'save.' . $n;
    print "copying '$savefile' to '$gamefile'\n";
    copy($savefile, $gamefile) or die $!;
}

sub repl {
    system('angband');
}

sub ui {
    my $self = shift;
    $self->{ui} ||= do {
        my $ui_class = $self->config->get('ui');
        eval qq/ use $ui_class; /;
        $ui_class->new();
    };
}

1;
