Rosella::Test::test(Test::PMCMatrix2D::IterateFunctionExternal);

class Test::PMCMatrix2D::IterateFunctionExternal is Pla::Methods::IterateFunctionExternal {

    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::PMCMatrix2D.new();
        }
        return $!factory;
    }
}
