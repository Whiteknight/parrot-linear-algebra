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

        .local pmc pla
        pla = loadlib './linalg_group'
        if pla goto pla_library_loaded
        say "Cannot load linalg_group"
        exit 1
      pla_library_loaded:
    };

    plan(11);
    create_pmcmatrix2d();
    op_does_matrix();
    vtable_set_pmc_keyed();
    vtable_get_pmc_keyed();
    vtable_get_integer_keyed();
    vtable_get_number_keyed();
    vtable_get_string_keyed();
    vtable_set_integer_keyed();
    vtable_set_number_keyed();
    vtable_set_string_keyed();
    vtable_get_string();
}

sub create_pmcmatrix2d() {
    Q:PIR {
        push_eh can_not_create
        $P0 = new ['PMCMatrix2D']
        $I0 = isnull $P0
        $I0 = not $I0
        'ok'($I0, "Can create a new PMCMatrix2D")
        .return()
      can_not_create:
        'ok'(0, "Could not create a PMCMatrix2D")
        .return()
    }
}

sub op_does_matrix() {
    Q:PIR {
        $P0 = new ['PMCMatrix2D']
        $I0 = does $P0, 'matrix'
        ok($I0, "PMCMatrix2D does matrix")
        $I0 = does $P0, 'gobbledegak'
        $I0 = not $I0
        ok($I0, "...and only does matrix")
    }
}

sub vtable_set_pmc_keyed() {
    Q:PIR {
        $P0 = new ['PMCMatrix2D']
        push_eh something_broke
        $P1 = new ['Integer']
        $P0[0;0] = $P1
        pop_eh
        ok(1, "set_pmc_keyed doesn't die")
        goto done_set_pmc_keyed
      something_broke:
        pop_eh
        ok(0, "set_pmc_keyed dies")
      done_set_pmc_keyed:
    }
}

sub vtable_get_pmc_keyed() {
    Q:PIR {
        $P0 = new ['PMCMatrix2D']
        $P1 = new ['Integer']
        $P1 = 42
        $P0[0;0] = $P1
        $P2 = $P0[0;0]
        $I0 = $P2
        is($I0, 42, "get_pmc_keyed works")
    }
}

sub vtable_get_integer_keyed() {
    Q:PIR {
        $P0 = new ['PMCMatrix2D']
        $P1 = new ['Integer']
        $P1 = 42
        $P0[0;0] = $P1
        $I0 = $P0[0;0]
        is($I0, 42, "get_integer_keyed works")
    }
}

sub vtable_get_number_keyed() {
    Q:PIR {
        $P0 = new ['PMCMatrix2D']
        $P1 = new ['Float']
        $P1 = 3.1415
        $P0[0;0] = $P1
        $N0 = $P0[0;0]
        is($N0, 3.1415, "get_number_keyed works")
    }
}

sub vtable_get_string_keyed() {
    Q:PIR {
        $P0 = new ['PMCMatrix2D']
        $P1 = new ['String']
        $P1 = "Hello World"
        $P0[0;0] = $P1
        $S0 = $P0[0;0]
        is($S0, "Hello World", "get_string_keyed works")
    }
}

sub vtable_set_integer_keyed() {
    Q:PIR {
        $P0 = new ['PMCMatrix2D']
        $I0 = 42
        $P0[0;0] = $I0
        $I1 = $P0[0;0]
        is($I1, 42, "set_integer_keyed works")
    }
}

sub vtable_set_number_keyed() {
    Q:PIR {
        $P0 = new ['PMCMatrix2D']
        $N0 = 3.1415
        $P0[0;0] = $N0
        $N1 = $P0[0;0]
        is($N1, 3.1415, "set_number_keyed works")
    }    
}

sub vtable_set_string_keyed() {
    Q:PIR {
        $P0 = new ['PMCMatrix2D']
        $S0 = "Hello World"
        $P0[0;0] = $S0
        $S1 = $P0[0;0]
        is($S1, "Hello World", "set_string_keyed works")
    }
}

sub vtable_get_string() {
    Q:PIR {
        $P0 = new ['PMCMatrix2D']
        $S0 = "Hello World"
        $P0[0;0] = $S0
        $S1 = $P0
        # TODO: NQP-RX doesn't seem to like curley brackets inside quotes
        #       here, so we need to talk to pmichaud about that.
        #is($S1, "\\n\t[0,0] = Hello World\n\", "get_string works")
    }
}


