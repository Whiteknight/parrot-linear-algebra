Rosella::Test::test(Test::ComplexMatrix2D::RowScale);

class Test::ComplexMatrix2D::RowScale is Pla::Methods::RowScale {
    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::ComplexMatrix2D.new();
        }
        return $!factory;
    }
}
