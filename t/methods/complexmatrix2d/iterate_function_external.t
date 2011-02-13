my $tests := Test::ComplexMatrix2D::IterateFunctionExternal.new();
$tests.suite.run;

class Test::ComplexMatrix2D::IterateFunctionExternal is Pla::Methods::IterateFunctionExternal {
    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::ComplexMatrix2D.new();
        }
        return $!factory;
    }
}
