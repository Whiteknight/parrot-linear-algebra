my $tests := Test::NumMatrix2D::Transpose.new();
$tests.suite.run;

class Test::NumMatrix2D::Transpose is Pla::Methods::Transpose {
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

	  method test_transpose_square_numerical() {
		    my $m := self.factory.matrix2x2(
				    11, 12,
				    21, 22
		    );	

		    my $n := self.factory.matrix2x2(
				    11, 21,
				    12, 22
		    );

		    $m.transpose();
		    assert_equal($m, $n, "cannot tranpose numerical");
	  }
	
	  method test_non_square_tranpose_numerical() {
		    my $m := self.factory.matrix();
		    $m{Key.new(0,0)} := 11;
		    $m{Key.new(0,1)} := 12;
		    $m{Key.new(0,2)} := 13;
		    $m{Key.new(1,0)} := 21;
		    $m{Key.new(1,1)} := 22;
		    $m{Key.new(1,2)} := 23;
		
		    my $n := self.factory.matrix();
		    $n{Key.new(0,0)} := 11;
		    $n{Key.new(0,1)} := 21;
		    $n{Key.new(1,0)} := 12;
		    $n{Key.new(1,1)} := 22;
		    $n{Key.new(2,0)} := 13;
		    $n{Key.new(2,1)} := 23;

		    $m.transpose();
		    assert_equal($m, $n, "cannot transpose numerical matrix with non-square dimensions");
	  }
}		
