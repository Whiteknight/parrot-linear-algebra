my $tests := Test::ComplexMatrix2D::Transpose.new();
$tests.suite.run;

class Test::ComplexMatrix2D::Transpose is Pla::Methods::Transpose {
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
        $m.transpose();
        assert_equal($n, $m, "cannot transpose complex matrix");
    }

    method test_non_square_matrix_complex() {
        my $m := self.factory.matrix();
        $m{Key.new(0,0)} := "1+1i";
        $m{Key.new(0,1)} := "2+2i";
        $m{Key.new(0,2)} := "3+3i";
        $m{Key.new(0,3)} := "4+4i";

        my $n := self.factory.matrix();
        $n{Key.new(0,0)} := "1+1i";
        $n{Key.new(1,0)} := "2+2i";
        $n{Key.new(2,0)} := "3+3i";
        $n{Key.new(3,0)} := "4+4i";

        $m.transpose();
        assert_equal($m, $n, "cannot transpose complex matrix with non-square dimensions");
    }
}
