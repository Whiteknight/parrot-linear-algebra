class Pla::Methods::Gemm is Pla::MatrixTestBase {

    INIT {
        use('UnitTest::Testcase');
        use('UnitTest::Assertions');
    }

    method test_METHOD_gemm_aA() { self.factory.RequireOverride("test_METHOD_gemm_aA"); }
    method test_METHOD_gemm_AB() { self.RequireOverride("test_METHOD_gemm_AB"); }
    method test_METHOD_gemm_aAB() { self.RequireOverride("test_METHOD_gemm_aAB"); }
    method test_METHOD_gemm_aABbC() { self.RequireOverride("test_METHOD_gemm_aABbC"); }

    method test_METHOD_gemm_BADTYPE_A() {
        assert_throws(Exception::OutOfBounds, "A is bad type",
        {
            my $A := "foobar";
            my $B := self.factory.defaultmatrix3x3();
            my $C := self.factory.defaultmatrix3x3();
            $B.gemm(1.0, $A, $B, 1.0, $C);
        });
    }

    method test_METHOD_gemm_BADTYPE_B() {
        assert_throws(Exception::OutOfBounds, "B is bad type",
        {
            my $A := self.factory.defaultmatrix3x3();
            my $B := "foobar";
            my $C := self.factory.defaultmatrix3x3();
            $A.gemm(1.0, $A, $B, 1.0, $C);
        });
    }

    method test_METHOD_gemm_BADTYPE_C() {
        assert_throws(Exception::OutOfBounds, "C is bad type",
        {
            my $A := self.factory.defaultmatrix3x3();
            my $B := self.factory.defaultmatrix3x3();
            my $C := "foobar";
            $A.gemm(1.0, $A, $B, 1.0, $C);
        });
    }

    method test_METHOD_gemm_BADSIZE_A() {
        assert_throws(Exception::OutOfBounds, "A has incorrect size",
        {
            my $A := self.factory.defaultmatrix2x2();
            my $B := self.factory.defaultmatrix3x3();
            my $C := self.factory.defaultmatrix3x3();
            $A.gemm(1.0, $A, $B, 1.0, $C);
        });
    }

    method test_METHOD_gemm_BADSIZE_B() {
        assert_throws(Exception::OutOfBounds, "B has incorrect size",
        {
            my $A := self.factory.defaultmatrix3x3();
            my $B := self.factory.defaultmatrix2x2();
            my $C := self.factory.defaultmatrix3x3();
            $A.gemm(1.0, $A, $B, 1.0, $C);
        });
    }

    method test_METHOD_gemm_BADSIZE_C() {
        assert_throws(Exception::OutOfBounds, "C has incorrect size",
        {
            my $A := self.factory.defaultmatrix3x3();
            my $B := self.factory.defaultmatrix3x3();
            my $C := self.factory.defaultmatrix2x2();
            $A.gemm(1.0, $A, $B, 1.0, $C);
        });
    }

    method test_METHOD_gemm_AUTOCONVERT_A_NumMatrix2D() { todo("Write this!"); }
    method test_METHOD_gemm_AUTOCONVERT_B_NumMatrix2D() { todo("Write this!"); }
    method test_METHOD_gemm_AUTOCONVERT_C_NumMatrix2D() { todo("Write this!"); }

    method test_METHOD_gemm_AUTOCONVERT_A_ComplexMatrix2D() { todo("Write this!"); }
    method test_METHOD_gemm_AUTOCONVERT_B_ComplexMatrix2D() { todo("Write this!"); }
    method test_METHOD_gemm_AUTOCONVERT_C_ComplexMatrix2D() { todo("Write this!"); }

    method test_METHOD_gemm_AUTOCONVERT_A_PMCMatrix2D() { todo("Write this!"); }
    method test_METHOD_gemm_AUTOCONVERT_B_PMCMatrix2D() { todo("Write this!"); }
    method test_METHOD_gemm_AUTOCONVERT_C_PMCMatrix2D() { todo("Write this!"); }

}