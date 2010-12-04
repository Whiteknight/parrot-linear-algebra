my $tests := Test::ComplexMatrix2D::InitializeFromArgs.new();
$tests.suite.run;

class Test::ComplexMatrix2D::InitializeFromArgs is Pla::Methods::InitializeFromArgs {
    INIT {
        use('UnitTest::Testcase');
        use('UnitTest::Assertions');
    }

    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::ComplexMatrix2D.new();
        }
        return $!factory;
    }
    
    method test_initialize_from_args_complex() {
        my $m := self.factory.matrix2x2("1+1i", "2+2i",
                                "3+3i", "4+4i");
        my $n := self.factory.matrix();
        $n.initialize_from_args(2, 2, "1+1i", "2+2i",
                                      "3+3i", "4+4i");
        assert_equal($n, $m, "cannot initialize_from_args with complex matrix");
    }

	method test_initialize_from_args_array() {
        my $m := self.factory.matrix2x2("1+1i", "2+2i",
                                "3+3i", "4+4i");
        my $n := self.factory.matrix();
        $n.initialize_from_args(2, 2, (1,1), (2,2),
                                      (3,3), (4,4));
        assert_equal($n, $m, "cannot initialize_from_args with array");
    }

    method test_null_pad_extra_spaces_complex() {
        my $m := self.factory.matrix3x3("1+1i", "2+2i", "3+3i",
                                "4+4i", self.factory.nullvalue,     self.factory.nullvalue,
                                self.factory.nullvalue,     self.factory.nullvalue,     self.factory.nullvalue);
        my $n := self.factory.matrix();
        $n.initialize_from_args(3, 3, "1+1i", "2+2i", "3+3i",
                                      "4+4i");
        assert_equal($n, $m, "cannot initalize from args with zero padding with complex matrix");
    }

    method test_ignore_extra_values_complex() {
        my $m := self.factory.matrix();
        $m{Key.new(0,0)} := "1+1i";
        my $n := self.factory.matrix();
        $n.initialize_from_args(1, 1, "1+1i", "2+2i",
                                      "3+3i", "4+4i");
        assert_equal($n, $m, "cannot initialize from args undersized with complex matrix");
    }
}
