Rosella::Testcase::test(Test::PMCMatrix2D::Resize);

class Test::PMCMatrix2D::Resize is Pla::Methods::Resize {
    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::PMCMatrix2D.new();
        }
        return $!factory;
    }
}
