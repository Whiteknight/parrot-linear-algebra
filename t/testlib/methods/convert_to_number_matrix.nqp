class Pla::Methods::ConvertToNumberMatrix is Pla::MatrixTestBase {
    method test_convert_to_number_matrix() {
        my $A := self.factory.defaultmatrix2x2();
        my $B := $A.convert_to_number_matrix();
        assert_equal(pir::typeof__SP($B), "NumMatrix2D", "cannot convert");
        self.AssertSize($B, 2, 2);
    }

}
