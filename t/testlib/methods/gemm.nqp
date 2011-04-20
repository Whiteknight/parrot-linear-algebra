class Pla::Methods::Gemm is Pla::MatrixTestBase {
    method test_METHOD_gemm_aA() { $!context.factory.RequireOverride("test_METHOD_gemm_aA"); }
    method test_METHOD_gemm_AB() { self.RequireOverride("test_METHOD_gemm_AB"); }
    method test_METHOD_gemm_aAB() { self.RequireOverride("test_METHOD_gemm_aAB"); }
    method test_METHOD_gemm_aABbC() { self.RequireOverride("test_METHOD_gemm_aABbC"); }

    method test_bad_type_A() {
        Assert::throws("A is bad type",
        {
            my $A := "foobar";
            my $B := $!context.factory.defaultmatrix3x3();
            my $C := $!context.factory.defaultmatrix3x3();
            $B.gemm(1.0, $A, $B, 1.0, $C);
        });
    }

    method test_bad_type_B() {
        Assert::throws("B is bad type",
        {
            my $A := $!context.factory.defaultmatrix3x3();
            my $B := "foobar";
            my $C := $!context.factory.defaultmatrix3x3();
            $A.gemm(1.0, $A, $B, 1.0, $C);
        });
    }

    method test_bad_type_C() {
        Assert::throws("C is bad type",
        {
            my $A := $!context.factory.defaultmatrix3x3();
            my $B := $!context.factory.defaultmatrix3x3();
            my $C := "foobar";
            $A.gemm(1.0, $A, $B, 1.0, $C);
        });
    }

    method test_bad_size_A() {
        Assert::throws("A has incorrect size",
        {
            my $A := $!context.factory.defaultmatrix2x2();
            my $B := $!context.factory.defaultmatrix3x3();
            my $C := $!context.factory.defaultmatrix3x3();
            $A.gemm(1.0, $A, $B, 1.0, $C);
        });
    }

    method test_bad_size_B() {
        Assert::throws("B has incorrect size",
        {
            my $A := $!context.factory.defaultmatrix3x3();
            my $B := $!context.factory.defaultmatrix2x2();
            my $C := $!context.factory.defaultmatrix3x3();
            $A.gemm(1.0, $A, $B, 1.0, $C);
        });
    }

    method test_bad_size_C() {
        Assert::throws("C has incorrect size",
        {
            my $A := $!context.factory.defaultmatrix3x3();
            my $B := $!context.factory.defaultmatrix3x3();
            my $C := $!context.factory.defaultmatrix2x2();
            $A.gemm(1.0, $A, $B, 1.0, $C);
        });
    }

    # Tests that for the current type, when we call GEMM the values and
    # results are converted to this type
    method __test_gemm_autoconvert($Af, $Bf, $Cf) {
        my $m := $!context.factory.defaultmatrix2x2();
        my $A := $Af.fancymatrix2x2();
        my $B := $Bf.fancymatrix2x2();
        my $C := $Cf.fancymatrix2x2();
        my $alpha := $!context.factory.fancyvalue(0);
        my $beta := $!context.factory.fancyvalue(0);
        my $D := $m.gemm($alpha, $A, $B, $beta, $C);
        my $type_D := pir::typeof__SP($D);
        my $type_m := pir::typeof__SP($m);
        Assert::equal($type_D, $type_m,
            "not the right type. Found " ~ $type_D ~ " expected " ~ $type_m);
    }

    method test_autoconvert_A_NumMatrix2D() {
        my $factory := Pla::MatrixFactory::NumMatrix2D.new();
        self.__test_gemm_autoconvert($factory, $!context.factory, self.factory);
    }

    method test_autoconvert_B_NumMatrix2D() {
        my $factory := Pla::MatrixFactory::NumMatrix2D.new();
        self.__test_gemm_autoconvert($!context.factory, $factory, self.factory);
    }

    method test_autoconvert_C_NumMatrix2D() {
        my $factory := Pla::MatrixFactory::NumMatrix2D.new();
        self.__test_gemm_autoconvert($!context.factory, self.factory, $factory);
    }

    method test_autoconvert_A_ComplexMatrix2D() {
        my $factory := Pla::MatrixFactory::ComplexMatrix2D.new();
        self.__test_gemm_autoconvert($factory, $!context.factory, self.factory);
    }

    method test_autoconvert_B_ComplexMatrix2D() {
        my $factory := Pla::MatrixFactory::ComplexMatrix2D.new();
        self.__test_gemm_autoconvert($!context.factory, $factory, self.factory);
    }

    method test_autoconvert_C_ComplexMatrix2D() {
        my $factory := Pla::MatrixFactory::ComplexMatrix2D.new();
        self.__test_gemm_autoconvert($!context.factory, self.factory, $factory);
    }

    method test_autoconvert_A_PMCMatrix2D() {
        my $factory := Pla::MatrixFactory::PMCMatrix2D.new();
        self.__test_gemm_autoconvert($factory, $!context.factory, self.factory);
    }
    method test_autoconvert_B_PMCMatrix2D() {
        my $factory := Pla::MatrixFactory::PMCMatrix2D.new();
        self.__test_gemm_autoconvert($!context.factory, $factory, self.factory);
    }
    method test_autoconvert_C_PMCMatrix2D() {
        my $factory := Pla::MatrixFactory::PMCMatrix2D.new();
        self.__test_gemm_autoconvert($!context.factory, self.factory, $factory);
    }
}
