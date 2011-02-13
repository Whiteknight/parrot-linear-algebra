my $tests := Test::ComplexMatrix2D::IterateFunctionInplace.new();
$tests.suite.run;

class Test::ComplexMatrix2D::IterateFunctionInplace is Pla::Methods::IterateFunctionInplace {
    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::ComplexMatrix2D.new();
        }
        return $!factory;
    }
}
