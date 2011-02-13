class Pla::Methods::ConvertToComplexMatrix is Pla::MatrixTestBase {
    method test_convert_to_complex_matrix() {
        my $A := self.factory.defaultmatrix2x2();
        my $B := $A.convert_to_complex_matrix();
        Assert::equal(pir::typeof__SP($B), "ComplexMatrix2D", "cannot convert");
        self.AssertSize($B, 2, 2);
    }

}
