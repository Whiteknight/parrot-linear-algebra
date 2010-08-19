my $tests := Test::NumMatrix2D::Gemm.new();
$tests.suite.run;

class Test::NumMatrix2D::Gemm is Pla::Methods::Gemm {
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

    method test_METHOD_gemm_aA() {
        my $A := self.factory.matrix3x3(1.0, 2.0, 3.0,
                                4.0, 5.0, 6.0,
                                7.0, 8.0, 9.0);
        my $B := self.factory.matrix3x3(1.0, 0.0, 0.0,
                                0.0, 1.0, 0.0,
                                0.0, 0.0, 1.0);
        my $C := self.factory.matrix3x3(0.0, 0.0, 0.0,
                                0.0, 0.0, 0.0,
                                0.0, 0.0, 0.0);
        my $Y := self.factory.matrix3x3(3.0,  6.0,  9.0,
                                12.0, 15.0, 18.0,
                                21.0, 24.0, 27.0);
        my $Z := $A.'gemm'(3.0, $A, $B, 0.0, $C);
        assert_equal($Y, $Z, "gemm aA does not work");
    }

    method test_METHOD_gemm_AB() {
        my $A := self.factory.matrix3x3(1.0, 2.0, 3.0,
                                4.0, 5.0, 6.0,
                                7.0, 8.0, 9.0);
        my $B := self.factory.matrix3x3(1.0, 2.0, 3.0,
                                4.0, 5.0, 6.0,
                                7.0, 8.0, 9.0);
        my $C := self.factory.matrix3x3(0.0, 0.0, 0.0,
                                0.0, 0.0, 0.0,
                                0.0, 0.0, 0.0);
        my $Y := self.factory.matrix3x3(30.0,  36.0,  42.0,
                                66.0,  81.0,  96.0,
                                102.0, 126.0, 150.0);
        my $Z := $A.'gemm'(1.0, $A, $B, 0.0, $C);
        assert_equal($Y, $Z, "gemm AB does not work");
    }

    method test_METHOD_gemm_aAB() {
        my $A := self.factory.matrix3x3(1.0, 2.0, 3.0,
                                4.0, 5.0, 6.0,
                                7.0, 8.0, 9.0);
        my $B := self.factory.matrix3x3(1.0, 2.0, 3.0,
                                4.0, 5.0, 6.0,
                                7.0, 8.0, 9.0);
        my $C := self.factory.matrix3x3(0.0, 0.0, 0.0,
                                0.0, 0.0, 0.0,
                                0.0, 0.0, 0.0);
        my $Y := self.factory.matrix3x3(15.0, 18.0, 21.0,
                                33.0, 40.5, 48.0,
                                51.0, 63.0, 75.0);
        my $Z := $A.'gemm'(0.5, $A, $B, 0.0, $C);
        assert_equal($Y, $Z, "gemm aAB does not work");
    }

    method test_METHOD_gemm_aABbC() {
        my $A := self.factory.matrix3x3(1.0, 2.0, 3.0,
                                4.0, 5.0, 6.0,
                                7.0, 8.0, 9.0);
        my $B := self.factory.matrix3x3(1.0, 2.0, 3.0,
                                4.0, 5.0, 6.0,
                                7.0, 8.0, 9.0);
        my $C := self.factory.matrix3x3(1.0, 1.0, 1.0,
                                2.0, 2.0, 2.0,
                                3.0, 3.0, 3.0);
        my $Y := self.factory.matrix3x3(5.0,  8.0,  11.0,
                                13.0, 20.5, 28.0,
                                21.0, 33.0, 45.0);
        my $Z := $A.'gemm'(0.5, $A, $B, -10, $C);
        assert_equal($Y, $Z, "gemm aAB does not work");
    }
}
