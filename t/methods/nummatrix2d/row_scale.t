Rosella::Testcase::test(Test::NumMatrix2D::RowScale);

class Test::NumMatrix2D::RowScale is Pla::Methods::RowScale {

    has $!factory;

    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::NumMatrix2D.new();
        }
        return $!factory;
    }
}
