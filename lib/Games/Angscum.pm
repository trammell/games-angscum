package Games::Angscum;

use strict;
use warnings;
use File::Copy 'copy';

our $VERSION = 0.01;

our $CONFIG;

=head2 repl()

Read/Eval/Print Loop

=cut

sub read_config {
    $CONFIG ||= do {
        my %x;
        \%x;
    };
    return $CONFIG;
}

sub save {
    my $gamefile = '/sw/var/games/angband-nox/lib/save/501.Johntrammell';
    my $savedir = "$ENV{HOME}/.angscum/";
    my $savefile = $savedir . 'save.0';
    print "copying '$gamefile' to '$savefile'\n";
    copy($gamefile, $savefile) or die $!;
}

sub repl {
    system('angband');
}

save();

1;
