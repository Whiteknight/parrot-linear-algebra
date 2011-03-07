Rosella::Test::test(Test::NumMatrix2D::RowSwap);

class Test::NumMatrix2D::RowSwap is Pla::Methods::RowSwap {

    has $!factory;

    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::NumMatrix2D.new();
        }
        return $!factory;
    }
}
