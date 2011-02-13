my $tests := Test::PMCMatrix2D::IterateFunctionExternal.new();
$tests.suite.run;

class Test::PMCMatrix2D::IterateFunctionExternal is Pla::Methods::IterateFunctionExternal {

    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::PMCMatrix2D.new();
        }
        return $!factory;
    }
}
