#! parrot_nqp
our @ARGS;
MAIN();

sub MAIN () {
    my $num_tests := 18;
    Q:PIR {
        .local pmc c
        load_language 'parrot'
        c = compreg 'parrot'
        c.'import'('Test::More')

        .local pmc pla
        pla = loadlib 'linalg_group'
        if pla goto pla_library_loaded
        say "Cannot load linalg_group"
        exit 1
      pla_library_loaded:
    };
    plan(11);
    create_nummatrix2d();
    set_number_nummatrix2d();
    get_number_nummatrix2d();
}

sub create_nummatrix2d() {
    Q:PIR {
        $P0 = new 'NumMatrix2D'
        $I0 = isnull $P0
        $I0 = not $I0
        'ok'($I0, "Can create a new NumMatrix2D")
    }
}

sub set_number_nummatrix2d() {
    Q:PIR {
        push_eh can_not_set
        $P0 = new 'NumMatrix2D'
        $P0[2;2] = 3.0
        $P0[0;0] = 1.0
        $P0[1;1] = 2.0
        ok(1, "can set values")
        goto test_passed
      can_not_set:
        ok(0, "Cannot set values")
      test_passed:
    }
}

sub get_number_nummatrix2d() {
    Q:PIR {
        $P0 = new 'NumMatrix2D'
        $P0[2;2] = 3.0
        $P0[0;0] = 1.0
        $P0[1;1] = 2.0

        $N0 = $P0[0;0]
        is($N0, 1.0, "Got 1,1")

        $N0 = $P0[0;1]
        is($N0, 0.0, "Got 1,1")

        $N0 = $P0[0;2]
        is($N0, 0.0, "Got 1,1")

        $N0 = $P0[1;0]
        is($N0, 0.0, "Got 1,1")

        $N0 = $P0[1;1]
        is($N0, 2.0, "Got 1,1")

        $N0 = $P0[1;2]
        is($N0, 0.0, "Got 1,1")

        $N0 = $P0[2;0]
        is($N0, 0.0, "Got 1,1")

        $N0 = $P0[2;1]
        is($N0, 0.0, "Got 1,1")

        $N0 = $P0[2;2]
        is($N0, 3.0, "Got 1,1")
    }
}

