=head1 NAME

Configure.pl - a configure script for parrot-linear-algebra

=head1 SYNOPSIS

  perl Configure.pl --help

  perl Configure.pl

  perl Configure.pl --parrot_config=<path_to_parrot>

=cut

use strict;
use warnings;
use 5.008;

use Getopt::Long qw(:config auto_help);

our ( $opt_parrot_config );
GetOptions( 'parrot_config=s' );

print <<HELLO;
Hello, I'm Configure. My job is to poke and prod your system 
to figure out how to build parrot-linear-algebra.
HELLO


#  Get a list of parrot-configs to invoke.
my @parrot_config_exe = $opt_parrot_config
                      ? ( $opt_parrot_config )
                      : (
                          'parrot/parrot_config',
                          'parrot_config',
                        );

#  Get configuration information from parrot_config
my %config = read_parrot_config(@parrot_config_exe);
unless (%config) {
    die "Unable to locate parrot_config.";
}

#  Create the Makefile using the information we just got
create_makefiles(%config);

print <<DIRECTIONS;

You can now type '$config{"make"}' to build parrot-linear-algebra.

Happy Hacking,
    The parrot-linear-algebra Team

DIRECTIONS

sub read_parrot_config {
    my @parrot_config_exe = @_;
    my %config = ();
    for my $exe (@parrot_config_exe) {
        no warnings;
        if (open my $PARROT_CONFIG, '-|', "$exe --dump") {
            print "Reading configuration information from $exe\n";
            while (<$PARROT_CONFIG>) {
                $config{$1} = $2 if (/(\w+) => '(.*)'/);
            }
            close $PARROT_CONFIG;
            last if %config;
        }
    }
    %config;
}


#  Generate Makefiles from a configuration
sub create_makefiles {
    my %config = @_;
    my %makefiles = (
        'config/Makefile.in'         => 'Makefile',
    );
    my $build_tool = $config{libdir} . $config{versiondir}
                   . '/tools/dev/gen_makefile.pl';

    foreach my $template (keys %makefiles) {
        my $makefile = $makefiles{$template};
        print "Creating $makefile\n";
        system($config{perl}, $build_tool, $template, $makefile);
    }
}

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:
