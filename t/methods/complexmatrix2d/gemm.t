my $tests := Test::ComplexMatrix2D::Gemm.new();
$tests.suite.run;

class Test::ComplexMatrix2D::Gemm is Pla::Methods::Gemm {
    INIT {
        use('UnitTest::Testcase');
        use('UnitTest::Assertions');
    }

    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::ComplexMatrix2D.new();
        }
        return $!factory;
    }

    method complex($x) {
        my $t := pir::typeof__SP($x);
        if ($t eq "Complex") { return $x; }
        if ($t eq "String") {
            my $c;
            Q:PIR {
                $P0 = find_lex "$x"
                $P1 = new "Complex", $P0
                store_lex "$c", $P1
            };
            return $c;
        }
    }

    method test_METHOD_gemm_aA() {
        my $A := self.factory.matrix3x3("1+1i", "2+2i", "3+3i",
                                "4+4i", "5+5i", "6+6i",
                                "7+7i", "8+8i", "9+9i");
        my $B := self.factory.matrix3x3(1.0, 0.0, 0.0,
                                0.0, 1.0, 0.0,
                                0.0, 0.0, 1.0);
        my $C := self.factory.matrix3x3(0.0, 0.0, 0.0,
                                0.0, 0.0, 0.0,
                                0.0, 0.0, 0.0);
        my $Y := self.factory.matrix3x3("2+2i", "4+4i", "6+6i",
                                "8+8i", "10+10i", "12+12i",
                                "14+14i", "16+16i", "18+18i");
        my $alpha := self.complex("2+0i");
        my $beta := self.complex("0+0i");
        my $Z := $A.'gemm'($alpha, $A, $B, $beta, $C);
        assert_equal($Y, $Z, "cannot GEMM aA");
    }

    method test_METHOD_gemm_AB() {
        my $A := self.factory.matrix3x3("1+1i", "2+2i", "3+3i",
                                "4+4i", "5+5i", "6+6i",
                                "7+7i", "8+8i", "9+9i");
        my $B := self.factory.matrix3x3("1+1i", "2+2i", "3+3i",
                                "4+4i", "5+5i", "6+6i",
                                "7+7i", "8+8i", "9+9i");
        my $C := self.factory.matrix3x3(0.0, 0.0, 0.0,
                                0.0, 0.0, 0.0,
                                0.0, 0.0, 0.0);
        my $Y := self.factory.matrix3x3("0+60i", "0+72i", "0+84i",
                                "0+132i", "0162i", "0+192i",
                                "0+204i", "0+252i", "0+300i");
        my $Z := $A.'gemm'(self.complex("1"), $A, $B, self.complex("0.0"), $C);
        assert_equal($Y, $Z, "gemm aAB does not work");
    }

    method test_METHOD_gemm_aAB() {
        my $A := self.factory.matrix3x3("1+1i", "2+2i", "3+3i",
                                "4+4i", "5+5i", "6+6i",
                                "7+7i", "8+8i", "9+9i");
        my $B := self.factory.matrix3x3("1+1i", "2+2i", "3+3i",
                                "4+4i", "5+5i", "6+6i",
                                "7+7i", "8+8i", "9+9i");
        my $C := self.factory.matrix3x3(0.0, 0.0, 0.0,
                                0.0, 0.0, 0.0,
                                0.0, 0.0, 0.0);
        my $Y := self.factory.matrix3x3("0+15i", "0+18i", "0+21i",
                                "0+33i", "0+40.5i", "0+48i",
                                "0+51i", "0+63i", "0+75i");
        my $Z := $A.'gemm'(self.complex("0.25"), $A, $B, self.complex("0.0"), $C);
        assert_equal($Y, $Z, "gemm aAB does not work");
    }

    method test_METHOD_gemm_aABbC() {
        my $A := self.factory.matrix3x3("1+1i", "2+2i", "3+3i",
                                "4+4i", "5+5i", "6+6i",
                                "7+7i", "8+8i", "9+9i");
        my $B := self.factory.matrix3x3("1+1i", "2+2i", "3+3i",
                                "4+4i", "5+5i", "6+6i",
                                "7+7i", "8+8i", "9+9i");
        my $C := self.factory.matrix3x3(1.0, 2.0, 3.0,
                                4.0, 5.0, 6.0,
                                7.0, 8.0, 9.0);
        my $Y := self.factory.matrix3x3("1+15i", "2+18i", "3+21i",
                                "4+33i", "5+40.5i", "6+48i",
                                "7+51i", "8+63i", "9+75i");
        my $Z := $A.'gemm'(self.complex("0.25"), $A, $B, self.complex("0.0"), $C);
    }

    # Test that we can call GEMM with alpha of various types
    method test_METHOD_gemm_ALPHA_TYPE() {
        todo("Write this!");
    }

    # Test that we can call GEMM with beta of various types
    method test_METHOD_gemm_BETA_TYPE() {
        todo("Write this!");
    }
}
