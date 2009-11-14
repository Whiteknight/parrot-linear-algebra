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

    plan(4);

    create_charmatrix2d();
    op_does_matrix();
    vtable_set_string_keyed_int();
}

sub create_charmatrix2d() {
    Q:PIR {
        push_eh can_not_create
        $P0 = new ['CharMatrix2D']
        $I0 = isnull $P0
        $I0 = not $I0
        'ok'($I0, "Can create a new CharMatrix2D")
        .return()
      can_not_create:
        'ok'(0, "Could not create a CharMatrix2D")
        .return()
    }
}

sub op_does_matrix() {
    Q:PIR {
        $P0 = new ['CharMatrix2D']
        $I0 = does $P0, 'matrix'
        ok($I0, "CharMatrix2D does matrix")
        $I0 = does $P0, 'gobbledegak'
        $I0 = not $I0
        ok($I0, "...and only does matrix")
    }
}

sub vtable_set_string_keyed_int() {
    Q:PIR {
        $P0 = new ['CharMatrix2D']
        $P0[0] = "ABCD"
        $P0[1] = "EFGH"
        $S0 = "ABCD\nEFGH\n"
        $S1 = $P0
        is($S0, $S1, "can set row-at-a-time, with equal lengths")
    }
}
