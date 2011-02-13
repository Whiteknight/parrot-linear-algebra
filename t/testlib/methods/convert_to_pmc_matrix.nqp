class Pla::Methods::ConvertToPmcMatrix is Pla::MatrixTestBase {
    method test_convert_to_pmc_matrix() {
        my $A := self.factory.defaultmatrix2x2();
        my $B := $A.convert_to_pmc_matrix();
        assert_equal(pir::typeof__SP($B), "PMCMatrix2D", "cannot convert");
        self.AssertSize($B, 2, 2);
    }
}
