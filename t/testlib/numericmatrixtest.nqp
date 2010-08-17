
class Pla::Matrix::NumericMatrixTest is Pla::Matrix::MatrixTest {

    INIT {
        use('UnitTest::Testcase');
        use('UnitTest::Assertions');
    }

    # Test that a numeric matrix does numericmatrix
    method test_OP_does_Matrix() {
        my $m := self.matrix();
        assert_true(pir::does($m, "numericmatrix"), "Does not do numericmatrix");
    }

    # Test that all core matrix types have some common methods
    method test_MISC_have_NumericMatrix_role_methods() {
        my $m := self.matrix();
        # Core matrix types should all have these methods in common.
        # Individual types may have additional methods. The signatures for
        # these will change depending on the type, so we don't check those
        # here.
        self.AssertHasMethod($m, "gemm");
        self.AssertHasMethod($m, "row_combine");
        self.AssertHasMethod($m, "row_scale");
        self.AssertHasMethod($m, "row_swap");
    }
}