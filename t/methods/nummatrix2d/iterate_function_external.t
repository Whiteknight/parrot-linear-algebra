my $tests := Test::NumMatrix2D::IterateFunctionExternal.new();
$tests.suite.run;

class Test::NumMatrix2D::IterateFunctionExternal is Pla::Methods::IterateFunctionExternal {
    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::NumMatrix2D.new();
        }
        return $!factory;
    }
}
