Rosella::Testcase::test(Test::PMCMatrix2D::ItemAt);

class Test::PMCMatrix2D::ItemAt is Pla::Methods::ItemAt {
    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::PMCMatrix2D.new();
        }
        return $!factory;
    }
}
