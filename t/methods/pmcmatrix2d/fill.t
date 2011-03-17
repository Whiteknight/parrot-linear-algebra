Rosella::Test::test(Test::PMCMatrix2D::Fill);

class Test::PMCMatrix2D::Fill is Pla::Methods::Fill {
    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::PMCMatrix2D.new();
        }
        return $!factory;
    }
}
