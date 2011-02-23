Rosella::Testcase::test(Test::NumMatrix2D);

class Test::NumMatrix2D is Pla::NumericMatrixTest;

# Test boilerplate.

has $!factory;
method factory() {
    unless pir::defined__IP($!factory) {
        $!factory := Pla::MatrixFactory::NumMatrix2D.new();
    }
    return $!factory;
}

has $!factory_complex;
method factory_complex() {
    unless pir::defined__IP($!factory_complex) {
        $!factory_complex := Pla::MatrixFactory::ComplexMatrix2D.new();
    }
    return $!factory_complex;
}

has $!factory_pmc;
method factory_pmc() {
    unless pir::defined__IP($!factory_pmc) {
        $!factory_pmc := Pla::MatrixFactory::PMCMatrix2D.new();
    }
    return $!factory_pmc;
}

sub equal($a, $b, $r) { Assert::equal($a, $b, $r); }

# Test class methods to help generalize some tests.

method test_VTABLE_get_string() {
    my $m := self.factory.matrix2x2(1.0, 2.0,
                            3.0, 4.0);
    my $s := pir::set__SP($m);
    my $t := pir::sprintf__SSP("\t%S\t%S\n\t%S\t%S\n", [1.0, 2.0, 3.0, 4.0]);
    Assert::equal($s, $t, "cannot get string");
}

# TODO: Tests for get/set_pmc to prove that we get a Float from it
#             $P1 = $P0[0]
#            Assert::instance_of($P1, "Float", "got Number PMC from linear index")

# Addition Tests

method test_VTABLE_add_NUMMATRIX2D() {
    my $m := self.factory.matrix2x2(1.0, 3.0, 2.0, 4.0);
    my $n := self.factory.matrix2x2(5.0, 7.0, 6.0, 8.0);
    my $o := self.factory.matrix2x2(6.0, 10.0, 8.0, 12.0);
    my $p := pir::add__PPP($m, $n);
    Assert::equal($p, $o, "can not add two matrices together of the same size");
}

method test_VTABLE_add_NUMMATRIX2D_SIZEFAIL() {
    Assert::throws("error on sizes not equal", {
        my $m := self.factory.defaultmatrix2x2();
        my $n := self.factory.defaultmatrix3x3();
        pir::add__PPP($m, $n);
        fail("addition on different sizes worked, apparently");
    });
}

method test_VTABLE_add_COMPLEXMATRIX2D() {
    my $m := self.factory.matrix2x2(1.0, 3.0, 2.0, 4.0);
    my $n := self.factory_complex.matrix2x2("1+1i", "2+1i", "3+1i", "4+1i");
    my $o := self.factory.matrix2x2(2.0, 5.0, 5.0, 8.0);
    my $p := pir::add__PPP($m, $n);
    Assert::equal($p, $o, "can not add numerical and complex matrix together of the same size");
}

method test_VTABLE_add_COMPLEXMATRIX2D_SIZEFAIL() {
    Assert::throws("error on sizes not equal", {
        my $m := self.factory.defaultmatrix2x2();
        my $n := self.factory_complex.defaultmatrix3x3();
        pir::add__PPP($m, $n);
        fail("addition on different sizes worked, apparently");
    });
}

method test_VTABLE_add_PMCMATRIX2D() {
    my $m := self.factory.matrix2x2(1.0, 3.0, 2.0, 4.0);
    my $n := self.factory_pmc.matrix2x2(5.0, "7.0", 6.0, "8.0");
    my $o := self.factory.matrix2x2(6.0, 10.0, 8.0, 12.0);
    my $p := pir::add__PPP($m, $n);
    Assert::equal($p, $o, "can add numerical and pmc matrix together of the same size");
}

method test_VTABLE_add_PMCMATRIX2D_SIZEFAIL() {
    Assert::throws("error on sizes not equal", {
        my $m := self.factory.defaultmatrix2x2();
        my $n := self.factory_pmc.defaultmatrix3x3();
        pir::add__PPP($m, $n);
        fail("addition on different sizes worked, apparently");
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
        equal($P0, $P2, "can i_add two matrices together of the same size")
    }
}

# Subtraction Tests

method test_VTABLE_subtract_NUMMATRIX2D() {
    my $m := self.factory.matrix2x2(1.0, 3.0, 2.0, 4.0);
    my $n := self.factory.matrix2x2(5.0, 7.0, 6.0, 8.0);
    my $o := self.factory.matrix2x2(-4.0, -4.0, -4.0, -4.0);
    my $p := pir::sub__PPP($m, $n);
    Assert::equal($p, $o, "can subtract matrices together of the same size");
}

method test_VTABLE_subtract_NUMMATRIX2D_SIZEFAIL() {
    Assert::throws("error on sizes not equal", {
        my $m := self.factory.defaultmatrix2x2();
        my $n := self.factory.defaultmatrix3x3();
        pir::sub__PPP($m, $n);
        fail("subtraction on different sizes worked, apparently");
    });
}

method test_VTABLE_subtract_COMPLEXMATRIX2D() {
    my $m := self.factory.matrix2x2(1.0, 3.0, 2.0, 4.0);
    my $n := self.factory_complex.matrix2x2("3+1i", "4+1i", "5+1i", "6+1i");
    my $o := self.factory.matrix2x2(-2.0, -1.0, -3.0, -2.0);
    my $p := pir::sub__PPP($m, $n);
    Assert::equal($p, $o, "can subtract numerical and complex matrices together of the same size");
}

method test_VTABLE_subtract_COMPLEXMATRIX2D_SIZEFAIL() {
    Assert::throws("error on sizes not equal", {
        my $m := self.factory.defaultmatrix2x2();
        my $n := self.factory_complex.defaultmatrix3x3();
        pir::sub__PPP($m, $n);
        fail("subtraction on different sizes worked, apparently");
    });
}

method test_VTABLE_subtract_PMCMATRIX2D() {
    my $m := self.factory.matrix2x2(1.0, 3.0, 2.0, 4.0);
    my $n := self.factory_pmc.matrix2x2("5.0", 7.0, "6.0", 8.0);
    my $o := self.factory.matrix2x2(-4.0, -4.0, -4.0, -4.0);
    my $p := pir::sub__PPP($m, $n);
    Assert::equal($p, $o, "can subtract numerical and complex matrices together of the same size");
}

method test_VTABLE_subtract_PMCMATRIX2D_SIZEFAIL() {
    Assert::throws("error on sizes not equal", {
        my $m := self.factory.defaultmatrix2x2();
        my $n := self.factory_pmc.defaultmatrix3x3();
        pir::sub__PPP($m, $n);
        fail("subtraction on different sizes worked, apparently");
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
        equal($P0, $P2, "can not i_subtract matrices together of the same size")
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
    Assert::equal($C, $Y, "matrix multiply does not do the right thing");

    $Y := $B * $A;
    Assert::equal($C, $Y, "matrix multiply does not do the right thing again");
}

method test_VTABLE_multiply_NUMMATRIX2D_SIZEFAIL() {
    Assert::throws("error on sizes not equal", {
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
        equal($P0, $P2, "matrix i_multiply does not do the right thing")
    }
}

method test_VTABLE_set_string_keyed() {
    my $m := self.factory.matrix3x3(1.0, 2.0, 3.0,
                            4.0, 5.0, 6.0,
                            7.0, 8.0, 9.0);
    my $a;
    Q:PIR {
        $P0 = find_lex "$m"
        $P0[0;0] = "15.2"
        $N1 = $P0[0;0]
        $P1 = box $N1
        store_lex "$a", $P1
    };
    Assert::equal($a, 15.2, "set_string_key failed");
}

method test_VTABLE_set_string_keyed_int() {
    my $m := self.factory.matrix3x3(1.0, 2.0, 3.0,
                            4.0, 5.0, 6.0,
                            7.0, 8.0, 9.0);
    my $a;
    Q:PIR {
        $P0 = find_lex "$m"
        $P0[0] = "15.2"
        $N1 = $P0[0]
        $P1 = box $N1
        store_lex "$a", $P1
    };
    Assert::equal($a, 15.2, "set_string_key_int failed");
}

