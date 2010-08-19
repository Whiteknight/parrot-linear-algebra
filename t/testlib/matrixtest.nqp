# Copyright (C) 2010, Andrew Whitworth. See accompanying LICENSE file, or
# http://www.opensource.org/licenses/artistic-license-2.0.php for license.

class Pla::Matrix::MatrixTest is Pla::Matrix::MatrixTestBase {

    INIT {
        use('UnitTest::Testcase');
        use('UnitTest::Assertions');
    }

    # Test that we can create a matrix
    method test_OP_new() {
        assert_throws_nothing("Cannot create new matrix", {
            my $m := self.matrix();
            assert_not_null($m, "Could not create a matrix");
        });
    }

    method test_OP_does_NOT() {
        my $m := self.matrix();
        assert_false(pir::does($m, "gobbledegak"), "Does gobbledegak");
    }

    # Test that a matrix does matrix
    method test_OP_does_Matrix() {
        my $m := self.matrix();
        assert_true(pir::does($m, "matrix"), "Does not do matrix");
    }

    # Test that we can get_pmc_keyed on a matrix
    method test_VTABLE_get_pmc_keyed() {
        my $m := self.matrix();
        my $a := self.defaultvalue();
        $m{Key.new(0,0)} := $a;
        my $b := $m{Key.new(0,0)};
        assert_equal($a, $b, "get_pmc_keyed doesn't work");
    }

    # test that we can set a PMC at the given coordinates
    method test_VTABLE_set_pmc_keyed() {
        assert_throws_nothing("Cannot set_pmc_keyed", {
            my $m := self.matrix();
            my $a := self.defaultvalue();
            $m{Key.new(0,0)} := $a;
        });
    }

    # Test cloning of the matrix. Clones should be different objects with the
    # same contents
    method test_VTABLE_clone() {
        my $m := self.defaultmatrix2x2();
        my $n := pir::clone($m);
        assert_equal($m, $n, "clones are not equal");
        assert_not_same($m, $n, "clones are the same PMC!");
    }

    # test that we can compare two matrices for equality
    method test_VTABLE_is_equal() {
        my $m := self.defaultmatrix2x2();
        my $n := self.defaultmatrix2x2();
        assert_equal($m, $n, "equal matrices are not equal");
    }

    # Assert that two matrices of different sizes are not equal
    method test_VTABLE_is_equal_SIZEFAIL() {
        my $m := self.defaultmatrix2x2();
        my $n := self.defaultmatrix2x2();
        $n{Key.new(2, 2)} := self.nullvalue();
        assert_not_equal($m, $n, "different sized matrices are equal");
    }

    # Test that two matrices of the same size but with different contents are
    # not equal
    method test_VTABLE_is_equal_ELEMSFAIL() {
        my $m := self.defaultmatrix2x2();
        my $n := self.defaultmatrix2x2();
        $n{Key.new(1,1)} := self.fancyvalue(0);
        assert_not_equal($m, $n, "non-equal matrices are equal");
    }

    # Test that we can get named attributes about the matrix
    method test_VTABLE_get_attr_str() {
        my $m := self.matrix();
        $m{Key.new(5,7)} := self.defaultvalue;
        self.AssertSize($m, 6, 8);
    }

    # Test that we can get attributes about an empty matrix
    method test_VTABLE_get_attr_str_EMPTY() {
        my $m := self.matrix();
        self.AssertSize($m, 0, 0);
    }

    # Assert that we can freeze a matrix to a string
    method test_VTABLE_freeze() {
        assert_throws_nothing("Cannot set_pmc_keyed", {
            my $m := self.fancymatrix2x2();
            my $s := pir::freeze__SP($m);
        })
    }

    # Assert that we can freeze a matrix to a string, and thaw that string
    # back into a new copy of that matrix
    method test_VTABLE_thaw() {
        my $m := self.fancymatrix2x2();
        my $s := pir::freeze__SP($m);
        my $n := pir::thaw__PS($s);
        assert_equal($m, $n, "Freeze/thaw does not create equal PMCs");
        assert_not_same($m, $n, "Freeze/thaw returns original");
    }

    method test_VTABLE_get_string() {
        self.RequireOverride("test_VTABLE_get_string");
    }

    method test_VTABLE_get_string_keyed() {
        my $m := self.fancymatrix2x2();
        Q:PIR {
            .local pmc me
            me = find_lex "self"
            $P0 = find_lex "$m"

            $S0 = $P0[0;0]
            $S1 = me.'fancyvalue'(0)
            $S2 = "Expected '" . $S1
            $S2 .= "' got '"
            $S2 .= $S0
            $S2 .= "'"
            #"get_string_keyed fails 0;0"
            assert_equal($S1, $S0, $S2)

            $S0 = $P0[0;1]
            $S1 = me.'fancyvalue'(1)
            assert_equal($S1, $S0, "get_string_keyed fails 0;1")

            $S0 = $P0[1;0]
            $S1 = me.'fancyvalue'(2)
            assert_equal($S1, $S0, "get_string_keyed fails 1;0")

            $S0 = $P0[1;1]
            $S1 = me.'fancyvalue'(3)
            assert_equal($S1, $S0, "get_string_keyed fails 1;1")
        };
    }

    method test_VTABLE_get_number_keyed_int() {
        my $m := self.fancymatrix2x2();
        Q:PIR {
            .local pmc me
            me = find_lex "self"
            $P0 = find_lex "$m"

            $N0 = $P0[0]
            $N1 = me.'fancyvalue'(0)
            assert_equal($N0, $N1, "Can get number 0 by linear index")

            $N0 = $P0[1]
            $N1 = me.'fancyvalue'(1)
            assert_equal($N0, $N1, "Can get number 1 by linear index")

            $N0 = $P0[2]
            $N1 = me.'fancyvalue'(2)
            assert_equal($N0, $N1, "Can get number 2 by linear index")

            $N0 = $P0[3]
            $N1 = me.'fancyvalue'(3)
            assert_equal($N0, $N1, "Can get number 3 by linear index")
        }
    }

    method test_VTABLE_get_integer_keyed_int() {
        my $m := self.fancymatrix2x2();
        Q:PIR {
            .local pmc me
            me = find_lex "self"
            $P0 = find_lex "$m"

            $I0 = $P0[0]
            $I1 = me.'fancyvalue'(0)
            assert_equal($I0, $I1, "Can get integer 0 by linear index")

            $I0 = $P0[1]
            $I1 = me.'fancyvalue'(1)
            assert_equal($I0, $I1, "Can get integer 1 by linear index")

            $I0 = $P0[2]
            $I1 = me.'fancyvalue'(2)
            assert_equal($I0, $I1, "Can get integer 2 by linear index")

            $I0 = $P0[3]
            $I1 = me.'fancyvalue'(3)
            assert_equal($I0, $I1, "Can get integer 3 by linear index")
        }
    }

    method test_VTABLE_get_string_keyed_int() {
        my $m := self.fancymatrix2x2();
        Q:PIR {
            .local pmc me
            me = find_lex "self"
            $P0 = find_lex "$m"

            $S0 = $P0[0]
            $S1 = me.'fancyvalue'(0)
            assert_equal($S0, $S1, "Cannot get string keyed int 0")

            $S0 = $P0[1]
            $S1 = me.'fancyvalue'(1)
            assert_equal($S0, $S1, "Cannot get string keyed int 1")

            $S0 = $P0[2]
            $S1 = me.'fancyvalue'(2)
            assert_equal($S0, $S1, "Cannot get string keyed int 2")

            $S0 = $P0[3]
            $S1 = me.'fancyvalue'(3)
            assert_equal($S0, $S1, "Cannot get string keyed int 3")
        }
    }

    method test_VTABLE_get_pmc_keyed_int() {
        my $m := self.fancymatrix2x2();
        Q:PIR {
            .local pmc me
            me = find_lex "self"
            $P0 = find_lex "$m"

            $P1 = $P0[0]
            $P2 = me.'fancyvalue'(0)
            assert_equal($P1, $P2, "Got PMC 0 from linear index")

            $P1 = $P0[1]
            $P2 = me.'fancyvalue'(1)
            assert_equal($P1, $P2, "Got PMC 1 from linear index")

            $P1 = $P0[2]
            $P2 = me.'fancyvalue'(2)
            assert_equal($P1, $P2, "Got PMC 2 from linear index")

            $P1 = $P0[3]
            $P2 = me.'fancyvalue'(3)
            assert_equal($P1, $P2, "Got PMC 3 from linear index")
        }
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

    # Test how we access values if we use one key instead of two
    method test_MISC_linear_indexing() {
        my $m := self.fancymatrix2x2();
        assert_equal($m[0], $m{Key.new(0,0)}, "cannot get first element linearly");
        assert_equal($m[1], $m{Key.new(0,1)}, "cannot get first element linearly");
        assert_equal($m[2], $m{Key.new(1,0)}, "cannot get first element linearly");
        assert_equal($m[3], $m{Key.new(1,1)}, "cannot get first element linearly");
    }

    # TODO: Test the case where we pass a key with order greater than 2

    # Test that all core matrix types have some common methods
    method test_MISC_have_Matrix_role_methods() {
        my $m := self.matrix();
        # Core matrix types should all have these methods in common.
        # Individual types may have additional methods. The signatures for
        # these will change depending on the type, so we don't check those
        # here.
        self.AssertHasMethod($m, "resize");
        self.AssertHasMethod($m, "fill");
        self.AssertHasMethod($m, "transpose");
        self.AssertHasMethod($m, "mem_transpose");
        self.AssertHasMethod($m, "iterate_function_inplace");
        self.AssertHasMethod($m, "iterate_function_external");
        self.AssertHasMethod($m, "initialize_from_array");
        self.AssertHasMethod($m, "initialize_from_args");
        self.AssertHasMethod($m, "get_block");
        self.AssertHasMethod($m, "set_block");
        self.AssertHasMethod($m, "item_at");
        self.AssertHasMethod($m, "convert_to_number_matrix");
        self.AssertHasMethod($m, "convert_to_complex_matrix");
        self.AssertHasMethod($m, "convert_to_pmc_matrix");
    }

    # Test the resize method
    method test_METHOD_resize() {
        my $m := self.matrix();
        $m.resize(3,3);
        self.AssertSize($m, 3, 3);
    }

    # Test that we cannot shrink a matrix using the resize method
    method test_METHOD_resize_SHRINK() {
        my $m := self.matrix();
        $m.resize(3,3);
        $m.resize(1,1);
        self.AssertSize($m, 3, 3);
    }

    # Test that resize method with negative indices does nothing
    method test_METHOD_resize_NEGATIVEINDICES() {
        my $m := self.matrix();
        $m.resize(-1, -1);
        self.AssertSize($m, 0, 0);
    }

    # Test that we can fill a matrix
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

    # test that the fill method can be used to resize the matrix
    method test_METHOD_fill_RESIZE() {
        my $m := self.defaultmatrix2x2();
        my $n := self.matrix();
        $n.fill(self.defaultvalue(), 2, 2);
        assert_equal($n, $m, "Cannot fill+Resize");
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

    # Test mem transposing square matrices
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

    # Test mem transposing non-square matrices
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

    # Test that we can iterate a function in-place
    method test_METHOD_iterate_function_inplace() {
        my $m := self.defaultmatrix2x2();
        my $n := self.matrix();
        $n{Key.new(0,0)} := self.fancyvalue(0);
        $n{Key.new(0,1)} := self.fancyvalue(1);
        $n{Key.new(1,0)} := self.fancyvalue(2);
        $n{Key.new(1,1)} := self.fancyvalue(3);
        my $count := -1;
        my $sub := pir::newclosure__PP(sub ($matrix, $value, $x, $y) {
            $count++;
            return self.fancyvalue($count);
        });
        $m.iterate_function_inplace($sub);
        assert_equal($count, 3, "iteration did not happen for all elements");
        assert_equal($m, $n, "iteration did not create the correct result");
    }

    # test that iterate_function_inplace calls the callback with the proper
    # coordinates
    method test_METHOD_iterate_function_inplace_COORDS() {
        my $m := self.fancymatrix2x2();
        my $count := 0;
        my $x_ords := [0, 0, 1, 1];
        my $y_ords := [0, 1, 0, 1];
        my $sub := pir::newclosure__PP(sub ($matrix, $value, $x, $y) {
            assert_equal($x, $x_ords[$count], "x coordinate is correct");
            assert_equal($y, $y_ords[$count], "y coordinate is correct");
            $count++;
            return (self.defaultvalue());
        });
        $m.iterate_function_inplace($sub);
        assert_equal($count, 4, "iteration did not happen for all elements");
    }

    # Test that iterate_function_inplace passes the correct args
    method test_METHOD_iterate_function_inplace_ARGS() {
        my $m := self.fancymatrix2x2();
        my $count := 0;
        my $first := 5;
        my $second := 2;
        my $sub := pir::newclosure__PP(sub ($matrix, $value, $x, $y, $a, $b) {
            assert_equal($a, $first, "first arg is not equal: " ~ $x);
            assert_equal($b, $second, "second arg is not equal: " ~ $y);
            $count++;
            return (self.defaultvalue());
        });
        $m.iterate_function_inplace($sub, $first, $second);
        assert_equal($count, 4, "iteration did not happen for all elements");
    }

    # Test that iterate_function_external respects the transpose state of the
    # matrix
    method test_METHOD_iterate_function_inplace_TRANSPOSE() {
        my $m := self.fancymatrix2x2();
        $m.transpose();
        my $n := self.matrix2x2(self.fancyvalue(0) * 2, self.fancyvalue(2) * 2,
                                self.fancyvalue(1) * 2, self.fancyvalue(3) * 2);
        my $sub := sub ($matrix, $value, $x, $y) {
            return ($value * 2);
        };
        $m.iterate_function_inplace($sub);
        assert_equal($m, $n, "external iteration does not respect transpose");
    }

    # Test that we can iterate_function_external, and create a new matrix
    method test_METHOD_iterate_function_external() {
        my $m := self.fancymatrix2x2();
        my $sub := sub ($matrix, $value, $x, $y) {
            return $value;
        };
        my $o := $m.iterate_function_external($sub);
        assert_equal($o, $m, "Cannot copy by iterating external");
    }

    # Test that iterate_function_external passes the correct coordinates
    method test_METHOD_iterate_function_external_COORDS() {
        my $m := self.matrix2x2(self.nullvalue, self.nullvalue,
                                self.nullvalue, self.nullvalue);
        my $n := self.matrix2x2(self.fancyvalue(0), self.fancyvalue(1),
                                self.fancyvalue(1), self.fancyvalue(2));
        my $sub := pir::newclosure__PP(sub ($matrix, $value, $x, $y) {
            return (self.fancyvalue($x + $y));
        });
        my $o := $m.iterate_function_external($sub);
        assert_equal($o, $n, "cannot iterate external with proper coords");
    }

    # Test that iterate_function_external passes the correct args
    method test_METHOD_iterate_function_external_ARGS() {
        my $m := self.matrix2x2(self.nullvalue, self.nullvalue,
                                self.nullvalue, self.nullvalue);
        my $n := self.matrix2x2(self.fancyvalue(3), self.fancyvalue(3),
                                self.fancyvalue(3), self.fancyvalue(3));
        my $sub := pir::newclosure__PP(sub ($matrix, $value, $x, $y, $a, $b) {
            return (self.fancyvalue($a + $b));
        });
        my $o := $m.iterate_function_external($sub, 1, 2);
        assert_equal($o, $n, "cannot iterate external with args");
    }

    # Test that iterate_function_external respects the transpose state of the
    # matrix
    method test_METHOD_iterate_function_external_TRANSPOSE() {
        my $m := self.fancymatrix2x2();
        $m.transpose();
        my $n := self.matrix2x2(self.fancyvalue(0) * 2, self.fancyvalue(2) * 2,
                                self.fancyvalue(1) * 2, self.fancyvalue(3) * 2);
        my $sub := sub ($matrix, $value, $x, $y) {
            return $value * 2;
        };
        my $o := $m.iterate_function_external($sub);
        assert_equal($o, $n, "external iteration does not respect transpose");
    }

    # Test that we can initialize from an array
    method test_METHOD_initialize_from_array() {
        my $a := [self.fancyvalue(0), self.fancyvalue(1),
                  self.fancyvalue(2), self.fancyvalue(3)];
        my $m := self.matrix2x2(self.fancyvalue(0), self.fancyvalue(1),
                                self.fancyvalue(2), self.fancyvalue(3));
        my $n := self.matrix();
        $n.initialize_from_array(2, 2, $a);
        assert_equal($n, $m, "cannot initialize_from_array");
    }

    # Test that we can initialize from array, including zero padding
    method test_METHOD_initialize_from_array_ZEROPAD() {
        my $a := [self.fancyvalue(0), self.fancyvalue(1),
                  self.fancyvalue(2), self.fancyvalue(3)];
        my $m := self.matrix3x3(self.fancyvalue(0), self.fancyvalue(1), self.fancyvalue(2),
                                self.fancyvalue(3), self.nullvalue,     self.nullvalue,
                                self.nullvalue,     self.nullvalue,     self.nullvalue);
        my $n := self.matrix();
        $n.initialize_from_array(3, 3, $a);
        assert_equal($n, $m, "cannot initalize from array with zero padding");
    }

    # Test that when we initialize from an array, that we only use as many
    # values as required
    method test_METHOD_initialize_from_array_UNDERSIZE() {
        my $a := [self.fancyvalue(0), self.fancyvalue(1),
                  self.fancyvalue(2), self.fancyvalue(3)];
        my $m := self.matrix();
        $m{Key.new(0,0)} := self.fancyvalue(0);
        my $n := self.matrix();
        $n.initialize_from_array(1, 1, $a);
        assert_equal($n, $m, "cannot initialize from array undersized");
    }

    # Test that we can initialize from a list of arguments
    method test_METHOD_initialize_from_args() {
        my $m := self.matrix2x2(self.fancyvalue(0), self.fancyvalue(1),
                                self.fancyvalue(2), self.fancyvalue(3));
        my $n := self.matrix();
        $n.initialize_from_args(2, 2, self.fancyvalue(0), self.fancyvalue(1),
                                      self.fancyvalue(2), self.fancyvalue(3));
        assert_equal($n, $m, "cannot initialize_from_args");
    }

    # Test that we can initialize from an arg list with zero padding
    method test_METHOD_initialize_from_args_ZEROPAD() {
        my $m := self.matrix3x3(self.fancyvalue(0), self.fancyvalue(1), self.fancyvalue(2),
                                self.fancyvalue(3), self.nullvalue,     self.nullvalue,
                                self.nullvalue,     self.nullvalue,     self.nullvalue);
        my $n := self.matrix();
        $n.initialize_from_args(3, 3, self.fancyvalue(0), self.fancyvalue(1),
                                      self.fancyvalue(2), self.fancyvalue(3));
        assert_equal($n, $m, "cannot initalize from args with zero padding");
    }

    # Test that we can initialize from an arg list, ignoring values that we
    # don't need
    method test_METHOD_initialize_from_args_UNDERSIZE() {
        my $m := self.matrix();
        $m{Key.new(0,0)} := self.fancyvalue(0);
        my $n := self.matrix();
        $n.initialize_from_args(1, 1, self.fancyvalue(0), self.fancyvalue(1),
                                      self.fancyvalue(2), self.fancyvalue(3));
        assert_equal($n, $m, "cannot initialize from args undersized");
    }

    # Test that we can get a block from the matrix
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

    # TODO: Other tests for this method with other argument combinations and
    #       boundary checks.
    method test_METHOD_get_block_1() {
        my $m := self.matrix3x3(1.0, 2.0, 3.0,
                                4.0, 5.0, 6.0,
                                7.0, 8.0, 9.0);
        my $n := self.matrix2x2(1.0, 2.0,
                                4.0, 5.0);
        my $o := $m.get_block(0, 0, 2, 2);
        assert_equal($n, $o, "cannot get block");
    }

    method test_METHOD_get_block_2() {
        my $m := self.matrix3x3(1.0, 2.0, 3.0,
                                4.0, 5.0, 6.0,
                                7.0, 8.0, 9.0);
        my $n := self.matrix2x2(5.0, 6.0,
                                8.0, 9.0);
        my $o := $m.get_block(1, 1, 2, 2);
        assert_equal($n, $o, "cannot get block");
    }

    # Test that we can use get_block to make a copy
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

    # Test that calling get_block with coordinates outside the bounds of the
    # matrix throws an exception
    method test_METHOD_get_block_OUTSIDE() {
        assert_throws(Exception::OutOfBounds, "Can get_block outside boundaries of matrix",
        {
            my $m := self.defaultmatrix2x2();
            my $n := $m.get_block(9, 9, 2, 2);
        });
    }

    # Test set_block
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

    # Test set_block with a block of zero size
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

    # Test that set_block can resize the matrix if the specified coordinates
    # are outside the matrix
    method test_METHOD_set_block_RESIZE_COORDS() {
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

    # Test that set_block can resize the matrix if the specified coordinates
    # are outside the matrix
    method test_METHOD_set_block_RESIZE_BLKSIZE() {
        my $m := self.defaultmatrix2x2();
        my $o := self.defaultmatrix2x2();
        my $n := self.matrix3x3(self.defaultvalue, self.defaultvalue, self.nullvalue,
                                self.defaultvalue, self.defaultvalue, self.defaultvalue,
                                self.nullvalue,    self.defaultvalue, self.defaultvalue);
        $m.set_block(1, 1, $o);
        self.AssertSize($m, 3, 3);
        assert_equal($m, $n, "set block with a large block does not resize the matrix");
    }

    # Test that set_block with negative indices throws an exception
    method test_METHOD_set_block_NEGINDICES() {
        assert_throws(Exception::OutOfBounds, "Can set_block with negative indices",
        {
            my $m := self.defaultmatrix2x2();
            my $o := self.matrix();
            $m.set_block(-1, -1, $o);
        });
    }

    # Test that we can set_block on an empty matrix and cause it to resize
    # appropriately
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

    # Test that calling set_block with a scalar throws an exception
    method test_METHOD_set_block_SCALAR() {
        my $m := self.defaultmatrix2x2();
        my $n := "";
        assert_throws(Exception::OutOfBounds, "Can set_block a scalar", {
            $m.set_block(0, 0, $n);
        });
    }

    # TODO: We should probably create a few tests to check set_block when using
    #       various matrix types. For instance,
    #       NumMatrix2d.set_block(PMCMatrix2D) should work, and vice-versa. We
    #       can test [almost] all combinations.

    method test_METHOD_item_at() {
        my $m := self.fancymatrix2x2();
        assert_equal(self.fancyvalue(0), $m.item_at(0, 0), "cannot get item 0,0");
        assert_equal(self.fancyvalue(1), $m.item_at(0, 1), "cannot get item 0,1");
        assert_equal(self.fancyvalue(2), $m.item_at(1, 0), "cannot get item 1,0");
        assert_equal(self.fancyvalue(3), $m.item_at(1, 1), "cannot get item 1,1");
    }

    method test_METHOD_item_at_BOUNDS() {
        my $m := self.defaultmatrix2x2();
        assert_throws(Exception::OutOfBounds, "can item_at out of bounds",
        {
            $m.item_at(4, 4);
        });
    }

    method test_METHOD_item_at_NEGINDICES() {
        my $m := self.defaultmatrix2x2();
        assert_throws(Exception::OutOfBounds, "can item_at out of bounds",
        {
            $m.item_at(-1, -1);
        });
    }

    method test_METHOD_item_at_EMPTY() {
        my $m := self.matrix();
        assert_throws(Exception::OutOfBounds, "can item_at out of bounds",
        {
            $m.item_at(0, 0);
        });
    }

    method test_METHOD_item_at_VALUE() {
        my $m := self.fancymatrix2x2();
        my $n := self.fancymatrix2x2();
        $n{Key.new(1, 1)} := self.fancyvalue(0);
        $m.item_at(1, 1, self.fancyvalue(0));
        assert_equal($m, $n, "item_at(VALUE) does not work like keyed access");
    }

    method test_METHOD_item_at_VALUE_BOUNDS() {
        my $m := self.defaultmatrix2x2();
        assert_throws(Exception::OutOfBounds, "can item_at out of bounds",
        {
            $m.item_at(4, 4, self.fancyvalue(0));
        });
    }

    method test_METHOD_item_at_VALUE_NEGINDICES() {
        my $m := self.defaultmatrix2x2();
        assert_throws(Exception::OutOfBounds, "can item_at out of bounds",
        {
            $m.item_at(-1, -1, self.fancyvalue(0));
        });
    }

    method test_METHOD_item_at_VALUE_EMPTY() {
        my $m := self.matrix();
        assert_throws(Exception::OutOfBounds, "can item_at out of bounds",
        {
            $m.item_at(0, 0, self.fancyvalue(0));
        });
    }

    method test_METHOD_convert_to_number_matrix() {
        my $A := self.defaultmatrix2x2();
        my $B := $A.convert_to_number_matrix();
        assert_equal(pir::typeof__SP($B), "NumMatrix2D", "cannot convert");
        self.AssertSize($B, 2, 2);
    }

    method test_METHOD_convert_to_complex_matrix() {
        my $A := self.defaultmatrix2x2();
        my $B := $A.convert_to_complex_matrix();
        assert_equal(pir::typeof__SP($B), "ComplexMatrix2D", "cannot convert");
        self.AssertSize($B, 2, 2);
    }

    method test_METHOD_convert_to_pmc_matrix() {
        my $A := self.defaultmatrix2x2();
        my $B := $A.convert_to_pmc_matrix();
        assert_equal(pir::typeof__SP($B), "PMCMatrix2D", "cannot convert");
        self.AssertSize($B, 2, 2);
    }
}



