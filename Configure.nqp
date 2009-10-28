# Purpose: Use Parrot's config info to configure our Makefile.
#
# Usage:
#     parrot_nqp Configure.nqp

our @ARGS;
our %VM;
our $OS;

MAIN();

sub MAIN () {
    # Wave to the friendly users
    say("Hello, I'm Configure. My job is to poke and prod your system");
    say("to figure out how to build parrot-linear-algebra.\n");

    # Load Parrot config and glue functions
    load_bytecode('config/config-helpers.pir');

    # Slurp in the unconfigured Makefile text
    my $unconfigured := slurp(@ARGS[0] || 'config/Makefile.in');

    # Set up our custom @foo@ markers.
    if ($OS ne 'openbsd') {
        %VM<config>{'cblas'} := '-lcblas';
    }

    # Replace all of the @foo@ markers
    my $replaced := subst($unconfigured, rx('\@<ident>\@'), replacement);

    # Fix paths on Windows
    if ($OS eq 'MSWin32') {
        $replaced := subst($replaced, rx('/'), '\\');
    }

    # Spew out the final makefile
    spew(@ARGS[1] || 'Makefile', $replaced);

    # Give the user a hint of next action
    say("Configure completed.");
    say("You can now type '" ~ %VM<config><make> ~ "' to build parrot-linear-algebra.\n");
    say("You may also type '" ~ %VM<config><make> ~ " test' to run the test suite.\n");
    say("Happy Hacking,");
    say("\tThe parrot-linear-algebra Team");
}

sub replacement ($match) {
    my $key    := $match<ident>;
    my $config := %VM<config>{$key} || '';

    return $config;
}
