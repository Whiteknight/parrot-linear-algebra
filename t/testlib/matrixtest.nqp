# Copyright (C) 2010, Andrew Whitworth. See accompanying LICENSE file, or
# http://www.opensource.org/licenses/artistic-license-2.0.php for license.

class Pla::Matrix::Testcase is UnitTest::Testcase {

    INIT {
        use('UnitTest::Testcase');
        use('UnitTest::Assertions');
    }

    # Temporary stuff util the use() statements above start working properly
    our sub assert_equal($a, $b, $c) {
        UnitTest::Assertions::assert_equal($a, $b, $c);
    }

    our sub assert_throws($a, $b, &c) {
        UnitTest::Assertions::assert_throws($a, $b, &c);
    }

    our sub assert_throws_nothing($a, $b) {
        UnitTest::Assertions::assert_throws_nothing($a, $b);
    }

    our sub assert_instance_of($a, $b, $c) {
        UnitTest::Assertions::assert_instance_of($a, $b, $c);
    }

    method default_loader() {
        Pla::Matrix::Loader.new;
    }

    # A default value which can be set at a particular location and tested
    method defaultvalue() {
        return (1);
    }

    # The null value which is auto-inserted into the matrix on resize.
    method nullvalue() {
        return (0);
    }

    # A novel value which can be used to flag interesting changes in tests.
    method fancyvalue($idx) {
        return ([5, 6, 7, 8][$idx]);
    }

    # Create an empty matrix of the given type
    method matrix() {
        Exception::MethodNotFound.new(
            :message("Must subclass matrix in your test class")
        ).throw;
    }

    # Create a 2x2 matrix of the type with given values row-first
    method matrix2x2($aa, $ab, $ba, $bb) {
        my $m := self.matrix();
        $m{Key.new(0,0)} := $aa;
        $m{Key.new(0,1)} := $ab;
        $m{Key.new(1,0)} := $ba;
        $m{Key.new(1,1)} := $bb;
        return ($m);
    }

    # Create a 2x2 matrix completely filled with a single default value
    method defaultmatrix2x2() {
        return self.matrix2x2(
            self.defaultvalue(),
            self.defaultvalue(),
            self.defaultvalue(),
            self.defaultvalue()
        );
    }

    # Create a 2x2 matrix with interesting values in each slot.
    method fancymatrix2x2() {
        return self.matrix2x2(
            self.fancyvalue(0),
            self.fancyvalue(1),
            self.fancyvalue(2),
            self.fancyvalue(3)
        );
    }

    method AssertSize($m, $rows, $cols) {
        my $real_rows := pir::getattribute__PPS($m, "rows");
        my $real_cols := pir::getattribute__PPS($m, "cols");
        assert_equal($real_rows, $rows,
            "matrix does not have correct number of rows. $rows expected, $real_rows actual");
        assert_equal($real_cols, $cols,
            "matrix does not have correct number of columns. $cols expected, $real_cols actual");
    }

    method AssertNullValueAt($m, $row, $col) {
        my $nullval := self.nullvalue;
        my $val := $m{Key.new($row, $col)};
        if pir::isnull__IP($nullval) == 1 {
            assert_instance_of($val, "Undef", "Expected null value at position ($row,$col). Had $val.");
        } else {
            assert_equal($val, $nullval, "Expected default value $nullval at position ($row,$col). Had $val");
        }
    }

    method AssertValueAtIs($m, $row, $col, $expected) {
        my $val := $m{Key.new($row, $col)};
        if pir::isnull__IP($expected) {
            assert_null($val, "Value not null at ($row,$col). Have $val");
        } else {
            assert_equal($val, $expected, "Values not equal at ($row,$col). Had $val, wanted $expected");
        }
    }

    # Create a 3x3 matrix of the type with given values row-first
    method matrix3x3($aa, $ab, $ac, $ba, $bb, $bc, $ca, $cb, $cc) {
        my $m := self.matrix();
        $m{Key.new(0,0)} := $aa;
        $m{Key.new(0,1)} := $ab;
        $m{Key.new(0,2)} := $ac;
        $m{Key.new(1,0)} := $ba;
        $m{Key.new(1,1)} := $bb;
        $m{Key.new(1,2)} := $bc;
        $m{Key.new(2,0)} := $ca;
        $m{Key.new(2,1)} := $cb;
        $m{Key.new(2,2)} := $cc;
        return ($m);
    }

    ### COMMON TESTS ###
    # TODO: For some of the stub tests below, we should fail() if a test isn't
    #       provided. This means we're going to have to actually implement these
    #       methods in the various types and enforce the behavior.

    method test_OP_new() {
        assert_throws_nothing("Cannot create new matrix", {
            my $m := self.matrix();
            assert_not_null($m, "Could not create a matrix");
        });
    }

    method test_OP_does() {
        my $m := self.matrix();
        assert_true(pir::does($m, "matrix"), "Does not do matrix");
        assert_false(pir::does($m, "gobbledegak"), "Does gobbledegak");
    }

    method test_VTABLE_get_pmc_keyed() {
        my $m := self.matrix();
        my $a := self.defaultvalue();
        $m{Key.new(0,0)} := $a;
        my $b := $m{Key.new(0,0)};
        assert_equal($a, $b, "get_pmc_keyed doesn't work");
    }

    method test_VTABLE_set_pmc_keyed() {
        assert_throws_nothing("Cannot set_pmc_keyed", {
            my $m := self.matrix();
            my $a := self.defaultvalue();
            $m{Key.new(0,0)} := $a;
        });
    }

    method test_VTABLE_clone() {
        my $m := self.defaultmatrix2x2();
        my $n := pir::clone($m);
        assert_equal($m, $n, "clones are not equal");
        assert_not_same($m, $n, "clones are the same PMC!");
    }

    method test_VTABLE_is_equal() {
        my $m := self.defaultmatrix2x2();
        my $n := self.defaultmatrix2x2();
        assert_equal($m, $n, "equal matrices are not equal");
    }

    method test_VTABLE_is_equal_SIZEFAIL() {
        my $m := self.defaultmatrix2x2();
        my $n := self.defaultmatrix2x2();
        $n{Key.new(2, 2)} := self.nullvalue();
        assert_not_equal($m, $n, "different sized matrices are equal");
    }

    method test_VTABLE_is_equal_ELEMSFAIL() {
        my $m := self.defaultmatrix2x2();
        my $n := self.defaultmatrix2x2();
        $n{Key.new(1,1)} := self.fancyvalue(0);
        assert_not_equal($m, $n, "non-equal matrices are equal");
    }

    method test_VTABLE_get_attr_str() {
        my $m := self.matrix();
        $m{Key.new(5,7)} := self.defaultvalue;
        self.AssertSize($m, 6, 8);
    }

    method test_VTABLE_get_attr_str_EMPTY() {
        my $m := self.matrix();
        self.AssertSize($m, 0, 0);
    }

    method test_VTABLE_freeze() {
        assert_throws_nothing("Cannot set_pmc_keyed", {
            my $m := self.fancymatrix2x2();
            my $s := pir::freeze__SP($m);
        })
    }

    method test_VTABLE_thaw() {
        my $m := self.fancymatrix2x2();
        my $s := pir::freeze__SP($m);
        my $n := pir::thaw__PS($s);
        assert_equal($m, $n, "Freeze/thaw does not create equal PMCs");
        assert_not_same($m, $n, "Freeze/thaw returns original");
    }

    # Test to show that autoresizing behavior of the type is consistent.
    method test_MISC_autoresizing() {
        my $m := self.matrix();
        self.AssertSize($m, 0, 0);

        $m{Key.new(3, 4)} := self.defaultvalue;
        self.AssertSize($m, 4, 5);

        $m{Key.new(7, 11)} := self.defaultvalue;
        self.AssertSize($m, 8, 12);
    }

    method test_MISC_linearindexing() {
        my $m := self.fancymatrix2x2();
        assert_equal($m[0], $m{Key.new(0,0)}, "cannot get first element linearly");
        assert_equal($m[1], $m{Key.new(0,1)}, "cannot get first element linearly");
        assert_equal($m[2], $m{Key.new(1,0)}, "cannot get first element linearly");
        assert_equal($m[3], $m{Key.new(1,1)}, "cannot get first element linearly");
    }

    method test_METHOD_resize() {
        my $m := self.matrix();
        $m.resize(3,3);
        self.AssertSize($m, 3, 3);
    }

    method test_METHOD_resize_SHRINK() {
        my $m := self.matrix();
        $m.resize(3,3);
        $m.resize(1,1);
        self.AssertSize($m, 3, 3);
    }

    method test_METHOD_resize_NEGATIVEINDICES() {
        my $m := self.matrix();
        $m.resize(-1, -1);
        self.AssertSize($m, 0, 0);
    }

    method test_METHOD_fill_RESIZE() {
        my $m := self.defaultmatrix2x2();
        my $n := self.matrix();
        $n.fill(self.defaultvalue(), 2, 2);
        assert_equal($n, $m, "Cannot fill+Resize");
    }

    method test_METHOD_fill() {
        my $m := self.defaultmatrix2x2();
        my $n := self.matrix2x2(
            self.fancyvalue(0),
            self.fancyvalue(0),
            self.fancyvalue(0),
            self.fancyvalue(0)
        );
        $m.fill(self.fancyvalue(0));
        assert_equal($n, $m, "Cannot fill");
    }


    # Test transposing square matrices
    method test_METHOD_transpose() {
        my $m := self.matrix2x2(
            self.fancyvalue(0),
            self.fancyvalue(1),
            self.fancyvalue(2),
            self.fancyvalue(3)
        );
        my $n := self.matrix2x2(
            self.fancyvalue(0),
            self.fancyvalue(2),
            self.fancyvalue(1),
            self.fancyvalue(3)
        );
        $m.transpose();
        assert_equal($n, $m, "cannot transpose matrix");
    }

    # Test transposing non-square matrices
    method test_METHOD_transpose_DIMCHANGE() {
        my $m := self.matrix();
        $m{Key.new(0,0)} := self.fancyvalue(0);
        $m{Key.new(0,1)} := self.fancyvalue(1);
        $m{Key.new(0,2)} := self.fancyvalue(2);
        $m{Key.new(0,3)} := self.fancyvalue(3);

        my $n := self.matrix();
        $n{Key.new(0,0)} := self.fancyvalue(0);
        $n{Key.new(1,0)} := self.fancyvalue(1);
        $n{Key.new(2,0)} := self.fancyvalue(2);
        $n{Key.new(3,0)} := self.fancyvalue(3);

        $m.transpose();
        assert_equal($m, $n, "cannot transpose with non-square dimensions");
    }

    # Test transposing square matrices
    method test_METHOD_mem_transpose() {
        my $m := self.matrix2x2(
            self.fancyvalue(0),
            self.fancyvalue(1),
            self.fancyvalue(2),
            self.fancyvalue(3)
        );
        my $n := self.matrix2x2(
            self.fancyvalue(0),
            self.fancyvalue(2),
            self.fancyvalue(1),
            self.fancyvalue(3)
        );
        $m.mem_transpose();
        assert_equal($n, $m, "cannot mem_transpose matrix");
    }

    # Test transposing non-square matrices
    method test_METHOD_mem_transpose_DIMCHANGE() {
        my $m := self.matrix();
        $m{Key.new(0,0)} := self.fancyvalue(0);
        $m{Key.new(0,1)} := self.fancyvalue(1);
        $m{Key.new(0,2)} := self.fancyvalue(2);
        $m{Key.new(0,3)} := self.fancyvalue(3);

        my $n := self.matrix();
        $n{Key.new(0,0)} := self.fancyvalue(0);
        $n{Key.new(1,0)} := self.fancyvalue(1);
        $n{Key.new(2,0)} := self.fancyvalue(2);
        $n{Key.new(3,0)} := self.fancyvalue(3);

        $m.mem_transpose();
        assert_equal($m, $n, "cannot mem_transpose with non-square dimensions");
    }

    method test_METHOD_iterate_function_inplace() {
        my $m := self.defaultmatrix2x2();
        my $n := self.matrix();
        $n{Key.new(0,0)} := self.fancyvalue(0);
        $n{Key.new(0,1)} := self.fancyvalue(1);
        $n{Key.new(1,0)} := self.fancyvalue(2);
        $n{Key.new(1,1)} := self.fancyvalue(3);
        my $count := -1;
        my $sub := pir::newclosure__PP(-> $matrix, $value, $x, $y {
            $count++;
            return (self.fancyvalue($count));
        });
        $m.iterate_function_inplace($sub);
        assert_equal($count, 4, "iteration did not happen for all elements");
    }

    method test_METHOD_iterate_function_inplace_COORDS() {
        my $m := self.fancymatrix2x2();
        my $count := 0;
        my $x_ords := [0, 0, 1, 1];
        my $y_ords := [0, 1, 0, 1];
        my $sub := pir::newclosure__PP(-> $matrix, $value, $x, $y {
            assert_equal($x, $x_ords[$count], "x coordinate is correct");
            assert_equal($y, $y_ords[$count], "y coordinate is correct");
            $count++;
            return (self.defaultvalue());
        });
        $m.iterate_function_inplace($sub);
        assert_equal($count, 4, "iteration did not happen for all elements");
    }

    method test_METHOD_iterate_function_inplace_ARGS() {
        my $m := self.fancymatrix2x2();
        my $count := 0;
        my $first := 5;
        my $second := 2;
        my $sub := pir::newclosure__PP(-> $matrix, $value, $x, $y, $a, $b {
            assert_equal($a, $first, "first arg is not equal: " ~ $x);
            assert_equal($b, $second, "second arg is not equal: " ~ $y);
            $count++;
            return (self.defaultvalue());
        });
        $m.iterate_function_inplace($sub, $first, $second);
        assert_equal($count, 4, "iteration did not happen for all elements");
    }

    method test_METHOD_iterate_function_external() {
        my $m := self.fancymatrix2x2();
        my $sub := pir::newclosure__PP(-> $matrix, $value, $x, $y {
            return ($value);
        });
        my $o := $m.iterate_function_external($sub);
        assert_equal($o, $m, "Cannot copy by iterating external");
    }

    method test_METHOD_iterate_function_external_COORDS() {
        my $m := self.matrix2x2(self.nullvalue, self.nullvalue,
                                self.nullvalue, self.nullvalue);
        my $n := self.matrix2x2(self.fancyvalue(0), self.fancyvalue(1),
                                self.fancyvalue(1), self.fancyvalue(2));
        my $sub := pir::newclosure__PP(-> $matrix, $value, $x, $y {
            return (self.fancyvalue($x + $y));
        });
        my $o := $m.iterate_function_external($sub);
        assert_equal($o, $n, "cannot iterate external with proper coords");
    }

    method test_METHOD_iterate_function_external_ARGS() {
        my $m := self.matrix2x2(self.nullvalue, self.nullvalue,
                                self.nullvalue, self.nullvalue);
        my $n := self.matrix2x2(self.fancyvalue(3), self.fancyvalue(3),
                                self.fancyvalue(3), self.fancyvalue(3));
        my $sub := pir::newclosure__PP(-> $matrix, $value, $x, $y, $a, $b {
            return (self.fancyvalue($a + $b));
        });
        my $o := $m.iterate_function_external($sub, 1, 2);
        assert_equal($o, $n, "cannot iterate external with args");
    }

    method test_METHOD_initialize_from_array() {
        my $a := [self.fancyvalue(0), self.fancyvalue(1), self.fancyvalue(2), self.fancyvalue(3)];
        my $m := self.matrix2x2(self.fancyvalue(0), self.fancyvalue(1), self.fancyvalue(2), self.fancyvalue(3));
        my $n := self.matrix();
        $n.initialize_from_array(2, 2, $a);
        assert_equal($n, $m, "cannot initialize_from_array");
    }

    method test_METHOD_initialize_from_array_ZEROPAD() {
        my $a := [self.fancyvalue(0), self.fancyvalue(1), self.fancyvalue(2), self.fancyvalue(3)];
        my $m := self.matrix3x3(self.fancyvalue(0), self.fancyvalue(1), self.fancyvalue(2),
                                self.fancyvalue(3), self.nullvalue,     self.nullvalue,
                                self.nullvalue,     self.nullvalue,     self.nullvalue);
        my $n := self.matrix();
        $n.initialize_from_array(3, 3, $a);
        assert_equal($n, $m, "cannot initalize from array with zero padding");
    }

    method test_METHOD_initialize_from_array_UNDERSIZE() {
        my $a := [self.fancyvalue(0), self.fancyvalue(1), self.fancyvalue(2), self.fancyvalue(3)];
        my $m := self.matrix();
        $m{Key.new(0,0)} := self.fancyvalue(0);
        my $n := self.matrix();
        $n.initialize_from_array(1, 1, $a);
        assert_equal($n, $m, "cannot initialize from array undersized");
    }

    method test_METHOD_initialize_from_args() {
        my $m := self.matrix2x2(self.fancyvalue(0), self.fancyvalue(1), self.fancyvalue(2), self.fancyvalue(3));
        my $n := self.matrix();
        $n.initialize_from_args(2, 2, self.fancyvalue(0), self.fancyvalue(1), self.fancyvalue(2), self.fancyvalue(3));
        assert_equal($n, $m, "cannot initialize_from_args");
    }

    method test_METHOD_initialize_from_args_ZEROPAD() {
        my $m := self.matrix3x3(self.fancyvalue(0), self.fancyvalue(1), self.fancyvalue(2),
                                self.fancyvalue(3), self.nullvalue,     self.nullvalue,
                                self.nullvalue,     self.nullvalue,     self.nullvalue);
        my $n := self.matrix();
        $n.initialize_from_args(3, 3, self.fancyvalue(0), self.fancyvalue(1), self.fancyvalue(2), self.fancyvalue(3));
        assert_equal($n, $m, "cannot initalize from args with zero padding");
    }

    method test_METHOD_initialize_from_args_UNDERSIZE() {
        my $m := self.matrix();
        $m{Key.new(0,0)} := self.fancyvalue(0);
        my $n := self.matrix();
        $n.initialize_from_args(1, 1, self.fancyvalue(0), self.fancyvalue(1), self.fancyvalue(2), self.fancyvalue(3));
        assert_equal($n, $m, "cannot initialize from args undersized");
    }

    method test_METHOD_get_block() {
        my $m := self.fancymatrix2x2();
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

    method test_METHOD_get_block_COPY() {
        my $m := self.fancymatrix2x2();
        my $n := $m.get_block(0, 0, 2, 2);
        assert_equal($m, $n, "We cannot use get_block to create a faithful copy");
    }

    # Test that get_block(0,0,0,0) returns a zero-size matrix
    method test_METHOD_get_block_ZEROSIZE() {
        my $m := self.defaultmatrix2x2();
        my $n := $m.get_block(0, 0, 0, 0);
        self.AssertSize($n, 0, 0);
    }

    # Test that get_block(-1,-1,0,0) throws the proper exception
    method test_METHOD_get_block_NEGINDICES() {
        assert_throws(Exception::OutOfBounds, "Can get_block with negative indices",
        {
            my $m := self.defaultmatrix2x2();
            my $n := $m.get_block(-1, -1, 1, 1);
        });
    }

    # Test that get_block(0,0,-1,-1) throws the proper exception
    method test_METHOD_get_block_NEGSIZES() {
        assert_throws(Exception::OutOfBounds, "Can get_block with negative indices",
        {
            my $m := self.defaultmatrix2x2();
            my $n := $m.get_block(1, 1, -1, -1);
        });
    }

    # Test the behavior of get_block when we request a block crossing or outside
    # the boundaries of the matrix
    method test_METHOD_get_block_BOUNDS_CROSSED() {
        assert_throws(Exception::OutOfBounds, "Can get_block crossing boundaries of matrix",
        {
            my $m := self.defaultmatrix2x2();
            my $n := $m.get_block(1, 1, 2, 2);
        });
    }

    method test_METHOD_get_block_OUTSIDE() {
        assert_throws(Exception::OutOfBounds, "Can get_block outside boundaries of matrix",
        {
            my $m := self.defaultmatrix2x2();
            my $n := $m.get_block(9, 9, 2, 2);
        });
    }




    method test_METHOD_set_block() {
        my $m := self.fancymatrix2x2();
        my $n := self.matrix();
        $n{Key.new(2,2)} := self.nullvalue;
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

    # TODO: More tests for this method and coordinate combinations, including
    #       boundary-checking issues

    method test_METHOD_set_block_ZEROSIZE() {
        my $m := self.fancymatrix2x2();
        my $n := pir::clone__PP($m);
        my $o := self.matrix();
        $m.set_block(0, 0, $o);
        assert_equal($m, $n, "zero-size block insert changes the matrix");
    }

    # set_block with a zero-sized block resizes the matrix, but to one less
    # than might otherwise be expected. The first element of the block would
    # go to the specified coordinates, but there is no first element so there
    # is no item at the specified coordinates. Think of the block as a
    # zero-sized point to the upper-left of the coordinate.
    method test_METHOD_set_block_ZERO_RESIZE() {
        my $m := self.defaultmatrix2x2();
        my $o := self.matrix();
        $m.set_block(3, 3, $o);
        self.AssertSize($m, 3, 3);
        self.AssertNullValueAt($m, 2, 0);
        self.AssertNullValueAt($m, 2, 1);
        self.AssertNullValueAt($m, 2, 2);
        self.AssertNullValueAt($m, 1, 2);

        self.AssertValueAtIs($m, 0, 0, self.defaultvalue);
        self.AssertValueAtIs($m, 0, 1, self.defaultvalue);
        self.AssertValueAtIs($m, 1, 0, self.defaultvalue);
        self.AssertValueAtIs($m, 1, 1, self.defaultvalue);
    }

    method test_METHOD_set_block_RESIZE() {
        my $m := self.defaultmatrix2x2();
        my $o := self.matrix();
        $o{Key.new(0, 0)} := self.fancyvalue(2);
        $m.set_block(2, 2, $o);
        self.AssertSize($m, 3, 3);

        self.AssertValueAtIs($m, 0, 0, self.defaultvalue);
        self.AssertValueAtIs($m, 0, 1, self.defaultvalue);
        self.AssertValueAtIs($m, 1, 0, self.defaultvalue);
        self.AssertValueAtIs($m, 1, 1, self.defaultvalue);

        self.AssertNullValueAt($m, 2, 0);
        self.AssertNullValueAt($m, 2, 1);
        self.AssertNullValueAt($m, 0, 2);
        self.AssertNullValueAt($m, 1, 2);

        self.AssertValueAtIs($m, 2, 2, self.fancyvalue(2));
    }

    method test_METHOD_set_block_NEGINDICES() {
        assert_throws(Exception::OutOfBounds, "Can set_block with negative indices",
        {
            my $m := self.defaultmatrix2x2();
            my $o := self.matrix();
            $m.set_block(-1, -1, $o);
        });
    }

    method test_METHOD_set_block_OVERFLOW() {
        my $m := self.fancymatrix2x2();
        my $n := self.matrix();
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

    # TODO: Setup a test here to check the case where we set_block with a "block"
    #       that is not a matrix.
    method test_METHOD_set_block_SCALAR() {
        todo("Tests Needed!");
    }

    # TODO: We should probably create a few tests to check set_block when using
    #       various matrix types. For instance,
    #       NumMatrix2d.set_block(PMCMatrix2D) should work, and vice-versa. We
    #       can test [almost] all combinations.

}

class Pla::Matrix::Loader is UnitTest::Loader ;

method order_tests(@tests) {
    my $test_method := 'test_ME';
    my $test_op := 'test_OP';
    my $test_vtable := 'test_VT';

    my $len := $test_op.length;	# The shortest

    my %partition;
    for <test_me test_op test_vt MISC> {
    	%partition{$_} := [ ];
    }

    for @tests -> $name {
    	my $name_lc := pir::downcase__SS($name).substr(0, $len);

    	if %partition.contains( $name_lc ) {
            %partition{$name_lc}.push: $name;
    	}
    	else {
            %partition<MISC>.push: $name;
    	}
    }

    my @result;
    for <test_op test_vt test_me MISC> {
    	@result.append: %partition{$_}.unsort;
    }

    @result;
}
