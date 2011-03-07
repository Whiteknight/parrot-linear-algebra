Rosella::Test::test(Test::PMCMatrix2D::IterateFunctionInplace);

class Test::PMCMatrix2D::IterateFunctionInplace is Pla::Methods::IterateFunctionInplace {
    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::PMCMatrix2D.new();
        }
        return $!factory;
    }
}
