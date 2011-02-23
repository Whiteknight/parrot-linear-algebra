Rosella::Testcase::test(Test::ComplexMatrix2D::RowSwap);

class Test::ComplexMatrix2D::RowSwap is Pla::Methods::RowSwap {

    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::ComplexMatrix2D.new();
        }
        return $!factory;
    }
}
