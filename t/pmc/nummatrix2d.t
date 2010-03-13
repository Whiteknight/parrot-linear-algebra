#! parrot-nqp

INIT {
    # Load the Kakapo library
    pir::load_language('parrot');
    my $env := pir::new__PS('Env');
    my $root_dir := $env<HARNESS_ROOT_DIR> || '.';
    pir::load_bytecode($root_dir ~ '/library/kakapo_full.pbc');
    pir::loadlib__ps("./linalg_group");
}

class Test::CharMatrix2D is UnitTest::Testcase;

INIT {
    use('UnitTest::Testcase');
    use('UnitTest::Assertions');
}

MAIN();

sub MAIN() {
    my $proto := Opcode::get_root_global(pir::get_namespace__P().get_name);
    $proto.suite.run;
}

sub matrix2x2($aa, $ab, $ba, $bb) {
    my $m := Parrot::new("NumMatrix2D");
    Q:PIR {
        $P0 = find_lex "$m"
        $P1 = find_lex "$aa"
        $P2 = find_lex "$ab"
        $P3 = find_lex "$ba"
        $P4 = find_lex "$bb"

        $P0[0;0] = $P1
        $P0[0;1] = $P2
        $P0[1;0] = $P3
        $P0[1;1] = $P4
    };
    return ($m);
}

sub matrix3x3($aa, $ab, $ac, $ba, $bb, $bc, $ca, $cb, $cc) {
    my $m := Parrot::new("NumMatrix2D");
    Q:PIR {
        $P0 = find_lex "$m"
        $P1 = find_lex "$aa"
        $P2 = find_lex "$ab"
        $P3 = find_lex "$ac"
        $P4 = find_lex "$ba"
        $P5 = find_lex "$bb"
        $P6 = find_lex "$bc"
        $P7 = find_lex "$ca"
        $P8 = find_lex "$cb"
        $P9 = find_lex "$cc"

        $P0[0;0] = $P1
        $P0[0;1] = $P2
        $P0[0;2] = $P3
        $P0[1;0] = $P4
        $P0[1;1] = $P5
        $P0[1;2] = $P6
        $P0[2;0] = $P7
        $P0[2;1] = $P8
        $P0[2;2] = $P9
    };
    return ($m);
}


method test_op_new() {
    assert_throws_nothing("Cannot create NumMatrix2D", {
        my $m := Parrot::new("NumMatrix2D");
        assert_not_null($m, "NumMatrix2D is null");
    });
}

method test_op_does_matrix() {
    my $m := Parrot::new("NumMatrix2D");
    assert_true(pir::does($m, "matrix"), "Does not do matrix");
    assert_false(pir::does($m, "gobbledegak"), "Does do gobbledegak");
}

method test_vtable_set_number_keyed() {
    assert_throws_nothing("Canno create NumMatrix2D", {
        my $m := Parrot::new("NumMatrix2D");
        Q:PIR {
            $P0 = find_lex "$m"
            $P0[2;2] = 3.0
            $P0[0;0] = 1.0
            $P0[1;1] = 2.0
        }
    });
}

method test_vtable_get_number_keyed() {
    Q:PIR {
        $P0 = new 'NumMatrix2D'
        $P0[2;2] = 3.0
        $P0[0;0] = 1.0
        $P0[1;1] = 2.0

        $N0 = $P0[0;0]
        assert_equal($N0, 1.0, "Got 0,0")

        $N0 = $P0[0;1]
        assert_equal($N0, 0.0, "Got 0,1")

        $N0 = $P0[0;2]
        assert_equal($N0, 0.0, "Got 0,2")

        $N0 = $P0[1;0]
        assert_equal($N0, 0.0, "Got 1,0")

        $N0 = $P0[1;1]
        assert_equal($N0, 2.0, "Got 1,1")

        $N0 = $P0[1;2]
        assert_equal($N0, 0.0, "Got 1,2")

        $N0 = $P0[2;0]
        assert_equal($N0, 0.0, "Got 2,0")

        $N0 = $P0[2;1]
        assert_equal($N0, 0.0, "Got 2,1")

        $N0 = $P0[2;2]
        assert_equal($N0, 3.0, "Got 2,2")
    }
}

method test_vtable_get_attr_string_empty_matrix() {
    my $m := Parrot::new("NumMatrix2D");
    assert_equal(pir::getattribute__PPS($m, "cols"), 0);
    assert_equal(pir::getattribute__PPS($m, "rows"), 0);
}

method test_vtable_get_attr_str() {
    my $m := Parrot::new("NumMatrix2D");
    Q:PIR {
        $P0 = find_lex "$m"
        $P0[2;5] = 1.0
    };
    assert_equal(pir::getattribute__PPS($m, "cols"), 6);
    assert_equal(pir::getattribute__PPS($m, "rows"), 3);

    Q:PIR {
        $P0 = find_lex "$m"
        $P0[2;7] = 2.0
    };
    assert_equal(pir::getattribute__PPS($m, "cols"), 8);
    assert_equal(pir::getattribute__PPS($m, "rows"), 3);

    Q:PIR {
        $P0 = find_lex "$m"
        $P0[10;7] = 2.0
    };
    assert_equal(pir::getattribute__PPS($m, "cols"), 8);
    assert_equal(pir::getattribute__PPS($m, "rows"), 11);
}

method test_vtable_get_integer_keyed() {
    my $m := matrix2x2(4.0, 2.0, 3.0, 1.0);
    Q:PIR {
        $P0 = find_lex "$m"

        $I0 = $P0[1;1]
        assert_equal($I0, 1, "get integer 1,1")

        $I0 = $P0[0;1]
        assert_equal($I0, 2, "get integer 0,1")

        $I0 = $P0[1;0]
        assert_equal($I0, 3, "get integer 1,0")

        $I0 = $P0[0;0]
        assert_equal($I0, 4, "get integer 0,0")
    };
}

method test_vtable_set_integer_keyed() {
    my $m := Parrot::new("NumMatrix2D");
    Q:PIR {
        $P0 = find_lex "$m"
        $P0[1;1] = 1
        $P0[0;1] = 2
        $P0[1;0] = 3
        $P0[0;0] = 4

        $N0 = $P0[1;1]
        assert_equal($N0, 1.0, "got 1,1 set as integer")

        $N0 = $P0[0;1]
        assert_equal($N0, 2.0, "got 0,1 set as integer")

        $N0 = $P0[1;0]
        assert_equal($N0, 3.0, "got 1,0 set as integer")

        $N0 = $P0[0;0]
        assert_equal($N0, 4.0, "got 0,0 set as integer")
    };
}

method test_vtable_get_string() {
    todo("Tests Needed");
}

method test_vtable_get_string_keyed() {
    todo("Tests Needed");
}

method test_vtable_get_pmc_keyed() {
    my $m := matrix2x2(4.0, 2.0, 3.0, 1.0);
    Q:PIR {
        $P0 = find_lex "$m"

        $P1 = $P0[1;1]
        $S0 = typeof $P1
        assert_equal($S0, "Float", "got Number PMC")
        $N0 = $P1
        assert_equal($N0, 1.0, "Got 1,1 as PMC")

        $P1 = $P0[0;1]
        $N0 = $P1
        assert_equal($N0, 2.0, "Got 0,1 as PMC")

        $P1 = $P0[1;0]
        $N0 = $P1
        assert_equal($N0, 3.0, "Got 1,0 as PMC")

        $P1 = $P0[0;0]
        $N0 = $P1
        assert_equal($N0, 4.0, "Got 0,0 as PMC")
    }
}

method test_vtable_set_pmc_keyed() {
    # matrix2x2 does set_pmc_keyed internally.
    my $m := matrix2x2(4.0, 2.0, 3.0, 1.0);
    Q:PIR {
        $P0 = find_lex "$m"

        $N0 = $P0[1;1]
        assert_equal($N0, 1.0, "got 1,1 set as PMC")

        $N0 = $P0[0;1]
        assert_equal($N0, 2.0, "got 0,1 set as PMC")

        $N0 = $P0[1;0]
        assert_equal($N0, 3.0, "got 1,0 set as PMC")

        $N0 = $P0[0;0]
        assert_equal($N0, 4.0, "got 0,0 set as PMC")
    }
}


method test_vtable_get_number_keyed_int() {
    my $m := matrix2x2(4.0, 2.0, 3.0, 1.0);
    Q:PIR {
        $P0 = find_lex "$m"

        $N0 = $P0[0]
        assert_equal($N0, 4.0, "Can get number 0 by linear index")

        $N0 = $P0[1]
        assert_equal($N0, 2.0, "Can get number 1 by linear index")

        $N0 = $P0[2]
        assert_equal($N0, 3.0, "Can get number 2 by linear index")

        $N0 = $P0[3]
        assert_equal($N0, 1.0, "Can get number 3 by linear index")
    }
}

method test_vtable_get_integer_keyed_int() {
    my $m := matrix2x2(4.0, 2.0, 3.0, 1.0);
    Q:PIR {
        $P0 = find_lex "$m"

        $I0 = $P0[0]
        assert_equal($I0, 4, "Can get integer 0 by linear index")

        $I0 = $P0[1]
        assert_equal($I0, 2, "Can get integer 1 by linear index")

        $I0 = $P0[2]
        assert_equal($I0, 3, "Can get integer 2 by linear index")

        $I0 = $P0[3]
        assert_equal($I0, 1, "Can get integer 3 by linear index")
    }
}

method test_vtable_get_string_keyed_int() {
    todo("Tests Needed");
}

method test_vtable_get_pmc_keyed_int() {
    my $m := matrix2x2(4.0, 2.0, 3.0, 1.0);
    Q:PIR {
        $P0 = find_lex "$m"

        $P1 = $P0[0]
        assert_instance_of($P1, "Float", "got Number PMC from linear index")
        $N0 = $P1
        assert_equal($N0, 4.0, "Got PMC 0 from linear index")

        $P1 = $P0[1]
        $N0 = $P1
        assert_equal($N0, 2.0, "Got PMC 1 from linear index")

        $P1 = $P0[2]
        $N0 = $P1
        assert_equal($N0, 3.0, "Got PMC 2 from linear index")

        $P1 = $P0[3]
        $N0 = $P1
        assert_equal($N0, 1.0, "Got PMC 3 from linear index")
    }
}

method test_vtable_is_equal() {
    Q:PIR {
        $P0 = new ['NumMatrix2D']
        $P1 = new ['NumMatrix2D']

        assert_equal($P0, $P1, "empty matrices are equal")

        $P0[0;0] = 1.0
        $P1[0;0] = 1.0
        assert_equal($P0, $P1, "Initialized 1x1 matrices are equal")

        $P0[3;5] = 2.0
        $P1[3;5] = 2.0
        assert_equal($P0, $P1, "Auto-resized matrices are equal")

        $P0[3;5] = 3.0
        assert_not_equal($P0, $P1, "matrices with different values aren't equal")
        $P1[3;5] = 3.0
        assert_equal($P0, $P1, "matrices can be made equal again")

        $P0[4;7] = 0.0
        assert_not_equal($P0, $P1, "matrices of different sizes aren't equal")
    }
}

method test_vtable_add_nummatrix2d() {
    my $m := matrix2x2(1.0, 3.0, 2.0, 4.0);
    my $n := matrix2x2(5.0, 7.0, 6.0, 8.0);
    my $o := matrix2x2(6.0, 10.0, 8.0, 12.0);
    my $p := pir::add__PPP($m, $n);
    assert_equal($p, $o, "can add two matrices together of the same size");
}

method test_vtable_add_nummatrix2d_sizefail() {
    assert_throws("error on sizes not equal", {
        my $m := matrix2x2(1.0, 3.0, 2.0, 4.0);
        my $n := Parrot::new("NumMatrix2D");
        my $o := pir::add__PPP($m, $n);
        fail("addition worked, apparently");
    });
}

method test_vtable_add_float() {
    my $m := matrix2x2(1.0, 3.0, 2.0, 4.0);
    my $n := matrix2x2(3.5, 5.5, 4.5, 6.5);
    my $o := 2.5;
    my $p := pir::add__PPP($n, $o);
    assert_equal($p, $n);
}

method test_vtable_multiply_nummatrix2d() {
    todo("Test Needed");
}

method test_vtable_multiply_float() {
    my $m := matrix2x2(1.0, 2.0, 3.0, 4.0);
    my $n := matrix2x2(2.5, 5.0, 7.5, 10.0);
    my $p := pir::mul__PPP($m, 2.5);
    assert_equal($n, $p, "multiply matrix * float");
}

method test_vtable_clone() {
    my $m := matrix2x2(1.0, 2.0, 3.0, 4.0);
    my $n := pir::clone__PP($m);
    assert_instance_of($n, "NumMatrix2D", "wrong type");
    assert_not_same($m, $n, "are same");
    assert_equal($m, $n, "are not equal");
}

method test_method_resize() {
    my $m := Parrot::new("NumMatrix2D");
    $m.resize(3, 3);
    assert_equal(pir::getattribute__PPS($m, "cols"), 3, "matrix does not grow");
    assert_equal(pir::getattribute__PPS($m, "rows"), 3, "matrix does not grow");

    $m.resize(1, 1);
    assert_equal(pir::getattribute__PPS($m, "cols"), 8, "matrix shrinks");
    assert_equal(pir::getattribute__PPS($m, "rows"), 11, "matrix shrinks");
}

method test_method_fill() {
    my $m := Parrot::new("NumMatrix2D");
    my $n := matrix3x3(2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0);
    my $o := matrix3x3(3.0, 3.0, 3.0, 3.0, 3.0, 3.0, 3.0, 3.0, 3.0);
    $m.fill(2.0, 3, 3);
    assert_equal($m, $n, "resizing fill does not work");
    $m.fill(3.0);
    assert_equal($m, $o, "non-resizing fill does not work");
}

sub method_transpose() {
    my $m := matrix3x3(1.0, 2.0, 3.0,
                       4.0, 5.0, 6.0,
                       7.0, 8.0, 9.0);
    my $n := matrix3x3(1.0, 4.0, 7.0,
                       2.0, 5.0, 8.0,
                       3.0, 6.0, 9.0);
    $m.transpose();
    assert_equal($m, $n, "transpose does not work");
}

sub method_mem_transpose() {
    my $m := matrix3x3(1.0, 2.0, 3.0,
                       4.0, 5.0, 6.0,
                       7.0, 8.0, 9.0);
    my $n := matrix3x3(1.0, 4.0, 7.0,
                       2.0, 5.0, 8.0,
                       3.0, 6.0, 9.0);
    $m.mem_transpose();
    assert_equal($m, $n, "transpose does not work");
}

method test_method_initialize_from_array() {
    my $m := Parrot::new("NumMatrix2D");
    my $n := [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0];
    my $o := matrix3x3(1.0, 2.0, 3.0,
                       4.0, 5.0, 6.0,
                       7.0, 8.0, 9.0);
    $m.initialize_from_array(3, 3, $n);
    assert_equal($m, $o, "array initialization does not work");
}

method test_method_initialize_from_array_zero_pad() {
    my $m := Parrot::new("NumMatrix2D");
    my $n := [1.0, 2.0, 3.0, 4.0, 5.0];
    my $o := matrix3x3(1.0, 2.0, 3.0,
                       4.0, 5.0, 0.0,
                       0.0, 0.0, 0.0);
    $m.initialize_from_array(3, 3, $n);
    assert_equal($m, $o, "array initialization zero-padding does not work");
}

method test_method_initialize_from_array_undersize() {
    my $m := Parrot::new("NumMatrix2D");
    my $n := [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0];
    my $o := matrix2x2(1.0, 2.0,
                       3.0, 4.0);
    $m.initialize_from_array(2, 2, $n);
    assert_equal($m, $o, "array initialization does not work");
}

method test_method_initialize_from_array_args() {
    my $m := Parrot::new("NumMatrix2D");
    my $n := matrix3x3(1.0, 2.0, 3.0,
                       4.0, 5.0, 6.0,
                       7.0, 8.0, 9.0);
    $m.initialize_from_array_args(3, 3, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0);
    assert_equal($m, $n, "array initialization does not work");
}

method test_method_initialize_from_array_args_zero_pad() {
    my $m := Parrot::new("NumMatrix2D");
    my $n := matrix3x3(1.0, 2.0, 3.0,
                       4.0, 5.0, 0.0,
                       0.0, 0.0, 0.0);
    $m.initialize_from_array_args(3, 3, 1.0, 2.0, 3.0, 4.0, 5.0);
    assert_equal($m, $n, "array initialization zero-padding does not work");
}

method test_method_initialize_from_array_args_undersize() {
    my $m := Parrot::new("NumMatrix2D");
    my $n := matrix2x2(1.0, 2.0,
                       3.0, 4.0);
    $m.initialize_from_array_args(2, 2, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0);
    assert_equal($m, $n, "array initialization does not work");
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
