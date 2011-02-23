Rosella::Testcase::test(Test::PMCMatrix2D::InitializeFromArray);

class Test::PMCMatrix2D::InitializeFromArray is Pla::Methods::InitializeFromArray {
    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::PMCMatrix2D.new();
        }
        return $!factory;
    }
}
