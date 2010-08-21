class Pla::Methods::SetBlock is Pla::MatrixTestBase {

    INIT {
        use('UnitTest::Testcase');
        use('UnitTest::Assertions');
    }

    # Test set_block
    method test_set_block() {
        my $m := self.factory.fancymatrix2x2();
        my $n := self.factory.matrix();
        $n{Key.new(2,2)} := self.factory.nullvalue;
        $n.set_block(1, 1, $m);

        # First, prove that we haven't resized it
        self.AssertSize($n, 3, 3);

        # Second, let's prove that nothing was set where it doesn't belong.
        self.AssertNullValueAt($n, 0, 0);
        self.AssertNullValueAt($n, 1, 0);
        self.AssertNullValueAt($n, 2, 0);
        self.AssertNullValueAt($n, 0, 1);
        self.AssertNullValueAt($n, 0, 2);

        # Third, prove that the block was set properly
        assert_equal($n{Key.new(1,1)}, $m{Key.new(0,0)}, "value was set in wrong place");
        assert_equal($n{Key.new(1,2)}, $m{Key.new(0,1)}, "value was set in wrong place");
        assert_equal($n{Key.new(2,1)}, $m{Key.new(1,0)}, "value was set in wrong place");
        assert_equal($n{Key.new(2,2)}, $m{Key.new(1,1)}, "value was set in wrong place");
    }

    # Test set_block with a block of zero size
    method test_zero_size_block() {
        my $m := self.factory.fancymatrix2x2();
        my $n := pir::clone__PP($m);
        my $o := self.factory.matrix();
        $m.set_block(0, 0, $o);
        assert_equal($m, $n, "zero-size block insert changes the matrix");
    }

    # set_block with a zero-sized block resizes the matrix, but to one less
    # than might otherwise be expected. The first element of the block would
    # go to the specified coordinates, but there is no first element so there
    # is no item at the specified coordinates. Think of the block as a
    # zero-sized point to the upper-left of the coordinate.
    method test_zero_size_block_outside_bounds() {
        my $m := self.factory.defaultmatrix2x2();
        my $o := self.factory.matrix();
        $m.set_block(3, 3, $o);
        self.AssertSize($m, 3, 3);
        self.AssertNullValueAt($m, 2, 0);
        self.AssertNullValueAt($m, 2, 1);
        self.AssertNullValueAt($m, 2, 2);
        self.AssertNullValueAt($m, 1, 2);

        self.AssertValueAtIs($m, 0, 0, self.factory.defaultvalue);
        self.AssertValueAtIs($m, 0, 1, self.factory.defaultvalue);
        self.AssertValueAtIs($m, 1, 0, self.factory.defaultvalue);
        self.AssertValueAtIs($m, 1, 1, self.factory.defaultvalue);
    }

    # Test that set_block can resize the matrix if the specified coordinates
    # are outside the matrix
    method test_resize_with_block_outside_bounds() {
        my $m := self.factory.defaultmatrix2x2();
        my $o := self.factory.matrix();
        $o{Key.new(0, 0)} := self.factory.fancyvalue(2);
        $m.set_block(2, 2, $o);
        self.AssertSize($m, 3, 3);

        self.AssertValueAtIs($m, 0, 0, self.factory.defaultvalue);
        self.AssertValueAtIs($m, 0, 1, self.factory.defaultvalue);
        self.AssertValueAtIs($m, 1, 0, self.factory.defaultvalue);
        self.AssertValueAtIs($m, 1, 1, self.factory.defaultvalue);

        self.AssertNullValueAt($m, 2, 0);
        self.AssertNullValueAt($m, 2, 1);
        self.AssertNullValueAt($m, 0, 2);
        self.AssertNullValueAt($m, 1, 2);

        self.AssertValueAtIs($m, 2, 2, self.factory.fancyvalue(2));
    }

    # Test that set_block can resize the matrix if the specified coordinates
    # are outside the matrix
    method test_block_larger_than_matrix() {
        my $m := self.factory.defaultmatrix2x2();
        my $o := self.factory.defaultmatrix2x2();
        my $n := self.factory.matrix3x3(self.factory.defaultvalue, self.factory.defaultvalue, self.factory.nullvalue,
                                self.factory.defaultvalue, self.factory.defaultvalue, self.factory.defaultvalue,
                                self.factory.nullvalue,    self.factory.defaultvalue, self.factory.defaultvalue);
        $m.set_block(1, 1, $o);
        self.AssertSize($m, 3, 3);
        assert_equal($m, $n, "set block with a large block does not resize the matrix");
    }

    # Test that set_block with negative indices throws an exception
    method test_negative_indicies() {
        assert_throws(Exception::OutOfBounds, "Can set_block with negative indices",
        {
            my $m := self.factory.defaultmatrix2x2();
            my $o := self.factory.matrix();
            $m.set_block(-1, -1, $o);
        });
    }

    # Test that we can set_block on an empty matrix and cause it to resize
    # appropriately
    method test_set_block_on_empty_matrix() {
        my $m := self.factory.fancymatrix2x2();
        my $n := self.factory.matrix();
        $n.set_block(1, 1, $m);

        # First, prove that we haven't resized it
        self.AssertSize($n, 3, 3);

        # Second, let's prove that nothing was set where it doesn't belong.
        self.AssertNullValueAt($n, 0, 0);
        self.AssertNullValueAt($n, 1, 0);
        self.AssertNullValueAt($n, 2, 0);
        self.AssertNullValueAt($n, 0, 1);
        self.AssertNullValueAt($n, 0, 2);

        # Third, prove that the block was set properly
        assert_equal($n{Key.new(1,1)}, $m{Key.new(0,0)}, "value was set in wrong place 6");
        assert_equal($n{Key.new(1,2)}, $m{Key.new(0,1)}, "value was set in wrong place 7");
        assert_equal($n{Key.new(2,1)}, $m{Key.new(1,0)}, "value was set in wrong place 8");
        assert_equal($n{Key.new(2,2)}, $m{Key.new(1,1)}, "value was set in wrong place 9");
    }

    # Test that calling set_block with a scalar throws an exception
    # TODO: Is this behavior that we want to set? If so, we can treat the
    #       scalar as a 1x1 matrix?
    method test_set_scalar_as_block() {
        my $m := self.factory.defaultmatrix2x2();
        my $n := "";
        assert_throws(Exception::OutOfBounds, "Can set_block a scalar", {
            $m.set_block(0, 0, $n);
        });
    }

    # TODO: We should probably create a few tests to check set_block when using
    #       various matrix types. For instance,
    #       NumMatrix2d.set_block(PMCMatrix2D) should work, and vice-versa. We
    #       can test [almost] all combinations.

}
