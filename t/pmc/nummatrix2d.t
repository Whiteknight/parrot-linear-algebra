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

method test_OP_new() {
    assert_throws_nothing("Cannot create NumMatrix2D", {
        my $m := Parrot::new("NumMatrix2D");
        assert_not_null($m, "NumMatrix2D is null");
    });
}

method test_OP_does() {
    my $m := Parrot::new("NumMatrix2D");
    assert_true(pir::does($m, "matrix"), "Does not do matrix");
    assert_false(pir::does($m, "gobbledegak"), "Does do gobbledegak");
}

method test_VTABLE_set_number_keyed() {
    assert_throws_nothing("Cannot create NumMatrix2D", {
        my $m := Parrot::new("NumMatrix2D");
        Q:PIR {
            $P0 = find_lex "$m"
            $P0[2;2] = 3.0
            $P0[0;0] = 1.0
            $P0[1;1] = 2.0
        }
    });
}

method test_VTABLE_get_number_keyed() {
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

method test_VTABLE_get_attr_string_EMPTY() {
    my $m := Parrot::new("NumMatrix2D");
    my $cols := pir::getattribute__PPS($m, "cols");
    my $rows := pir::getattribute__PPS($m, "rows");
    assert_equal($cols, 0, "wrong number of cols");
    assert_equal($rows, 0, "wrong number of rows");
}

method test_VTABLE_get_attr_str() {
    my $m := Parrot::new("NumMatrix2D");
    Q:PIR {
        $P0 = find_lex "$m"
        $P0[2;5] = 1.0
    };
    assert_equal(pir::getattribute__PPS($m, "cols"), 6, "wrong cols");
    assert_equal(pir::getattribute__PPS($m, "rows"), 3, "wrong rows");

    Q:PIR {
        $P0 = find_lex "$m"
        $P0[2;7] = 2.0
    };
    assert_equal(pir::getattribute__PPS($m, "cols"), 8, "wrong cols 2");
    assert_equal(pir::getattribute__PPS($m, "rows"), 3, "wrong rows 2");

    Q:PIR {
        $P0 = find_lex "$m"
        $P0[10;7] = 2.0
    };
    assert_equal(pir::getattribute__PPS($m, "cols"), 8, "wrong cols 3");
    assert_equal(pir::getattribute__PPS($m, "rows"), 11, "wrong rows 3");
}

method test_VTABLE_get_integer_keyed() {
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

method test_VTABLE_set_integer_keyed() {
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

method test_VTABLE_get_string() {
    my $m := matrix2x2(1.0, 2.0, 3.0, 4.0);
    my $s := pir::set__SP($m);
    my $t := pir::sprintf__SSP("\t%f\t%f\n\t%f\t%f\n", [1.0, 2.0, 3.0, 4.0]);
    assert_equal($s, $t, "cannot get string");
}

method test_VTABLE_get_string_keyed() {
    todo("Tests Needed");
}

method test_VTABLE_get_pmc_keyed() {
    my $m := matrix2x2(4.0, 2.0, 3.0, 1.0);
    Q:PIR {
        $P0 = find_lex "$m"

        $P1 = $P0[1;1]
        assert_instance_of($P1, "Float", "not a number PMC")
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

method test_VTABLE_set_pmc_keyed() {
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


method test_VTABLE_get_number_keyed_int() {
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

method test_VTABLE_get_integer_keyed_int() {
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

method test_VTABLE_get_string_keyed_int() {
    todo("Tests Needed");
}

method test_VTABLE_get_pmc_keyed_int() {
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

method test_VTABLE_is_equal() {
    my $m := matrix2x2(1.0, 2.0, 3.0, 4.0);
    my $n := matrix2x2(1.0, 2.0, 3.0, 4.0);
    assert_equal($m, $n, "equal matrices are not equal");
}

method test_VTABLE_is_equal_FAIL_SIZES() {
    my $m := matrix2x2(1.0, 2.0, 3.0, 4.0);
    my $n := matrix2x2(1.0, 2.0, 5.0, 4.0);
    assert_not_equal($m, $n, "matrices with different elements are equal");
}

method test_VTABLE_is_equal_FAIL_ELEMENTS() {
    my $m := matrix2x2(1.0, 2.0, 3.0, 4.0);
    my $n := matrix3x3(1.0, 2.0, 0.0, 3.0, 4.0, 0.0, 0.0, 0.0, 0.0);
    assert_not_equal($m, $n, "different-size matrice are equal");
}

method test_NumMatrix2D_autoresizing() {
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

method test_VTABLE_add_nummatrix2d() {
    my $m := matrix2x2(1.0, 3.0, 2.0, 4.0);
    my $n := matrix2x2(5.0, 7.0, 6.0, 8.0);
    my $o := matrix2x2(6.0, 10.0, 8.0, 12.0);
    my $p := pir::add__PPP($m, $n);
    assert_equal($p, $o, "can add two matrices together of the same size");
}

method test_VTABLE_add_NUMMATRIX2D_SIZEFAIL() {
    assert_throws("Exception", "error on sizes not equal", {
        my $m := matrix2x2(1.0, 3.0, 2.0, 4.0);
        my $n := Parrot::new("NumMatrix2D");
        my $o := pir::add__PPP($m, $n);
        fail("addition worked, apparently");
    });
}

method test_VTABLE_add_FLOAT() {
    my $m := matrix2x2(1.0, 3.0, 2.0, 4.0);
    my $n := matrix2x2(3.5, 5.5, 4.5, 6.5);
    my $o := 2.5;
    my $p := pir::add__PPP($m, $o);
    assert_equal($p, $n, "Cannot add float");
}

method test_VTABLE_multiply_NUMMATRIX2D() {
    todo("Test Needed");
}

method test_VTABLE_multiply_FLOAT() {
    my $m := matrix2x2(1.0, 2.0, 3.0, 4.0);
    my $n := matrix2x2(2.5, 5.0, 7.5, 10.0);
    my $p := pir::mul__PPP($m, 2.5);
    assert_equal($n, $p, "multiply matrix * float");
}

method test_VTABLE_clone() {
    my $m := matrix2x2(1.0, 2.0, 3.0, 4.0);
    my $n := pir::clone__PP($m);
    assert_instance_of($n, "NumMatrix2D", "wrong type");
    assert_not_same($m, $n, "are same");
    assert_equal($m, $n, "are not equal");
}

method test_METHOD_resize() {
    my $m := Parrot::new("NumMatrix2D");
    $m.resize(3, 3);
    assert_equal(pir::getattribute__PPS($m, "cols"), 3, "matrix does not grow");
    assert_equal(pir::getattribute__PPS($m, "rows"), 3, "matrix does not grow");

    $m.resize(1, 1);
    assert_equal(pir::getattribute__PPS($m, "cols"), 3, "matrix shrinks");
    assert_equal(pir::getattribute__PPS($m, "rows"), 3, "matrix shrinks");
}

method test_METHOD_fill() {
    my $m := Parrot::new("NumMatrix2D");
    my $n := matrix3x3(2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0);
    my $o := matrix3x3(3.0, 3.0, 3.0, 3.0, 3.0, 3.0, 3.0, 3.0, 3.0);
    $m.fill(2.0, 3, 3);
    assert_equal($m, $n, "resizing fill does not work");
    $m.fill(3.0);
    assert_equal($m, $o, "non-resizing fill does not work");
}

method test_METHOD_transpose() {
    my $m := matrix3x3(1.0, 2.0, 3.0,
                       4.0, 5.0, 6.0,
                       7.0, 8.0, 9.0);
    my $n := matrix3x3(1.0, 4.0, 7.0,
                       2.0, 5.0, 8.0,
                       3.0, 6.0, 9.0);
    $m.transpose();
    assert_equal($m, $n, "transpose does not work");
}

method test_METHOD_mem_transpose() {
    my $m := matrix3x3(1.0, 2.0, 3.0,
                       4.0, 5.0, 6.0,
                       7.0, 8.0, 9.0);
    my $n := matrix3x3(1.0, 4.0, 7.0,
                       2.0, 5.0, 8.0,
                       3.0, 6.0, 9.0);
    $m.mem_transpose();
    assert_equal($m, $n, "transpose does not work");
}

method test_METHOD_initialize_from_array() {
    my $m := Parrot::new("NumMatrix2D");
    my $n := [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0];
    my $o := matrix3x3(1.0, 2.0, 3.0,
                       4.0, 5.0, 6.0,
                       7.0, 8.0, 9.0);
    $m.initialize_from_array(3, 3, $n);
    assert_equal($m, $o, "array initialization does not work");
}

method test_METHOD_initialize_from_array_ZERO_PAD() {
    my $m := Parrot::new("NumMatrix2D");
    my $n := [1.0, 2.0, 3.0, 4.0, 5.0];
    my $o := matrix3x3(1.0, 2.0, 3.0,
                       4.0, 5.0, 0.0,
                       0.0, 0.0, 0.0);
    $m.initialize_from_array(3, 3, $n);
    assert_equal($m, $o, "array initialization zero-padding does not work");
}

method test_METHOD_initialize_from_array_UNDERSIZE() {
    my $m := Parrot::new("NumMatrix2D");
    my $n := [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0];
    my $o := matrix2x2(1.0, 2.0,
                       3.0, 4.0);
    $m.initialize_from_array(2, 2, $n);
    assert_equal($m, $o, "array initialization does not work");
}

method test_METHOD_initialize_from_args() {
    my $m := Parrot::new("NumMatrix2D");
    my $n := matrix3x3(1.0, 2.0, 3.0,
                       4.0, 5.0, 6.0,
                       7.0, 8.0, 9.0);
    $m.initialize_from_args(3, 3, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0);
    assert_equal($m, $n, "array initialization does not work");
}

method test_METHOD_initialize_from_args_ZERO_PAD() {
    my $m := Parrot::new("NumMatrix2D");
    my $n := matrix3x3(1.0, 2.0, 3.0,
                       4.0, 5.0, 0.0,
                       0.0, 0.0, 0.0);
    $m.initialize_from_args(3, 3, 1.0, 2.0, 3.0, 4.0, 5.0);
    assert_equal($m, $n, "array initialization zero-padding does not work");
}

method test_METHOD_initialize_from_args_UNDERSIZE() {
    my $m := Parrot::new("NumMatrix2D");
    my $n := matrix2x2(1.0, 2.0,
                       3.0, 4.0);
    $m.initialize_from_args(2, 2, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0);
    assert_equal($m, $n, "array initialization does not work");
}

method test_METHOD_iterate_function_inplace_VALUE_ONLY() {
    my $m := matrix2x2(1.0, 2.0, 3.0, 4.0);
    my $n := matrix2x2(1.0, 4.0, 9.0, 16.0);
    $m.iterate_function_inplace(-> $matrix, $value, $x, $y {
        return ($value * $value);
    });
    assert_equal($m, $n, "cannot iterate over values");
}

method test_METHOD_iterate_function_inplace_ARGS() {
    my $m := matrix2x2(1.0, 2.0, 3.0, 4.0);
    my $n := matrix2x2(1.0, 4.0, 9.0, 16.0);
    $m.iterate_function_inplace(-> $matrix, $value, $x, $y, $a, $b {
        return ($value * $value);
    }, 5, 2);
    assert_equal($m, $n, "Cannot iterate with args");
}

method test_METHOD_iterate_function_inplace_COORDS() {
    my $m := matrix2x2(1.0, 2.0, 3.0, 4.0);
    my $n := matrix2x2(0.0, 1.0, 1.0, 2.0);
    $m.iterate_function_inplace(-> $matrix, $value, $x, $y{
        return ($x + $y);
    });
    assert_equal($m, $n, "Cannot iterate with args");
}

method test_METHOD_set_block() {
    my $m := matrix2x2(1.0, 2.0,
                       3.0, 4.0);
    my $n := matrix3x3(0.0, 0.0, 0.0,
                       0.0, 0.0, 0.0,
                       0.0, 0.0, 0.0);
    my $o := matrix3x3(0.0, 1.0, 2.0,
                       0.0, 3.0, 4.0,
                       0.0, 0.0, 0.0);
    $n.set_block(0, 1, $m);
    assert_equal($n, $o, "cannot set block");
    # TODO: More tests for this method and coordinate combinations, including
    #       boundary-checking issues
}

# TODO: Other tests for this method with other argument combinations and
    #       boundary checks.
method test_METHOD_get_block_1() {
    my $m := matrix3x3(1.0, 2.0, 3.0,
                       4.0, 5.0, 6.0,
                       7.0, 8.0, 9.0);
    my $n := matrix2x2(1.0, 2.0,
                       4.0, 5.0);
    my $o := $m.get_block(0, 0, 2, 2);
    assert_equal($n, $o, "cannot get block");
}

method test_METHOD_get_block_2() {
    my $m := matrix3x3(1.0, 2.0, 3.0,
                       4.0, 5.0, 6.0,
                       7.0, 8.0, 9.0);
    my $n := matrix2x2(5.0, 6.0,
                       8.0, 9.0);
    my $o := $m.get_block(1, 1, 2, 2);
    assert_equal($n, $o, "cannot get block");
}
