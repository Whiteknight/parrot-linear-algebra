#! parrot-nqp
our @ARGS;
MAIN();

sub MAIN () {
    my $num_tests := 18;
    Q:PIR {
        .local pmc c
        load_language 'parrot'
        c = compreg 'parrot'
        c.'import'('Test::More')
    };
    plan(1);
    ok(1, "Test harness works");

    load_linalg_group();
}

sub load_linalg_group() {
    Q:PIR {
        .local pmc pla
        pla = loadlib "./linalg_group"
        if pla goto has_linalg_group
        ok(0, "loading linalg_group failed")
     has_linalg_group:
        ok(1, "has linalg_group library available")
    }
}

