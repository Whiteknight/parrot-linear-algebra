my $tests := Test::ComplexMatrix2D::ItemAt.new();
$tests.suite.run;

class Test::ComplexMatrix2D::ItemAt is Pla::Methods::ItemAt {
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

    method test_set_optional_third_parameter_complex() {
        my $m := self.factory.defaultmatrix2x2();
        my $n := self.factory.defaultmatrix2x2();
        $n{Key.new(1, 1)} := "1+1i";
        $m.item_at(1, 1, "1+1i");
        assert_equal($m, $n, "item_at(VALUE) does not work like keyed access");
    }

    method test_set_out_of_bounds_index_complex_A() {
        my $m := self.factory.defaultmatrix2x2();
        assert_throws(Exception::OutOfBounds, "can item_at out of bounds",
        {
            $m.item_at(4, 1, "1+1i");
        });
    }

    method test_set_out_of_bounds_index_complex_B() {
        my $m := self.factory.defaultmatrix2x2();
        assert_throws(Exception::OutOfBounds, "can item_at out of bounds",
        {
            $m.item_at(1, 4, "1+1i");
        });
    }

    method test_set_at_negative_index_complex_A() {
        my $m := self.factory.defaultmatrix2x2();
        assert_throws(Exception::OutOfBounds, "can item_at out of bounds",
        {
            $m.item_at(-1, -1, "1+1i");
        });
    }

    method test_set_at_negative_index_complex_B() {
        my $m := self.factory.defaultmatrix2x2();
        assert_throws(Exception::OutOfBounds, "can item_at out of bounds",
        {
            $m.item_at(-1, -1, "1+1i");
        });
    }

    method test_set_empty_matrix_does_not_grow_complex() {
        my $m := self.factory.matrix();
        assert_throws(Exception::OutOfBounds, "can item_at out of bounds",
        {
            $m.item_at(0, 0, "1+1i");
        });
    }
}
