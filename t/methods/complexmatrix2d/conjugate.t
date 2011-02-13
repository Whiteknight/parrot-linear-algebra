my $tests := Test::ComplexMatrix2D::Conjugate.new();
$tests.suite.run;

class Test::ComplexMatrix2D::Conjugate is Pla::MatrixTestBase {
    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::ComplexMatrix2D.new();
        }
        return $!factory;
    }

    method test_conjugate() {
        my $m := self.factory.matrix2x2("1+1i", "2+2i", "3+3i", "4+4i");
        my $n := self.factory.matrix2x2("1-1i", "2-2i", "3-3i", "4-4i");
        $m.conjugate();
        Assert::equal($m, $n, "conjugate does not work");
    }

    method test_conjugate_non_square() {
        my $m := self.factory.matrix();
        $m{self.factory.key(0,0)} := "1+1i";
        $m{self.factory.key(0,1)} := "2+2i";
        $m{self.factory.key(0,2)} := "3+3i";
        $m{self.factory.key(0,3)} := "4+4i";

        my $n := self.factory.matrix();
        $n{self.factory.key(0,0)} := "1-1i";
        $n{self.factory.key(0,1)} := "2-2i";
        $n{self.factory.key(0,2)} := "3-3i";
        $n{self.factory.key(0,3)} := "4-4i";

        $m.conjugate();
        Assert::equal($m, $n, "non-square conjugate does not work");
    }
}
