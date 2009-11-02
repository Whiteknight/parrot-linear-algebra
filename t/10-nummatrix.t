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

    plan(55);

    create_nummatrix2d();
    vtable_set_number_keyed();
    vtable_get_number_keyed();
    vtable_get_attr_str();
    vtable_get_integer_keyed();
    vtable_set_integer_keyed();
    vtable_get_string();
    vtable_get_string_keyed();
    vtable_get_pmc_keyed();
    vtable_set_pmc_keyed();
    vtable_get_number_keyed_int();
    vtable_set_number_keyed_int();
    vtable_get_integer_keyed_int();
    vtable_set_integer_keyed_int();
    vtable_get_string_keyed_int();
    vtable_get_pmc_keyed_int();
    vtable_set_pmc_keyed_int();
    vtable_add_nummatrix2d();
    vtable_multiply_nummatrix2d();
    vtable_is_equal();
    vtable_clone();
    method_resize();
    method_fill();
    method_transpose();
    method_mem_transpose();
    method_iterate_function_inplace();
}

sub create_nummatrix2d() {
    Q:PIR {
        push_eh can_not_create
        $P0 = new 'NumMatrix2D'
        $I0 = isnull $P0
        $I0 = not $I0
        'ok'($I0, "Can create a new NumMatrix2D")
        .return()
      can_not_create:
        'ok'(0, "Could not create a NumMatrix2D")
        .return()
    }
}

sub vtable_set_number_keyed() {
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

sub vtable_get_number_keyed() {
    Q:PIR {
        $P0 = new 'NumMatrix2D'
        $P0[2;2] = 3.0
        $P0[0;0] = 1.0
        $P0[1;1] = 2.0

        $N0 = $P0[0;0]
        is($N0, 1.0, "Got 0,0")

        $N0 = $P0[0;1]
        is($N0, 0.0, "Got 0,1")

        $N0 = $P0[0;2]
        is($N0, 0.0, "Got 0,2")

        $N0 = $P0[1;0]
        is($N0, 0.0, "Got 1,0")

        $N0 = $P0[1;1]
        is($N0, 2.0, "Got 1,1")

        $N0 = $P0[1;2]
        is($N0, 0.0, "Got 1,2")

        $N0 = $P0[2;0]
        is($N0, 0.0, "Got 2,0")

        $N0 = $P0[2;1]
        is($N0, 0.0, "Got 2,1")

        $N0 = $P0[2;2]
        is($N0, 3.0, "Got 2,2")
    }
}

sub vtable_get_attr_str() {
    Q:PIR {
        $P0 = new 'NumMatrix2D'
        $P0[2;5] = 1.0
        $P1 = getattribute $P0, "X"
        is($P1, 3, "get first X")
        $P2 = getattribute $P0, "Y"
        is($P2, 6, "get first Y")

        $P0[2;7] = 2.0
        $P1 = getattribute $P0, "X"
        is($P1, 3, "get first X again")
        $P2 = getattribute $P0, "Y"
        is($P2, 8, "get resized Y")

        $P0[10;7] = 3.0
        $P1 = getattribute $P0, "X"
        is($P1, 11, "get resized X")
        $P2 = getattribute $P0, "Y"
        is($P2, 8, "get resized Y again")
    }
}

sub vtable_get_integer_keyed() {
    Q:PIR {
        $P0 = new 'NumMatrix2D'
        $P0[1;1] = 1.0
        $P0[0;1] = 2.0
        $P0[1;0] = 3.0
        $P0[0;0] = 4.0

        $I0 = $P0[1;1]
        is($I0, 1, "get integer 1,1")

        $I0 = $P0[0;1]
        is($I0, 2, "get integer 0,1")

        $I0 = $P0[1;0]
        is($I0, 3, "get integer 1,0")

        $I0 = $P0[0;0]
        is($I0, 4, "get integer 0,0")
    }
}

sub vtable_set_integer_keyed() {
    Q:PIR {
        $P0 = new 'NumMatrix2D'
        $P0[1;1] = 1
        $P0[0;1] = 2
        $P0[1;0] = 3
        $P0[0;0] = 4

        $N0 = $P0[1;1]
        is($N0, 1.0, "got 1,1 set as integer")

        $N0 = $P0[0;1]
        is($N0, 2.0, "got 0,1 set as integer")

        $N0 = $P0[1;0]
        is($N0, 3.0, "got 1,0 set as integer")

        $N0 = $P0[0;0]
        is($N0, 4.0, "got 0,0 set as integer")
    }
}

# TODO: These!
sub vtable_get_string() {}
sub vtable_get_string_keyed() {}

sub vtable_get_pmc_keyed() {
    Q:PIR {
        $P0 = new 'NumMatrix2D'
        $P0[1;1] = 1.0
        $P0[0;1] = 2.0
        $P0[1;0] = 3.0
        $P0[0;0] = 4.0

        $P1 = $P0[1;1]
        $S0 = typeof $P1
        is($S0, "Float", "got Number PMC")
        $N0 = $P1
        is($N0, 1.0, "Got 1,1 as PMC")

        $P1 = $P0[0;1]
        $N0 = $P1
        is($N0, 2.0, "Got 0,1 as PMC")

        $P1 = $P0[1;0]
        $N0 = $P1
        is($N0, 3.0, "Got 1,0 as PMC")

        $P1 = $P0[0;0]
        $N0 = $P1
        is($N0, 4.0, "Got 0,0 as PMC")
    }
}

sub vtable_set_pmc_keyed() {
    Q:PIR {
        $P0 = new 'NumMatrix2D'
        $P1 = box 1.0
        $P0[1;1] = $P1
        $P1 = box 2.0
        $P0[0;1] = $P1
        $P1 = box 3.0
        $P0[1;0] = $P1
        $P1 = box 4.0
        $P0[0;0] = $P1

        $N0 = $P0[1;1]
        is($N0, 1.0, "got 1,1 set as PMC")

        $N0 = $P0[0;1]
        is($N0, 2.0, "got 0,1 set as PMC")

        $N0 = $P0[1;0]
        is($N0, 3.0, "got 1,0 set as PMC")

        $N0 = $P0[0;0]
        is($N0, 4.0, "got 0,0 set as PMC")
    }
}


sub vtable_get_number_keyed_int() {
    Q:PIR {
        $P0 = new 'NumMatrix2D'
        $P0[1;1] = 1.0
        $P0[0;1] = 2.0
        $P0[1;0] = 3.0
        $P0[0;0] = 4.0

        $N0 = $P0[0]
        is($N0, 4.0, "Can get number 0 by linear index")

        $N0 = $P0[1]
        is($N0, 2.0, "Can get number 1 by linear index")

        $N0 = $P0[2]
        is($N0, 3.0, "Can get number 2 by linear index")

        $N0 = $P0[3]
        is($N0, 1.0, "Can get number 3 by linear index")
    }
}

sub vtable_set_number_keyed_int() {}

sub vtable_get_integer_keyed_int() {
    Q:PIR {
        $P0 = new 'NumMatrix2D'
        $P0[1;1] = 1.0
        $P0[0;1] = 2.0
        $P0[1;0] = 3.0
        $P0[0;0] = 4.0

        $I0 = $P0[0]
        is($I0, 4, "Can get integer 0 by linear index")

        $I0 = $P0[1]
        is($I0, 2, "Can get integer 1 by linear index")

        $I0 = $P0[2]
        is($I0, 3, "Can get integer 2 by linear index")

        $I0 = $P0[3]
        is($I0, 1, "Can get integer 3 by linear index")
    }
}

sub vtable_set_integer_keyed_int() {}
sub vtable_get_string_keyed_int() {}

sub vtable_get_pmc_keyed_int() {
    Q:PIR {
        $P0 = new 'NumMatrix2D'
        $P0[1;1] = 1.0
        $P0[0;1] = 2.0
        $P0[1;0] = 3.0
        $P0[0;0] = 4.0

        $P1 = $P0[0]
        $S0 = typeof $P1
        is($S0, "Float", "got Number PMC from linear index")
        $N0 = $P1
        is($N0, 4.0, "Got PMC 0 from linear index")

        $P1 = $P0[1]
        $N0 = $P1
        is($N0, 2.0, "Got PMC 1 from linear index")

        $P1 = $P0[2]
        $N0 = $P1
        is($N0, 3.0, "Got PMC 2 from linear index")

        $P1 = $P0[3]
        $N0 = $P1
        is($N0, 1.0, "Got PMC 3 from linear index")
    }
}


sub vtable_set_pmc_keyed_int() {}
sub vtable_add_nummatrix2d() {}
sub vtable_multiply_nummatrix2d() {}

sub vtable_is_equal() {
    Q:PIR {
        $P0 = new 'NumMatrix2D'
        $P1 = new 'NumMatrix2D'

        $I0 = $P0 == $P1
        ok($I0, "empty matrices are equal")

        $P0[0;0] = 1.0
        $P1[0;0] = 1.0
        $I0 = $P0 == $P1
        ok($I0, "Initialized 1x1 matrices are equal")

        $P0[3;5] = 2.0
        $P1[3;5] = 2.0
        $I0 = $P0 == $P1
        ok($I0, "Auto-resized matrices are equal")

        $P0[3;5] = 3.0
        $I0 = $P0 == $P1
        is($I0, 0, "matrices with different values aren't equal")
        $P1[3;5] = 3.0
        $I0 = $P0 == $P1
        ok($I0, "matrices can be made equal again")

        $P0[4;7] = 0.0
        $I0 = $P0 == $P1
        is($I0, 0, "matrices of different sizes aren't equal")
    }
}

sub vtable_clone() {
    Q:PIR {
        $P0 = new 'NumMatrix2D'
        $P0[1;1] = 1.0
        $P0[0;1] = 2.0
        $P0[1;0] = 3.0
        $P0[0;0] = 4.0

        $P1 = clone $P0
        $S0 = typeof $P1
        is($S0, "NumMatrix2D", "a clone is the right type")

        $I0 = $P0 == $P1
        ok($I0, "Clones are equal")
    }
}

sub method_resize() {}
sub method_fill() {}
sub method_transpose() {}
sub method_mem_transpose() {}
sub method_iterate_function_inplace() {}
