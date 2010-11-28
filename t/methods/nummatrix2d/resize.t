my $tests := Test::NumMatrix2D::Resize.new();
$tests.suite.run;

class Test::NumMatrix2D::Resize is Pla::Methods::Resize {
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

	  # resize method should never shrink a matrix
	  method test_resize_to_smaller_numerical() {
	      my $m := self.factory.matrix3x3(11, 12, 13,
									                      21, 22, 23,
									                      31, 32, 33);

	      my $n := pir::clone($m);

	      $m.resize(1,1);

	      assert_equal($m, $n, "resize should not shrink the matrix");
	  }

	  method test_resize_to_bigger_numerical() {
		    my $m := self.factory.matrix2x2(11, 12,
										                    21, 22);

		    my $n := self.factory.matrix3x3(11, 12,  0,
										                    21, 22,  0,
										                     0,  0,  0);

		    $m.resize(3,3);

		    assert_equal($m, $n, "cannot resize with numerical matrix"); 
	  }
	
	  method test_resize_to_same_size_numerical() {
		    my $m := self.factory.matrix2x2(11, 12,
										    21, 22);

		    my $n := pir::clone($m);

		    $n.resize(2,2);

		    assert_equal($m, $n, "resize to same size is changing numerical matrix"); 
	  }
}
