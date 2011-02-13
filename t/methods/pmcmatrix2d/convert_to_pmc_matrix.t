my $tests := Test::PMCMatrix2D::ConvertToPmcMatrix.new();
$tests.suite.run;

class Test::PMCMatrix2D::ConvertToPmcMatrix is Pla::Methods::ConvertToPmcMatrix {
    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::PMCMatrix2D.new();
        }
        return $!factory;
    }
}
