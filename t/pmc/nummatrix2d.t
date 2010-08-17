class Test::NumMatrix2D is Pla::Matrix::MatrixTest;

# Test boilerplate.

INIT {
    use('UnitTest::Testcase');
    use('UnitTest::Assertions');
}

MAIN();

sub MAIN() {
    my $proto := Opcode::get_root_global(pir::get_namespace__P().get_name);
    $proto.suite.run;
}

# Test class methods to help generalize some tests.

method matrix() {
    my $m := Parrot::new("NumMatrix2D");
    return ($m);
}

method defaultvalue() { 1.0; }
method nullvalue() { 0.0; }
method fancyvalue($idx) {
    [5.1, 6.2, 7.3, 8.4][$idx];
}

# TODO: Need to add lots more tests for is_equal. It uses a new float
#       comparison algorithm that I want to really exercise.

method test_VTABLE_set_number_keyed() {
    assert_throws_nothing("Cannot create NumMatrix2D", {
        my $m := self.matrix();
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

method test_VTABLE_get_integer_keyed() {
    my $m := self.matrix2x2(4.0, 2.0, 3.0, 1.0);
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
    my $m := self.matrix();
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
    my $m := self.matrix2x2(1.0, 2.0,
                            3.0, 4.0);
    my $s := pir::set__SP($m);
    my $t := pir::sprintf__SSP("\t%f\t%f\n\t%f\t%f\n", [1.0, 2.0, 3.0, 4.0]);
    assert_equal($s, $t, "cannot get string");
}

method test_VTABLE_get_string_keyed() {
    my $m := self.matrix2x2(4.0, 2.0,
                            3.0, 1.0);
    Q:PIR {
        $P0 = find_lex "$m"
        $S0 = $P0[1;1]
        $S1 = substr $S0, 0, 3
        assert_equal($S1, "1.0", "get_string_keyed fails")
    }
}

method test_VTABLE_get_number_keyed_int() {
    my $m := self.matrix2x2(4.0, 2.0,
                            3.0, 1.0);
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
    my $m := self.matrix2x2(4.0, 2.0, 3.0, 1.0);
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
    my $m := self.matrix2x2(4.0, 2.0,
                            3.0, 1.0);
    Q:PIR {
        $P0 = find_lex "$m"
        $S0 = $P0[2]
        $S1 = substr $S0, 0, 3
        assert_equal($S1, "3.0", "Cannot get string keyed int")
    }
}

method test_VTABLE_get_pmc_keyed_int() {
    my $m := self.matrix2x2(4.0, 2.0, 3.0, 1.0);
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

# Addition Tests

method test_VTABLE_add_NUMMATRIX2D() {
    my $m := self.matrix2x2(1.0, 3.0, 2.0, 4.0);
    my $n := self.matrix2x2(5.0, 7.0, 6.0, 8.0);
    my $o := self.matrix2x2(6.0, 10.0, 8.0, 12.0);
    my $p := pir::add__PPP($m, $n);
    assert_equal($p, $o, "can add two matrices together of the same size");
}

method test_VTABLE_add_NUMMATRIX2D_SIZEFAIL() {
    assert_throws(Exception::OutOfBounds, "error on sizes not equal", {
        my $m := self.matrix2x2(1.0, 3.0, 2.0, 4.0);
        my $n := self.matrix();
        my $o := pir::add__PPP($m, $n);
        fail("addition worked, apparently");
    });
}

method test_VTABLE_add_DEFAULT() {
    my $m := self.matrix2x2(1.0, 3.0, 2.0, 4.0);
    my $n := self.matrix2x2(3.5, 5.5, 4.5, 6.5);
    my $o := 2.5;
    my $p := pir::add__PPP($m, $o);
    assert_equal($p, $n, "Cannot add float");
}

method test_VTABLE_add_int() {
    my $m := self.matrix2x2(1.0, 3.0, 2.0, 4.0);
    my $n := self.matrix2x2(5.0, 7.0, 6.0, 8.0);
    Q:PIR {
        $P0 = find_lex "$m"
        $P1 = find_lex "$n"
        $P2 = add $P0, 4
        assert_equal($P1, $P2, "Cannot add_int")
    }
}

method test_VTABLE_add_float() {
    my $m := self.matrix2x2(1.0, 3.0, 2.0, 4.0);
    my $n := self.matrix2x2(3.5, 5.5, 4.5, 6.5);
    Q:PIR {
        $P0 = find_lex "$m"
        $P1 = find_lex "$n"
        $P2 = add $P0, 2.5
        assert_equal($P1, $P2, "Cannot add_float")
    }
}

method test_VTABLE_i_add_NUMMATRIX2D() {
    my $m := self.matrix2x2(1.0, 3.0, 2.0, 4.0);
    my $n := self.matrix2x2(5.0, 7.0, 6.0, 8.0);
    my $o := self.matrix2x2(6.0, 10.0, 8.0, 12.0);
    Q:PIR {
        $P0 = find_lex "$m"
        $P1 = find_lex "$n"
        $P2 = find_lex "$o"
        add $P0, $P1
        assert_equal($P0, $P2, "can i_add two matrices together of the same size")
    }
}

method test_VTABLE_i_add_DEFAULT() {
    my $m := self.matrix2x2(1.0, 3.0, 2.0, 4.0);
    my $n := self.matrix2x2(3.5, 5.5, 4.5, 6.5);
    Q:PIR {
        $P0 = find_lex "$m"
        $P1 = find_lex "$n"
        $P2 = box 2.5
        add $P0, $P2
        assert_equal($P0, $P1, "Cannot i_add FLOAT")
    }
}

method test_VTABLE_i_add_int() {
    my $m := self.matrix2x2(1.0, 3.0, 2.0, 4.0);
    my $n := self.matrix2x2(5.0, 7.0, 6.0, 8.0);
    Q:PIR {
        $P0 = find_lex "$m"
        $P1 = find_lex "$n"
        add $P0, 4
        assert_equal($P0, $P1, "Cannot i_add_int")
    }
}

method test_VTABLE_i_add_float() {
    my $m := self.matrix2x2(1.0, 3.0, 2.0, 4.0);
    my $n := self.matrix2x2(5.5, 7.5, 6.5, 8.5);
    Q:PIR {
        $P0 = find_lex "$m"
        $P1 = find_lex "$n"
        add $P0, 4.5
        assert_equal($P0, $P1, "Cannot i_add_float")
    }
}

# Subtraction Tests

method test_VTABLE_subtract_NUMMATRIX2D() {
    my $m := self.matrix2x2(1.0, 3.0, 2.0, 4.0);
    my $n := self.matrix2x2(5.0, 7.0, 6.0, 8.0);
    my $o := self.matrix2x2(-4.0, -4.0, -4.0, -4.0);
    my $p := pir::sub__PPP($m, $n);
    assert_equal($p, $o, "can add subtract matrices together of the same size");
}

method test_VTABLE_subtract_NUMMATRIX2D_SIZEFAIL() {
    assert_throws(Exception::OutOfBounds, "error on sizes not equal", {
        my $m := self.matrix2x2(1.0, 3.0, 2.0, 4.0);
        my $n := self.matrix();
        my $o := pir::sub__PPP($m, $n);
        fail("subtraction worked, apparently");
    });
}

method test_VTABLE_subtract_DEFAULT() {
    my $m := self.matrix2x2(1.0, 3.0, 2.0, 4.0);
    my $n := self.matrix2x2(-1.5, 0.5, -0.5, 1.5);
    my $o := 2.5;
    my $p := pir::sub__PPP($m, $o);
    assert_equal($p, $n, "Cannot subtract float");
}

method test_VTABLE_subtract_int() {
    my $m := self.matrix2x2(1.0, 3.0, 2.0, 4.0);
    my $n := self.matrix2x2(0.0, 2.0, 1.0, 3.0);
    Q:PIR {
        $P0 = find_lex "$m"
        $P1 = find_lex "$n"
        $P2 = sub $P0, 1
        assert_equal($P1, $P2, "Cannot add_int")
    }
}

method test_VTABLE_subtract_float() {
    my $m := self.matrix2x2(1.0, 3.0, 2.0, 4.0);
    my $n := self.matrix2x2(0.5, 2.5, 1.5, 3.5);
    Q:PIR {
        $P0 = find_lex "$m"
        $P1 = find_lex "$n"
        $P2 = sub $P0, 0.5
        assert_equal($P1, $P2, "Cannot subtract_float")
    }
}

method test_VTABLE_i_subtract_NUMMATRIX2D() {
    my $m := self.matrix2x2(1.0, 3.0, 2.0, 4.0);
    my $n := self.matrix2x2(5.0, 7.0, 6.0, 8.0);
    my $o := self.matrix2x2(-4.0, -4.0, -4.0, -4.0);
    Q:PIR {
        $P0 = find_lex "$m"
        $P1 = find_lex "$n"
        $P2 = find_lex "$o"
        sub $P0, $P1
        assert_equal($P0, $P2, "can not i_subtract matrices together of the same size")
    }
}

method test_VTABLE_i_subtract_DEFAULT() {
    my $m := self.matrix2x2(1.0, 3.0, 2.0, 4.0);
    my $n := self.matrix2x2(-1.5, 0.5, -0.5, 1.5);
    my $o := 2.5;
    Q:PIR {
        $P0 = find_lex "$m"
        $P1 = find_lex "$n"
        $P2 = find_lex "$o"
        sub $P0, $P2
        assert_equal($P0, $P1, "can not i_subtract Float")
    }
}

method test_VTABLE_i_subtract_int() {
    my $m := self.matrix2x2(1.0, 3.0, 2.0, 4.0);
    my $n := self.matrix2x2(-3.0, -1.0, -2.0, 0.0);
    Q:PIR {
        $P0 = find_lex "$m"
        $P1 = find_lex "$n"
        sub $P0, 4
        assert_equal($P0, $P1, "Cannot i_subtract_int")
    }
}

method test_VTABLE_i_subtract_float() {
    my $m := self.matrix2x2(1.0, 3.0, 2.0, 4.0);
    my $n := self.matrix2x2(-3.5, -1.5, -2.5, -0.5);
    Q:PIR {
        $P0 = find_lex "$m"
        $P1 = find_lex "$n"
        sub $P0, 4.5
        assert_equal($P0, $P1, "Cannot i_subtract_float")
    }
}

# Multiplication Tests

method test_VTABLE_multiply_NUMMATRIX2D() {
    my $A := self.matrix3x3(1.0, 2.0, 3.0,
                            4.0, 5.0, 6.0,
                            7.0, 8.0, 9.0);
    my $B := self.matrix3x3(1.0, 2.0, 3.0,
                            4.0, 5.0, 6.0,
                            7.0, 8.0, 9.0);
    my $C := self.matrix3x3(30.0,  36.0,  42.0,
                            66.0,  81.0,  96.0,
                            102.0, 126.0, 150.0);
    my $Y := $A * $B;
    assert_equal($C, $Y, "matrix multiply does not do the right thing");

    $Y := $B * $A;
    assert_equal($C, $Y, "matrix multiply does not do the right thing again");
}

method test_VTABLE_multiply_NUMMATRIX2D_SIZEFAIL() {
    assert_throws(Exception::OutOfBounds, "error on sizes not equal", {
        my $A := self.matrix3x3(1.0, 2.0, 3.0,
                                4.0, 5.0, 6.0,
                                7.0, 8.0, 9.0);
        my $B := self.matrix2x2(1.0, 2.0,
                                3.0, 4.0);
        my $C := $A * $B;
    });
}

method test_VTABLE_multiply_DEFAULT() {
    my $m := self.matrix2x2(1.0, 2.0, 3.0, 4.0);
    my $n := self.matrix2x2(2.5, 5.0, 7.5, 10.0);
    my $p := pir::mul__PPP($m, 2.5);
    assert_equal($n, $p, "multiply matrix * float");
}

method test_VTABLE_multiply_int() {
    my $m := self.matrix2x2(1.0, 3.0, 2.0, 4.0);
    my $n := self.matrix2x2(5.0, 15.0, 10.0, 20.0);
    Q:PIR {
        $P0 = find_lex "$m"
        $P1 = find_lex "$n"
        $P2 = mul $P0, 5
        assert_equal($P1, $P2, "Cannot multiply_int")
    }
}

method test_VTABLE_multiply_float() {
    my $m := self.matrix2x2(1.0, 3.0, 2.0, 4.0);
    my $n := self.matrix2x2(2.5, 7.5, 5.0, 10.0);
    Q:PIR {
        $P0 = find_lex "$m"
        $P1 = find_lex "$n"
        $P2 = mul $P0, 2.5
        assert_equal($P1, $P2, "Cannot multiply_float")
    }
}

method test_VTABLE_i_multiply_NUMMATRIX2D() {
    my $A := self.matrix3x3(1.0, 2.0, 3.0,
                            4.0, 5.0, 6.0,
                            7.0, 8.0, 9.0);
    my $B := self.matrix3x3(1.0, 2.0, 3.0,
                            4.0, 5.0, 6.0,
                            7.0, 8.0, 9.0);
    my $C := self.matrix3x3(30.0,  36.0,  42.0,
                            66.0,  81.0,  96.0,
                            102.0, 126.0, 150.0);
    Q:PIR {
        $P0 = find_lex "$A"
        $P1 = find_lex "$B"
        $P2 = find_lex "$C"
        mul $P0, $P1
        assert_equal($P0, $P2, "matrix i_multiply does not do the right thing")
    }
}

method test_VTABLE_i_multiply_DEFAULT() {
    my $A := self.matrix3x3(1.0, 2.0, 3.0,
                            4.0, 5.0, 6.0,
                            7.0, 8.0, 9.0);
    my $B := self.matrix3x3(2.0, 4.0, 6.0,
                            8.0, 10.0, 12.0,
                            14.0, 16.0, 18.0);
    Q:PIR {
        $P0 = find_lex "$A"
        $P1 = find_lex "$B"
        $P2 = box 2.0
        mul $P0,  $P2
        assert_equal($P1, $P0, "i_multiply by a Float is not right")
    }
}

method test_VTABLE_i_multiply_int() {
    my $A := self.matrix3x3(1.0, 2.0, 3.0,
                            4.0, 5.0, 6.0,
                            7.0, 8.0, 9.0);
    my $B := self.matrix3x3(2.0, 4.0, 6.0,
                            8.0, 10.0, 12.0,
                            14.0, 16.0, 18.0);
    Q:PIR {
        $P0 = find_lex "$A"
        $P1 = find_lex "$B"
        mul $P0,  2
        assert_equal($P1, $P0, "i_multiply by a Float is not right")
    }
}

method test_VTABLE_i_multiply_float() {
    my $A := self.matrix3x3(1.0, 2.0, 3.0,
                            4.0, 5.0, 6.0,
                            7.0, 8.0, 9.0);
    my $B := self.matrix3x3(2.0, 4.0, 6.0,
                            8.0, 10.0, 12.0,
                            14.0, 16.0, 18.0);
    Q:PIR {
        $P0 = find_lex "$A"
        $P1 = find_lex "$B"
        mul $P0,  2
        assert_equal($P1, $P0, "i_multiply by a Float is not right")
    }
}

# Block Get/Set method tests

method test_METHOD_set_block() {
    my $m := self.matrix2x2(1.0, 2.0,
                            3.0, 4.0);
    my $n := self.matrix3x3(0.0, 0.0, 0.0,
                            0.0, 0.0, 0.0,
                            0.0, 0.0, 0.0);
    my $o := self.matrix3x3(0.0, 1.0, 2.0,
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
    my $m := self.matrix3x3(1.0, 2.0, 3.0,
                            4.0, 5.0, 6.0,
                            7.0, 8.0, 9.0);
    my $n := self.matrix2x2(1.0, 2.0,
                            4.0, 5.0);
    my $o := $m.get_block(0, 0, 2, 2);
    assert_equal($n, $o, "cannot get block");
}

method test_METHOD_get_block_2() {
    my $m := self.matrix3x3(1.0, 2.0, 3.0,
                            4.0, 5.0, 6.0,
                            7.0, 8.0, 9.0);
    my $n := self.matrix2x2(5.0, 6.0,
                            8.0, 9.0);
    my $o := $m.get_block(1, 1, 2, 2);
    assert_equal($n, $o, "cannot get block");
}

# GEMM tests

method test_METHOD_gemm_aA() {
    my $A := self.matrix3x3(1.0, 2.0, 3.0,
                            4.0, 5.0, 6.0,
                            7.0, 8.0, 9.0);
    my $B := self.matrix3x3(1.0, 0.0, 0.0,
                            0.0, 1.0, 0.0,
                            0.0, 0.0, 1.0);
    my $C := self.matrix3x3(0.0, 0.0, 0.0,
                            0.0, 0.0, 0.0,
                            0.0, 0.0, 0.0);
    my $Y := self.matrix3x3(3.0,  6.0,  9.0,
                            12.0, 15.0, 18.0,
                            21.0, 24.0, 27.0);
    my $Z := $A.'gemm'(3.0, $A, $B, 0.0, $C);
    assert_equal($Y, $Z, "gemm aA does not work");
}

method test_METHOD_gemm_AB() {
    my $A := self.matrix3x3(1.0, 2.0, 3.0,
                            4.0, 5.0, 6.0,
                            7.0, 8.0, 9.0);
    my $B := self.matrix3x3(1.0, 2.0, 3.0,
                            4.0, 5.0, 6.0,
                            7.0, 8.0, 9.0);
    my $C := self.matrix3x3(0.0, 0.0, 0.0,
                            0.0, 0.0, 0.0,
                            0.0, 0.0, 0.0);
    my $Y := self.matrix3x3(30.0,  36.0,  42.0,
                            66.0,  81.0,  96.0,
                            102.0, 126.0, 150.0);
    my $Z := $A.'gemm'(1.0, $A, $B, 0.0, $C);
    assert_equal($Y, $Z, "gemm AB does not work");
}

method test_METHOD_gemm_aAB() {
    my $A := self.matrix3x3(1.0, 2.0, 3.0,
                            4.0, 5.0, 6.0,
                            7.0, 8.0, 9.0);
    my $B := self.matrix3x3(1.0, 2.0, 3.0,
                            4.0, 5.0, 6.0,
                            7.0, 8.0, 9.0);
    my $C := self.matrix3x3(0.0, 0.0, 0.0,
                            0.0, 0.0, 0.0,
                            0.0, 0.0, 0.0);
    my $Y := self.matrix3x3(15.0, 18.0, 21.0,
                            33.0, 40.5, 48.0,
                            51.0, 63.0, 75.0);
    my $Z := $A.'gemm'(0.5, $A, $B, 0.0, $C);
    assert_equal($Y, $Z, "gemm aAB does not work");
}

method test_METHOD_gemm_aABbC() {
    my $A := self.matrix3x3(1.0, 2.0, 3.0,
                            4.0, 5.0, 6.0,
                            7.0, 8.0, 9.0);
    my $B := self.matrix3x3(1.0, 2.0, 3.0,
                            4.0, 5.0, 6.0,
                            7.0, 8.0, 9.0);
    my $C := self.matrix3x3(1.0, 1.0, 1.0,
                            2.0, 2.0, 2.0,
                            3.0, 3.0, 3.0);
    my $Y := self.matrix3x3(5.0,  8.0,  11.0,
                            13.0, 20.5, 28.0,
                            21.0, 33.0, 45.0);
    my $Z := $A.'gemm'(0.5, $A, $B, -10, $C);
    assert_equal($Y, $Z, "gemm aAB does not work");
}

method test_METHOD_gemm_BADTYPE() {
    todo("Test Needed");
}

method test_METHOD_gemm_BADSIZE_A() {
    todo("Test Needed");
}

method test_METHOD_gemm_BADSIZE_B() {
    todo("Test Needed");
}

method test_METHOD_gemm_BADSIZE_C() {
    todo("Test Needed");
}

# Row operation tests

method test_METHOD_row_combine() {
    my $A := self.matrix3x3(1.0, 2.0, 3.0,
                            4.0, 5.0, 6.0,
                            7.0, 8.0, 9.0);
    $A.row_combine(1, 2, 1.0);
    my $B := self.matrix3x3(1.0,  2.0,  3.0,
                            4.0,  5.0,  6.0,
                            11.0, 13.0, 15.0);
    assert_equal($A, $B, "can add rows");
}

method test_METHOD_row_combine_NEGIDX() {
    todo("Test Needed");
}

method test_METHOD_row_combine_HIGHIDX() {
    todo("Test Needed");
}

method test_METHOD_row_combine_GAIN() {
    my $A := self.matrix3x3(1.0, 2.0, 3.0,
                            4.0, 5.0, 6.0,
                            7.0, 8.0, 9.0);
    $A.row_combine(0, 1, -4.0);
    my $B := self.matrix3x3(1.0,  2.0,  3.0,
                            0.0, -3.0, -6.0,
                            7.0,  8.0,  9.0);
    assert_equal($A, $B, "can add rows");
}

method test_METHOD_row_scale() {
    my $A := self.matrix3x3(1.0, 2.0, 3.0,
                            4.0, 5.0, 6.0,
                            7.0, 8.0, 9.0);
    $A.row_scale(0, 4);
    my $B := self.matrix3x3(4.0, 8.0,  12.0,
                            4.0, 5.0,  6.0,
                            7.0, 8.0,  9.0);
    assert_equal($A, $B, "can add rows");
}

method test_METHOD_row_scale_NEGIDX() {
    todo("Test Needed");
}

method test_METHOD_row_scale_HIGHIDX() {
    todo("Test Needed");
}

method test_METHOD_row_swap() {
    my $A := self.matrix3x3(1.0, 2.0, 3.0,
                            4.0, 5.0, 6.0,
                            7.0, 8.0, 9.0);
    $A.row_swap(0, 1);
    my $B := self.matrix3x3(4.0, 5.0, 6.0,
                            1.0, 2.0, 3.0,
                            7.0, 8.0,  9.0);
    assert_equal($A, $B, "can add rows");
}

method test_METHOD_row_swap_NEGIDXA() {
    todo("Test Needed");
}

method test_METHOD_row_swap_HIGHIDXA() {
    todo("Test Needed");
}

method test_METHOD_row_swap_NEGIDXB() {
    todo("Test Needed");
}

method test_METHOD_row_swap_HIGHIDXB() {
    todo("Test Needed");
}
