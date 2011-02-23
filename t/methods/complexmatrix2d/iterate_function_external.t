Rosella::Testcase::test(Test::ComplexMatrix2D::IterateFunctionExternal);

class Test::ComplexMatrix2D::IterateFunctionExternal is Pla::Methods::IterateFunctionExternal {
    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::ComplexMatrix2D.new();
        }
        return $!factory;
    }
}
