my $tests := Test::PMCMatrix2D::ConvertToComplexMatrix.new();
$tests.suite.run;

class Test::PMCMatrix2D::ConvertToComplexMatrix is Pla::Methods::ConvertToComplexMatrix {
    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::PMCMatrix2D.new();
        }
        return $!factory;
    }
}
