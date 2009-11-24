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
        pla = loadlib 'linalg_group'
        if pla goto pla_library_loaded
        say "Cannot load linalg_group"
        exit 1
      pla_library_loaded:
    };

    plan(84);

    create_nummatrix2d();
    op_does_matrix();
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
    vtable_get_integer_keyed_int();
    vtable_get_string_keyed_int();
    vtable_get_pmc_keyed_int();
    vtable_is_equal();
    vtable_add_nummatrix2d();
    vtable_add_float();
    vtable_multiply_nummatrix2d();
    vtable_multiply_float();
    vtable_clone();
    method_resize();
    method_fill();
    method_transpose();
    method_mem_transpose();
    method_iterate_function_inplace();
    method_initialize_from_array();
    method_initialize_from_args();
    method_get_block();
    method_set_block();
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

sub op_does_matrix() {
    Q:PIR {
        $P0 = new ['NumMatrix2D']
        $I0 = does $P0, 'matrix'
        ok($I0, "NumMatrix2D does matrix")
        $I0 = does $P0, 'gobbledegak'
        $I0 = not $I0
        ok($I0, "...and only does matrix")
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

sub vtable_get_string_keyed_int() {}

sub vtable_get_pmc_keyed_int() {
    Q:PIR {
        $P0 = new ['NumMatrix2D']
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

sub vtable_is_equal() {
    Q:PIR {
        $P0 = new ['NumMatrix2D']
        $P1 = new ['NumMatrix2D']

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

sub vtable_add_nummatrix2d() {
    Q:PIR {
        $P0 = new ['NumMatrix2D']
        $P0[0;0] = 1.0
        $P0[1;0] = 2.0
        $P0[0;1] = 3.0
        $P0[1;1] = 4.0

        $P1 = new ['NumMatrix2D']
        $P1[0;0] = 5.0
        $P1[1;0] = 6.0
        $P1[0;1] = 7.0
        $P1[1;1] = 8.0

        $P2 = new ['NumMatrix2D']
        $P2[0;0] = 6.0
        $P2[1;0] = 8.0
        $P2[0;1] = 10.0
        $P2[1;1] = 12.0

        $P3 = $P0 + $P1
        $I0 = $P3 == $P2
        ok($I0, "can add two matrices together of the same size")
    }
}

sub vtable_add_float() {
    Q:PIR {
        $P0 = new ['NumMatrix2D']
        $P0[0;0] = 1.0
        $P0[1;0] = 2.0
        $P0[0;1] = 3.0
        $P0[1;1] = 4.0

        $P1 = new ['NumMatrix2D']
        $P1[0;0] = 3.5
        $P1[1;0] = 4.5
        $P1[0;1] = 5.5
        $P1[1;1] = 6.5

        $P2 = box 2.5
        $P3 = $P0 + $P2
        $I0 = $P3 == $P1
        ok($I0, "can add a Float to NumMatrix2D")
    }
}

sub vtable_multiply_nummatrix2d() {}
sub vtable_multiply_float() {
    Q:PIR {
        $P0 = new ['NumMatrix2D']
        $P0[0;0] = 1.0
        $P0[1;0] = 2.0
        $P0[0;1] = 3.0
        $P0[1;1] = 4.0

        $P1 = new ['NumMatrix2D']
        $P1[0;0] = 2.5
        $P1[1;0] = 5.0
        $P1[0;1] = 7.5
        $P1[1;1] = 10.0

        $P2 = box 2.5
        $P3 = $P0 * $P2
        $I0 = $P3 == $P1
        ok($I0, "can multiply a Float with NumMatrix2D")
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

sub method_resize() {
    Q:PIR {
        $P0 = new ['NumMatrix2D']
        $P1 = getattribute $P0, "X"
        $P2 = getattribute $P0, "Y"
        is($P1, 0, "new matrices are empty, X")
        is($P2, 0, "new matrices are empty, Y")

        $P0.'resize'(3, 3)
        $P1 = getattribute $P0, "X"
        $P2 = getattribute $P0, "Y"
        is($P1, 3, "matrices can grow on resize, X")
        is($P2, 3, "matrices can grow on resize, Y")

        $P0.'resize'(1, 1)
        $P1 = getattribute $P0, "X"
        $P2 = getattribute $P0, "Y"
        is($P1, 3, "matrices do not shrink, X")
        is($P2, 3, "matrices do not shrink, Y")
    }
}

sub method_fill() {
    Q:PIR {
        $P0 = new ['NumMatrix2D']
        $P0[1;2] = 2.0
        $P0[1;1] = 2.0
        $P0[1;0] = 2.0
        $P0[0;2] = 2.0
        $P0[0;1] = 2.0
        $P0[0;0] = 2.0

        $P1 = new ['NumMatrix2D']
        $P1.'fill'(2.0, 2, 3)
        $I0 = $P0 == $P1
        ok($I0, "can fill a matrix to a given size")

        $P0[1;2] = 3.0
        $P0[1;1] = 3.0
        $P0[1;0] = 3.0
        $P0[0;2] = 3.0
        $P0[0;1] = 3.0
        $P0[0;0] = 3.0

        $P1.'fill'(3.0)
        $I0 = $P0 == $P1
        ok($I0, "can fill a matrix without specifying size")
    }
}

sub method_transpose() {
    Q:PIR {
        $P0 = new 'NumMatrix2D'
        $P0[1;2] = 6.0
        $P0[1;1] = 5.0
        $P0[1;0] = 4.0
        $P0[0;2] = 3.0
        $P0[0;1] = 2.0
        $P0[0;0] = 1.0

        $P1 = new 'NumMatrix2D'
        $P1[2;1] = 6.0
        $P1[1;1] = 5.0
        $P1[0;1] = 4.0
        $P1[2;0] = 3.0
        $P1[1;0] = 2.0
        $P1[0;0] = 1.0

        $P2 = clone $P0
        $I0 = $P2 == $P0
        ok($I0, "a clone is not transposed")

        $P2.'transpose'()
        $I0 = $P1 == $P2
        ok($I0, "transpose does what it should")
    }
}

sub method_mem_transpose() {
    Q:PIR {
        $P0 = new 'NumMatrix2D'
        $P0[1;2] = 6.0
        $P0[1;1] = 5.0
        $P0[1;0] = 4.0
        $P0[0;2] = 3.0
        $P0[0;1] = 2.0
        $P0[0;0] = 1.0

        $P1 = new 'NumMatrix2D'
        $P1[2;1] = 6.0
        $P1[1;1] = 5.0
        $P1[0;1] = 4.0
        $P1[2;0] = 3.0
        $P1[1;0] = 2.0
        $P1[0;0] = 1.0

        $P2 = clone $P0
        $I0 = $P2 == $P0
        ok($I0, "a clone is not mem_transposed")

        $P2.'mem_transpose'()
        $I0 = $P2 == $P1
        ok($I0, "mem_transpose does what it should")
    }
}

sub method_initialize_from_array() {
    Q:PIR {
        $P0 = new ['ResizableFloatArray']
        $P0[0] = 1.0
        $P0[1] = 2.0
        $P0[2] = 3.0
        $P0[3] = 4.0
        $P0[4] = 5.0
        $P0[5] = 6.0

        $P1 = new ['NumMatrix2D']
        $P1[0;0] = 1.0
        $P1[1;0] = 2.0
        $P1[2;0] = 3.0
        $P1[0;1] = 4.0
        $P1[1;1] = 5.0
        $P1[2;1] = 6.0

        $P2 = new ['NumMatrix2D']
        $P2[0;0] = 1.0
        $P2[1;0] = 2.0
        $P2[0;1] = 3.0
        $P2[1;1] = 4.0
        $P2[0;2] = 5.0
        $P2[1;2] = 6.0

        $P3 = new ['NumMatrix2D']
        $P3[0;0] = 1.0
        $P3[1;0] = 2.0
        $P3[2;0] = 3.0
        $P3[3;0] = 4.0
        $P3[4;0] = 5.0
        $P3[5;0] = 6.0
        $P3[0;1] = 0.0
        $P3[1;1] = 0.0
        $P3[2;1] = 0.0
        $P3[3;1] = 0.0
        $P3[4;1] = 0.0
        $P3[5;1] = 0.0

        $P9 = new ['NumMatrix2D']
        $P9.'initialize_from_array'(3, 2, $P0)
        $I0 = $P9 == $P1
        ok($I0, "Initialize matrix from array first")

        $P9 = new ['NumMatrix2D']
        $P9.'initialize_from_array'(2, 3, $P0)
        $I0 = $P9 == $P2
        ok($I0, "Same initialization array, different dimensions")

        $P9 = new ['NumMatrix2D']
        $P9.'initialize_from_array'(6, 2, $P0)
        $I0 = $P9 == $P3
        ok($I0, "initialization can grow larger then the array")
    }
}

sub method_initialize_from_args() {
    Q:PIR {
        $P1 = new ['NumMatrix2D']
        $P1[0;0] = 1.0
        $P1[1;0] = 2.0
        $P1[2;0] = 3.0
        $P1[0;1] = 4.0
        $P1[1;1] = 5.0
        $P1[2;1] = 6.0

        $P2 = new ['NumMatrix2D']
        $P2[0;0] = 1.0
        $P2[1;0] = 2.0
        $P2[0;1] = 3.0
        $P2[1;1] = 4.0
        $P2[0;2] = 5.0
        $P2[1;2] = 6.0

        $P3 = new ['NumMatrix2D']
        $P3[0;0] = 1.0
        $P3[1;0] = 2.0
        $P3[2;0] = 3.0
        $P3[3;0] = 4.0
        $P3[4;0] = 5.0
        $P3[5;0] = 6.0
        $P3[0;1] = 0.0
        $P3[1;1] = 0.0
        $P3[2;1] = 0.0
        $P3[3;1] = 0.0
        $P3[4;1] = 0.0
        $P3[5;1] = 0.0

        $P9 = new ['NumMatrix2D']
        $P9.'initialize_from_args'(3, 2, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0)
        $I0 = $P9 == $P1
        ok($I0, "Initialize matrix from args first")

        $P9 = new ['NumMatrix2D']
        $P9.'initialize_from_args'(2, 3, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0)
        $I0 = $P9 == $P2
        ok($I0, "Same initialization args, different dimensions")

        $P9 = new ['NumMatrix2D']
        $P9.'initialize_from_args'(6, 2, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0)
        $I0 = $P9 == $P3
        ok($I0, "args initialization can grow larger then the array")
    }
}

sub method_iterate_function_inplace() {
    Q:PIR {
        .local pmc orig
        orig = new ['NumMatrix2D']
        orig[0;0] = 1.0
        orig[1;0] = 2.0
        orig[0;1] = 3.0
        orig[1;1] = 4.0

        .local pmc result_1
        result_1 = new ['NumMatrix2D']
        result_1[0;0] = 1.0
        result_1[1;0] = 4.0
        result_1[0;1] = 9.0
        result_1[1;1] = 16.0

        .local pmc squared
        squared = get_global "_iterate_helper_squared"
        $P0 = clone orig
        $P0.'iterate_function_inplace'(squared)
        $I0 = $P0 == result_1
        ok($I0, "can iterate a function over all elements")

        .local pmc result_2
        result_2 = new ['NumMatrix2D']
        result_2[0;0] = 7.0
        result_2[1;0] = 12.0
        result_2[0;1] = 17.0
        result_2[1;1] = 22.0

        .local pmc ax_b
        ax_b = get_global "_iterate_helper_ax_b"
        $P0 = clone orig
        $P0.'iterate_function_inplace'(ax_b, 5, 2)
        $I0 = $P0 == result_2
        ok($I0, "can iterate with arguments")

        .local pmc result_3
        result_3 = new ['NumMatrix2D']
        result_3[0;0] = 0.0
        result_3[1;0] = 1.0
        result_3[0;1] = 1.0
        result_3[1;1] = 2.0

        .local pmc coords
        coords = get_global "_iterate_helper_coords"
        $P0 = clone orig
        $P0.'iterate_function_inplace'(coords)
        $I0 = $P0 == result_3
        ok($I0, "Iterations have access to coordinates")
    }
}

sub _iterate_helper_squared($matrix, $value, $x, $y) {
    return $value * $value;
}

sub _iterate_helper_ax_b($matrix, $value, $x, $y, $a, $b) {
    return ($a * $value) + $b;
}

sub _iterate_helper_coords($matrix, $value, $x, $y) {
    return $x + $y;
}

sub method_set_block() {
    Q:PIR {
        $P0 = new ['NumMatrix2D']
        $P0[0;0] = 1.0
        $P0[1;1] = 1.0

        $P1 = new ['NumMatrix2D']
        $P1[0;0] = 1.0
        $P1[1;1] = 1.0
        $P1[2;2] = 1.0
        $P1[3;3] = 1.0

        $P2 = new ['NumMatrix2D']
        $P2.'set_block'(0, 0, $P0)
        $P2.'set_block'(2, 2, $P0)
        $I0 = $P2 == $P1
        ok($I0, "set_block works")
    }
}

sub method_get_block() {
    Q:PIR {
        $P0 = new ['NumMatrix2D']
        $P0[0;0] = 1.0
        $P0[1;0] = 2.0
        $P0[2;0] = 3.0
        $P0[0;1] = 4.0
        $P0[1;1] = 5.0
        $P0[2;1] = 6.0

        $P1 = new ['NumMatrix2D']
        $P1[0;0] = 1.0
        $P1[1;0] = 2.0
        $P1[0;1] = 4.0
        $P1[1;1] = 5.0

        $P2 = new ['NumMatrix2D']
        $P2[0;0] = 5.0
        $P2[1;0] = 6.0

        $P9 = $P0.'get_block'(0, 0, 2, 2)
        $I0 = $P9 == $P1
        ok($I0, "can get a block with zero offset")

        $P9 = $P0.'get_block'(1, 1, 2, 1)
        $I0 = $P9 == $P2
        ok($I0, "can get a block with non-zero offset")
    }
}
