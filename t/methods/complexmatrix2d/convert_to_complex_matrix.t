my $tests := Test::ComplexMatrix2D::ConvertToComplexMatrix.new();
$tests.suite.run;

class Test::ComplexMatrix2D::ConvertToComplexMatrix is Pla::Methods::ConvertToComplexMatrix {
    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::ComplexMatrix2D.new();
        }
        return $!factory;
    }
}
