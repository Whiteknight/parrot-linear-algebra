my $tests := Test::NumMatrix2D::ItemAt.new();
$tests.suite.run;

class Test::NumMatrix2D::ItemAt is Pla::Methods::ItemAt {
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

	method test_get_item_at_numerical() {
		my $m := self.factory.matrix2x2(11, 12,
										21, 22);
		
		my $expected := 22;

		assert_equal($m.item_at(1,1), $expected, "cannot item_at with numerical matrix");
	}

	method test_get_item_at_out_of_bounds_numerical() {
		my $m := self.factory.matrix2x2(11, 12,
										21, 22);
		
		assert_throws(Exception::OutOfBounds, "can item_at out of bounds",
        {
            $m.item_at(2, 2);
        });	
	}

	method test_set_item_at_numerical() {
		my $m := self.factory.matrix2x2(11, 12,
										21, 22);
		
		$m.item_at(0, 0, 99);

		assert_equal($m.item_at(0,0), 99, "cannot set item_at with numerical matrix");
	}
	
	method test_set_item_at_out_of_bounds_numerical() {
		my $m := self.factory.matrix2x2(11, 12,
										21, 22);
		
		assert_throws(Exception::OutOfBounds, "can item_at out of bounds",
        {
            $m.item_at(2, 2, 99);
        });	
	}
	
	method test_set_item_at_negative_index_numerical() {
		my $m := self.factory.matrix2x2(11, 12,
										21, 22);
		
		assert_throws(Exception::OutOfBounds, "can item_at out of bounds (negative index)",
        {
            $m.item_at(-1, -1, 99);
        });	
	}
}

