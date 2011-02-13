my $tests := Test::PMCMatrix2D::IterateFunctionInplace.new();
$tests.suite.run;

class Test::PMCMatrix2D::IterateFunctionInplace is Pla::Methods::IterateFunctionInplace {
    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::PMCMatrix2D.new();
        }
        return $!factory;
    }
}
