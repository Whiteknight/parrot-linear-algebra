class Pla::Methods::ConvertToPmcMatrix is Pla::MatrixTestBase {
    method test_convert_to_pmc_matrix() {
        my $A := $!context.factory.defaultmatrix2x2();
        my $B := $A.convert_to_pmc_matrix();
        Assert::equal(pir::typeof__SP($B), "PMCMatrix2D", "cannot convert");
        Assert::Size($B, 2, 2);
    }
}
