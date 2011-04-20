my $context := PLA::TestContext.new;
$context.set_factory(Pla::MatrixFactory::ComplexMatrix2D);
Rosella::Test::test(Test::NumMatrix2D::Gemm, :context($context));

class Test::NumMatrix2D::Gemm is Pla::Methods::Gemm {

    method test_METHOD_gemm_aA() {
        my $A := $!context.factory.matrix3x3(1.0, 2.0, 3.0,
                                4.0, 5.0, 6.0,
                                7.0, 8.0, 9.0);
        my $B := $!context.factory.matrix3x3(1.0, 0.0, 0.0,
                                0.0, 1.0, 0.0,
                                0.0, 0.0, 1.0);
        my $C := $!context.factory.matrix3x3(0.0, 0.0, 0.0,
                                0.0, 0.0, 0.0,
                                0.0, 0.0, 0.0);
        my $Y := $!context.factory.matrix3x3(3.0,  6.0,  9.0,
                                12.0, 15.0, 18.0,
                                21.0, 24.0, 27.0);
        my $Z := $A.'gemm'(3.0, $A, $B, 0.0, $C);
        Assert::equal($Y, $Z, "gemm aA does not work");
    }

    method test_METHOD_gemm_AB() {
        my $A := $!context.factory.matrix3x3(1.0, 2.0, 3.0,
                                4.0, 5.0, 6.0,
                                7.0, 8.0, 9.0);
        my $B := $!context.factory.matrix3x3(1.0, 2.0, 3.0,
                                4.0, 5.0, 6.0,
                                7.0, 8.0, 9.0);
        my $C := $!context.factory.matrix3x3(0.0, 0.0, 0.0,
                                0.0, 0.0, 0.0,
                                0.0, 0.0, 0.0);
        my $Y := $!context.factory.matrix3x3(30.0,  36.0,  42.0,
                                66.0,  81.0,  96.0,
                                102.0, 126.0, 150.0);
        my $Z := $A.'gemm'(1.0, $A, $B, 0.0, $C);
        Assert::equal($Y, $Z, "gemm AB does not work");
    }

    method test_METHOD_gemm_aAB() {
        my $A := $!context.factory.matrix3x3(1.0, 2.0, 3.0,
                                4.0, 5.0, 6.0,
                                7.0, 8.0, 9.0);
        my $B := $!context.factory.matrix3x3(1.0, 2.0, 3.0,
                                4.0, 5.0, 6.0,
                                7.0, 8.0, 9.0);
        my $C := $!context.factory.matrix3x3(0.0, 0.0, 0.0,
                                0.0, 0.0, 0.0,
                                0.0, 0.0, 0.0);
        my $Y := $!context.factory.matrix3x3(15.0, 18.0, 21.0,
                                33.0, 40.5, 48.0,
                                51.0, 63.0, 75.0);
        my $Z := $A.'gemm'(0.5, $A, $B, 0.0, $C);
        Assert::equal($Y, $Z, "gemm aAB does not work");
    }

    method test_METHOD_gemm_aABbC() {
        my $A := $!context.factory.matrix3x3(1.0, 2.0, 3.0,
                                4.0, 5.0, 6.0,
                                7.0, 8.0, 9.0);
        my $B := $!context.factory.matrix3x3(1.0, 2.0, 3.0,
                                4.0, 5.0, 6.0,
                                7.0, 8.0, 9.0);
        my $C := $!context.factory.matrix3x3(1.0, 1.0, 1.0,
                                2.0, 2.0, 2.0,
                                3.0, 3.0, 3.0);
        my $Y := $!context.factory.matrix3x3(5.0,  8.0,  11.0,
                                13.0, 20.5, 28.0,
                                21.0, 33.0, 45.0);
        my $Z := $A.'gemm'(0.5, $A, $B, -10, $C);
        Assert::equal($Y, $Z, "gemm aAB does not work");
    }
}
