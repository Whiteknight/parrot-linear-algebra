class Pla::Methods::GetBlock is Pla::MatrixTestBase {

    INIT {
        use('UnitTest::Testcase');
        use('UnitTest::Assertions');
    }

    # Test that we can get a block from the matrix
    method test_get_block() {
        my $m := self.factory.fancymatrix2x2();
        my $n := $m.get_block(0, 0, 1, 1);
        self.AssertSize($n, 1, 1);
        assert_equal($n{Key.new(0, 0)}, $m{Key.new(0, 0)}, "Cannot get_block with correct values");

        $n := $m.get_block(0, 0, 1, 2);
        self.AssertSize($n, 1, 2);
        assert_equal($n{Key.new(0, 0)}, $m{Key.new(0, 0)}, "Cannot get_block with correct values");
        assert_equal($n{Key.new(0, 1)}, $m{Key.new(0, 1)}, "Cannot get_block with correct values");

        $n := $m.get_block(0, 1, 2, 1);
        self.AssertSize($n, 2, 1);
        assert_equal($n{Key.new(0, 0)}, $m{Key.new(0, 1)}, "Cannot get_block with correct values");
        assert_equal($n{Key.new(1, 0)}, $m{Key.new(1, 1)}, "Cannot get_block with correct values");
    }

    # TODO: Other tests for this method with other argument combinations and
    #       boundary checks.
    method test_get_block_1() {
        my $m := self.factory.matrix3x3(1.0, 2.0, 3.0,
                                4.0, 5.0, 6.0,
                                7.0, 8.0, 9.0);
        my $n := self.factory.matrix2x2(1.0, 2.0,
                                4.0, 5.0);
        my $o := $m.get_block(0, 0, 2, 2);
        assert_equal($n, $o, "cannot get block");
    }

    method test_get_block_2() {
        my $m := self.factory.matrix3x3(1.0, 2.0, 3.0,
                                4.0, 5.0, 6.0,
                                7.0, 8.0, 9.0);
        my $n := self.factory.matrix2x2(5.0, 6.0,
                                8.0, 9.0);
        my $o := $m.get_block(1, 1, 2, 2);
        assert_equal($n, $o, "cannot get block");
    }

    # Test that we can use get_block to make a copy
    method test_get_block_as_a_copy_routine() {
        my $m := self.factory.fancymatrix2x2();
        my $n := $m.get_block(0, 0, 2, 2);
        assert_equal($m, $n, "We cannot use get_block to create a faithful copy");
    }

    # Test that get_block(0,0,0,0) returns a zero-size matrix
    method test_request_zero_size_gets_zero_size() {
        my $m := self.factory.defaultmatrix2x2();
        my $n := $m.get_block(0, 0, 0, 0);
        self.AssertSize($n, 0, 0);
    }

    # Test that get_block(-1,-1,0,0) throws the proper exception
    method test_negative_index_A() {
        assert_throws(Exception::OutOfBounds, "Can get_block with negative indices",
        {
            my $m := self.factory.defaultmatrix2x2();
            my $n := $m.get_block(-1, 0, 1, 1);
        });
    }

    method test_negative_index_B() {
        assert_throws(Exception::OutOfBounds, "Can get_block with negative indices",
        {
            my $m := self.factory.defaultmatrix2x2();
            my $n := $m.get_block(0, -1, 1, 1);
        });
    }

    # Test that get_block(0,0,-1,-1) throws the proper exception
    method test_negative_size_A() {
        assert_throws(Exception::OutOfBounds, "Can get_block with negative indices",
        {
            my $m := self.factory.defaultmatrix2x2();
            my $n := $m.get_block(1, 1, -1, 1);
        });
    }

    method test_negative_size_A() {
        assert_throws(Exception::OutOfBounds, "Can get_block with negative indices",
        {
            my $m := self.factory.defaultmatrix2x2();
            my $n := $m.get_block(1, 1, 1, -1);
        });
    }

    # Test the behavior of get_block when we request a block crossing or outside
    # the boundaries of the matrix
    method test_requested_block_crosses_matrix_boundaries() {
        assert_throws(Exception::OutOfBounds, "Can get_block crossing boundaries of matrix",
        {
            my $m := self.factory.defaultmatrix2x2();
            my $n := $m.get_block(1, 1, 2, 2);
        });
    }

    # Test that calling get_block with coordinates outside the bounds of the
    # matrix throws an exception
    method test_requested_block_outside_matrix() {
        assert_throws(Exception::OutOfBounds, "Can get_block outside boundaries of matrix",
        {
            my $m := self.factory.defaultmatrix2x2();
            my $n := $m.get_block(9, 9, 2, 2);
        });
    }

}
