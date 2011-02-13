my $tests := Test::ComplexMatrix2D::RowScale.new();
$tests.suite.run;

class Test::ComplexMatrix2D::RowScale is Pla::Methods::RowScale {
    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::ComplexMatrix2D.new();
        }
        return $!factory;
    }
}
