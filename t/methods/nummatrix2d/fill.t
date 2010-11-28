my $tests := Test::NumMatrix2D::Fill.new();
$tests.suite.run;

class Test::NumMatrix2D::Fill is Pla::Methods::Fill {
    INIT {
        use('UnitTest::Testcase');
        use('UnitTest::Assertions');
    }

    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::NumMatrix2D.new();
        }
        return $!factory;
    }

	method test_fill_numerical() {
		my $m := self.factory.defaultmatrix2x2();
		my $n := self.factory.matrix2x2(4, 4, 4, 4);

		$m.fill(4);

		assert_equal($m, $n, "cannot fill numerical");
	}

	method test_fill_with_resizing_numerical() {
	    my $m := self.factory.matrix();
	    my $n := self.factory.matrix3x3(2, 2, 2, 
									    2, 2, 2, 
									    2, 2, 2);

	    $m.fill(3, 3, 2);

	    assert_equal($m, $n, "cannot fill (with resize) numerical");
	}
}
