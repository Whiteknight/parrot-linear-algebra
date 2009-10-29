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
    vtable_set_number_keyed();
    vtable_get_number_keyed();
    vtable_get_attr_keyed_str();
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
    vtable_clone();
    method_resize();
    method_fill();
    method_transpose();
    method_mem_transpose();
    method_iterate_function_inplace();
}

sub create_nummatrix2d() {
    Q:PIR {
        $P0 = new 'NumMatrix2D'
        $I0 = isnull $P0
        $I0 = not $I0
        'ok'($I0, "Can create a new NumMatrix2D")
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

sub vtable_get_attr_keyed_str() {}
sub vtable_get_integer_keyed() {}
sub vtable_set_integer_keyed() {}
sub vtable_get_string() {}
sub vtable_get_string_keyed() {}
sub vtable_get_pmc_keyed() {}
sub vtable_set_pmc_keyed() {}
sub vtable_get_number_keyed_int() {}
sub vtable_set_number_keyed_int() {}
sub vtable_get_integer_keyed_int() {}
sub vtable_set_integer_keyed_int() {}
sub vtable_get_string_keyed_int() {}
sub vtable_get_pmc_keyed_int() {}
sub vtable_set_pmc_keyed_int() {}
sub vtable_add_nummatrix2d() {}
sub vtable_multiply_nummatrix2d() {}
sub vtable_clone() {}
sub method_resize() {}
sub method_fill() {}
sub method_transpose() {}
sub method_mem_transpose() {}
sub method_iterate_function_inplace() {}
