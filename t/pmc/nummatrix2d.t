my $tests := Test::NumMatrix2D.new();
$tests.suite.run();

class Test::NumMatrix2D is Pla::NumericMatrixTest;

# Test boilerplate.

INIT {
    use('UnitTest::Testcase');
    use('UnitTest::Assertions');
}

has $!factory;
method factory() {
    unless pir::defined__IP($!factory) {
        $!factory := Pla::MatrixFactory::NumMatrix2D.new();
    }
    return $!factory;
}

# Test class methods to help generalize some tests.

method test_VTABLE_get_string() {
    my $m := self.factory.matrix2x2(1.0, 2.0,
                            3.0, 4.0);
    my $s := pir::set__SP($m);
    my $t := pir::sprintf__SSP("\t%S\t%S\n\t%S\t%S\n", [1.0, 2.0, 3.0, 4.0]);
    assert_equal($s, $t, "cannot get string");
}

# TODO: Tests for get/set_pmc to prove that we get a Float from it
#             $P1 = $P0[0]
#            assert_instance_of($P1, "Float", "got Number PMC from linear index")

# Addition Tests

method test_VTABLE_add_NUMMATRIX2D() {
    my $m := self.factory.matrix2x2(1.0, 3.0, 2.0, 4.0);
    my $n := self.factory.matrix2x2(5.0, 7.0, 6.0, 8.0);
    my $o := self.factory.matrix2x2(6.0, 10.0, 8.0, 12.0);
    my $p := pir::add__PPP($m, $n);
    assert_equal($p, $o, "can add two matrices together of the same size");
}

method test_VTABLE_add_NUMMATRIX2D_SIZEFAIL() {
    assert_throws(Exception::OutOfBounds, "error on sizes not equal", {
        my $m := self.factory.matrix2x2(1.0, 3.0, 2.0, 4.0);
        my $n := self.factory.matrix();
        my $o := pir::add__PPP($m, $n);
        fail("addition worked, apparently");
    });
}

method test_VTABLE_i_add_NUMMATRIX2D() {
    my $m := self.factory.matrix2x2(1.0, 3.0, 2.0, 4.0);
    my $n := self.factory.matrix2x2(5.0, 7.0, 6.0, 8.0);
    my $o := self.factory.matrix2x2(6.0, 10.0, 8.0, 12.0);
    Q:PIR {
        $P0 = find_lex "$m"
        $P1 = find_lex "$n"
        $P2 = find_lex "$o"
        add $P0, $P1
        assert_equal($P0, $P2, "can i_add two matrices together of the same size")
    }
}

# Subtraction Tests

method test_VTABLE_subtract_NUMMATRIX2D() {
    my $m := self.factory.matrix2x2(1.0, 3.0, 2.0, 4.0);
    my $n := self.factory.matrix2x2(5.0, 7.0, 6.0, 8.0);
    my $o := self.factory.matrix2x2(-4.0, -4.0, -4.0, -4.0);
    my $p := pir::sub__PPP($m, $n);
    assert_equal($p, $o, "can add subtract matrices together of the same size");
}

method test_VTABLE_subtract_NUMMATRIX2D_SIZEFAIL() {
    assert_throws(Exception::OutOfBounds, "error on sizes not equal", {
        my $m := self.factory.matrix2x2(1.0, 3.0, 2.0, 4.0);
        my $n := self.factory.matrix();
        my $o := pir::sub__PPP($m, $n);
        fail("subtraction worked, apparently");
    });
}


method test_VTABLE_i_subtract_NUMMATRIX2D() {
    my $m := self.factory.matrix2x2(1.0, 3.0, 2.0, 4.0);
    my $n := self.factory.matrix2x2(5.0, 7.0, 6.0, 8.0);
    my $o := self.factory.matrix2x2(-4.0, -4.0, -4.0, -4.0);
    Q:PIR {
        $P0 = find_lex "$m"
        $P1 = find_lex "$n"
        $P2 = find_lex "$o"
        sub $P0, $P1
        assert_equal($P0, $P2, "can not i_subtract matrices together of the same size")
    }
}

# Multiplication Tests

method test_VTABLE_multiply_NUMMATRIX2D() {
    my $A := self.factory.matrix3x3(1.0, 2.0, 3.0,
                            4.0, 5.0, 6.0,
                            7.0, 8.0, 9.0);
    my $B := self.factory.matrix3x3(1.0, 2.0, 3.0,
                            4.0, 5.0, 6.0,
                            7.0, 8.0, 9.0);
    my $C := self.factory.matrix3x3(30.0,  36.0,  42.0,
                            66.0,  81.0,  96.0,
                            102.0, 126.0, 150.0);
    my $Y := $A * $B;
    assert_equal($C, $Y, "matrix multiply does not do the right thing");

    $Y := $B * $A;
    assert_equal($C, $Y, "matrix multiply does not do the right thing again");
}

method test_VTABLE_multiply_NUMMATRIX2D_SIZEFAIL() {
    assert_throws(Exception::OutOfBounds, "error on sizes not equal", {
        my $A := self.factory.matrix3x3(1.0, 2.0, 3.0,
                                4.0, 5.0, 6.0,
                                7.0, 8.0, 9.0);
        my $B := self.factory.matrix2x2(1.0, 2.0,
                                3.0, 4.0);
        my $C := $A * $B;
    });
}


method test_VTABLE_i_multiply_NUMMATRIX2D() {
    my $A := self.factory.matrix3x3(1.0, 2.0, 3.0,
                            4.0, 5.0, 6.0,
                            7.0, 8.0, 9.0);
    my $B := self.factory.matrix3x3(1.0, 2.0, 3.0,
                            4.0, 5.0, 6.0,
                            7.0, 8.0, 9.0);
    my $C := self.factory.matrix3x3(30.0,  36.0,  42.0,
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

# Block Get/Set method tests

method test_METHOD_set_block() {
    my $m := self.factory.matrix2x2(1.0, 2.0,
                            3.0, 4.0);
    my $n := self.factory.matrix3x3(0.0, 0.0, 0.0,
                            0.0, 0.0, 0.0,
                            0.0, 0.0, 0.0);
    my $o := self.factory.matrix3x3(0.0, 1.0, 2.0,
                            0.0, 3.0, 4.0,
                            0.0, 0.0, 0.0);
    $n.set_block(0, 1, $m);
    assert_equal($n, $o, "cannot set block");
    # TODO: More tests for this method and coordinate combinations, including
    #       boundary-checking issues
}

