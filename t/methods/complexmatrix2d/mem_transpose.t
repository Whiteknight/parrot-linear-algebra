my $tests := Test::ComplexMatrix2D::MemTranspose.new();
$tests.suite.run;

class Test::ComplexMatrix2D::MemTranspose is Pla::Methods::MemTranspose {
    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::ComplexMatrix2D.new();
        }
        return $!factory;
    }

    method test_mem_transpose_complex() {
        my $m := self.factory.matrix2x2(
            "1+1i",
            "2+2i",
            "3+3i",
            "4+4i"
        );
        my $n := self.factory.matrix2x2(
            "1+1i",
            "3+3i",
            "2+2i",
            "4+4i"
        );
        $m.mem_transpose();
        Assert::equal($n, $m, "cannot mem_transpose complex matrix");
    }

    method test_non_square_matrix_complex() {
        my $m := self.factory.matrix();
        $m{self.factory.key(0,0)} := "1+1i";
        $m{self.factory.key(0,1)} := "2+2i";
        $m{self.factory.key(0,2)} := "3+3i";
        $m{self.factory.key(0,3)} := "4+4i";

        my $n := self.factory.matrix();
        $n{self.factory.key(0,0)} := "1+1i";
        $n{self.factory.key(1,0)} := "2+2i";
        $n{self.factory.key(2,0)} := "3+3i";
        $n{self.factory.key(3,0)} := "4+4i";

        $m.mem_transpose();
        Assert::equal($m, $n, "cannot mem_transpose complex matrix with non-square dimensions");
    }
}
