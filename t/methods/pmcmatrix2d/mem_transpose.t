Rosella::Test::test(Test::PMCMatrix2D::MemTranspose);

class Test::PMCMatrix2D::MemTranspose is Pla::Methods::MemTranspose {
    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::PMCMatrix2D.new();
        }
        return $!factory;
    }
}
