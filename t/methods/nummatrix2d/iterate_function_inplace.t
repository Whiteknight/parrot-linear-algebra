Rosella::Test::test(Test::NumMatrix2D::IterateFunctionInplace);

class Test::NumMatrix2D::IterateFunctionInplace is Pla::Methods::IterateFunctionInplace {

    has $!factory;

    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::NumMatrix2D.new();
        }
        return $!factory;
    }
}
