my $tests := Test::ComplexMatrix2D::ConvertToPmcMatrix.new();
$tests.suite.run;

class Test::ComplexMatrix2D::ConvertToPmcMatrix is Pla::Methods::ConvertToPmcMatrix {
    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::ComplexMatrix2D.new();
        }
        return $!factory;
    }
}
