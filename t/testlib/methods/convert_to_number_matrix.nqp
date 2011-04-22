class Pla::Methods::ConvertToNumberMatrix is Pla::MatrixTestBase {
    method test_convert_to_number_matrix() {
        my $A := $!context.factory.defaultmatrix2x2();
        my $B := $A.convert_to_number_matrix();
        Assert::equal(pir::typeof__SP($B), "NumMatrix2D", "cannot convert");
        Assert::Size($B, 2, 2);
    }

}
