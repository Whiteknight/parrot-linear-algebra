class Pla::Methods::ConvertToComplexMatrix is Pla::MatrixTestBase {
    method test_convert_to_complex_matrix() {
        my $A := $!context.factory.defaultmatrix2x2();
        my $B := $A.convert_to_complex_matrix();
        $!assert.equal(pir::typeof__SP($B), "ComplexMatrix2D", "cannot convert");
        $!assert.Size($B, 2, 2);
    }
}
