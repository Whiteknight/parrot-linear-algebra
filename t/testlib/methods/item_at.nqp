class Pla::Methods::ItemAt is Pla::MatrixTestBase {

    INIT {
        use('UnitTest::Testcase');
        use('UnitTest::Assertions');
    }

    method test_item_at() {
        my $m := self.factory.fancymatrix2x2();
        assert_equal(self.factory.fancyvalue(0), $m.item_at(0, 0), "cannot get item 0,0");
        assert_equal(self.factory.fancyvalue(1), $m.item_at(0, 1), "cannot get item 0,1");
        assert_equal(self.factory.fancyvalue(2), $m.item_at(1, 0), "cannot get item 1,0");
        assert_equal(self.factory.fancyvalue(3), $m.item_at(1, 1), "cannot get item 1,1");
    }

    method test_out_of_bounds_index_A() {
        my $m := self.factory.defaultmatrix2x2();
        assert_throws(Exception::OutOfBounds, "can item_at out of bounds",
        {
            $m.item_at(1, 4);
        });
    }

    method test_out_of_bounds_index_B() {
        my $m := self.factory.defaultmatrix2x2();
        assert_throws(Exception::OutOfBounds, "can item_at out of bounds",
        {
            $m.item_at(4, 1);
        });
    }

    method test_negative_index_A() {
        my $m := self.factory.defaultmatrix2x2();
        assert_throws(Exception::OutOfBounds, "can item_at out of bounds",
        {
            $m.item_at(-1, 0);
        });
    }

    method test_negative_index_B() {
        my $m := self.factory.defaultmatrix2x2();
        assert_throws(Exception::OutOfBounds, "can item_at out of bounds",
        {
            $m.item_at(0, -1);
        });
    }

    method test_item_from_empty_matrix() {
        my $m := self.factory.matrix();
        assert_throws(Exception::OutOfBounds, "can item_at out of bounds",
        {
            $m.item_at(0, 0);
        });
    }

    method test_set_optional_third_parameter() {
        my $m := self.factory.fancymatrix2x2();
        my $n := self.factory.fancymatrix2x2();
        $n{Key.new(1, 1)} := self.factory.fancyvalue(0);
        $m.item_at(1, 1, self.factory.fancyvalue(0));
        assert_equal($m, $n, "item_at(VALUE) does not work like keyed access");
    }

    method test_set_out_of_bounds_index_A() {
        my $m := self.factory.defaultmatrix2x2();
        assert_throws(Exception::OutOfBounds, "can item_at out of bounds",
        {
            $m.item_at(4, 1, self.factory.fancyvalue(0));
        });
    }

    method test_set_out_of_bounds_index_B() {
        my $m := self.factory.defaultmatrix2x2();
        assert_throws(Exception::OutOfBounds, "can item_at out of bounds",
        {
            $m.item_at(1, 4, self.factory.fancyvalue(0));
        });
    }

    method test_set_at_negative_index_A() {
        my $m := self.factory.defaultmatrix2x2();
        assert_throws(Exception::OutOfBounds, "can item_at out of bounds",
        {
            $m.item_at(-1, -1, self.factory.fancyvalue(0));
        });
    }

    method test_set_at_negative_index_B() {
        my $m := self.factory.defaultmatrix2x2();
        assert_throws(Exception::OutOfBounds, "can item_at out of bounds",
        {
            $m.item_at(-1, -1, self.factory.fancyvalue(0));
        });
    }

    method test_set_empty_matrix_does_not_grow() {
        my $m := self.factory.matrix();
        assert_throws(Exception::OutOfBounds, "can item_at out of bounds",
        {
            $m.item_at(0, 0, self.factory.fancyvalue(0));
        });
    }


}
