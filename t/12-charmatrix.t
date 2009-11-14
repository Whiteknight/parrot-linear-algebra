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

    plan(10);

    create_charmatrix2d();
    op_does_matrix();
    vtable_set_string_keyed_int();
    vtable_get_string_keyed_int();
    vtable_set_integer_keyed();
    vtable_set_number_keyed();
    vtable_set_pmc_keyed();
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

sub vtable_get_string_keyed_int() {
    Q:PIR {
        $P0 = new ['CharMatrix2D']
        $P0[0] = "ABCD"
        $P0[1] = "EFGH"
        $S0 = $P0[0]
        is($S0, "ABCD", "Can get the first row as a string")
        $S0 = $P0[1]
        is($S0, "EFGH", "Can get the second row as a string")
    }
}

sub vtable_set_integer_keyed() {
    Q:PIR {
        $P0 = new ['CharMatrix2D']
        # TODO: We really need to figure out indexing, because this seems wrong
        $P0[0;0] = 65
        $P0[1;0] = 66
        $P0[2;0] = 67
        $P0[3;0] = 68
        $P0[0;1] = 69
        $P0[1;1] = 70
        $P0[2;1] = 71
        $P0[3;1] = 72
        $S0 = $P0[0]
        is($S0, "ABCD", "Can set characters by ASCII value, first row")
        $S0 = $P0[1]
        is($S0, "EFGH", "Can set characeters by ASCII value, second row")
    }
}

sub vtable_set_number_keyed() {
    Q:PIR {
        $P0 = new ['CharMatrix2D']
        $P0[0;0] = 65.2
        $P0[1;0] = 66.3
        $P0[2;0] = 67.4
        $P0[3;0] = 68.5
        $P0[0;1] = 69.6
        $P0[1;1] = 70.7
        $P0[2;1] = 71.8
        $P0[3;1] = 72.9
        $S0 = $P0[0]
        is($S0, "ABCD", "Can set characters by decimal ASCII value, first row")
        $S0 = $P0[1]
        is($S0, "EFGH", "Can set characeters by decimal ASCII value, second row")
    }
}

sub vtable_set_pmc_keyed() {}
