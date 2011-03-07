Rosella::Test::test(Test::ComplexMatrix2D::Resize);

class Test::ComplexMatrix2D::Resize is Pla::Methods::Resize {

    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::ComplexMatrix2D.new();
        }
        return $!factory;
    }
}
