Rosella::Test::test(Test::ComplexMatrix2D::IterateFunctionInplace);

class Test::ComplexMatrix2D::IterateFunctionInplace is Pla::Methods::IterateFunctionInplace {
    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::ComplexMatrix2D.new();
        }
        return $!factory;
    }
}
