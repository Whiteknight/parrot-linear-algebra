# Copyright (C) 2010, Andrew Whitworth. See accompanying LICENSE file, or
# http://www.opensource.org/licenses/artistic-license-2.0.php for license.

class Pla::MatrixTest is Pla::MatrixTestBase {

    # Test that we can create a matrix
    method test_OP_new() {
        Assert::throws_nothing("Cannot create new matrix", {
            my $m := self.factory.matrix();
            Assert::not_null($m, "Could not create a matrix");
        });
    }

    method test_OP_does_NOT() {
        my $m := self.factory.matrix();
        Assert::false(pir::does($m, "gobbledegak"), "Does gobbledegak");
    }

    # Test that a matrix does matrix
    method test_OP_does_Matrix() {
        my $m := self.factory.matrix();
        Assert::true(pir::does($m, "matrix"), "Does not do matrix");
    }

    # Test that we can get_pmc_keyed on a matrix
    method test_VTABLE_get_pmc_keyed() {
        my $m := self.factory.matrix();
        my $a := self.factory.defaultvalue();
        $m{Key.new(0,0)} := $a;
        my $b := $m{Key.new(0,0)};
        Assert::equal($a, $b, "get_pmc_keyed doesn't work");
    }

    # test that we can set a PMC at the given coordinates
    method test_VTABLE_set_pmc_keyed() {
        Assert::throws_nothing("Cannot set_pmc_keyed", {
            my $m := self.factory.matrix();
            my $a := self.factory.defaultvalue();
            $m{Key.new(0,0)} := $a;
        });
    }

    # Test cloning of the matrix. Clones should be different objects with the
    # same contents
    method test_VTABLE_clone() {
        my $m := self.factory.defaultmatrix2x2();
        my $n := pir::clone($m);
        Assert::equal($m, $n, "clones are not equal");
        Assert::not_same($m, $n, "clones are the same PMC!");
    }

    # TODO: Need to add lots more tests for is_equal. It uses a new float
    #       comparison algorithm that I want to really exercise.

    # test that we can compare two matrices for equality
    method test_VTABLE_is_equal() {
        my $m := self.factory.defaultmatrix2x2();
        my $n := self.factory.defaultmatrix2x2();
        Assert::equal($m, $n, "equal matrices are not equal");
    }

    # Assert that two matrices of different sizes are not equal
    method test_VTABLE_is_equal_SIZEFAIL() {
        my $m := self.factory.defaultmatrix2x2();
        my $n := self.factory.defaultmatrix2x2();
        $n{Key.new(2, 2)} := self.factory.nullvalue();
        Assert::not_equal($m, $n, "different sized matrices are equal");
    }

    # Test that two matrices of the same size but with different contents are
    # not equal
    method test_VTABLE_is_equal_ELEMSFAIL() {
        my $m := self.factory.defaultmatrix2x2();
        my $n := self.factory.defaultmatrix2x2();
        $n{Key.new(1,1)} := self.factory.fancyvalue(0);
        Assert::not_equal($m, $n, "non-equal matrices are equal");
    }

    # Test that we can get named attributes about the matrix
    method test_VTABLE_get_attr_str() {
        my $m := self.factory.matrix();
        $m{Key.new(5,7)} := self.factory.defaultvalue;
        self.AssertSize($m, 6, 8);
    }

    # Test that we can get attributes about an empty matrix
    method test_VTABLE_get_attr_str_EMPTY() {
        my $m := self.factory.matrix();
        self.AssertSize($m, 0, 0);
    }

    # Assert that we can freeze a matrix to a string
    method test_VTABLE_freeze() {
        Assert::throws_nothing("Cannot set_pmc_keyed", {
            my $m := self.factory.fancymatrix2x2();
            my $s := pir::freeze__SP($m);
        })
    }

    # Assert that we can freeze a matrix to a string, and thaw that string
    # back into a new copy of that matrix
    method test_VTABLE_thaw() {
        my $m := self.factory.fancymatrix2x2();
        my $s := pir::freeze__SP($m);
        my $n := pir::thaw__PS($s);
        Assert::equal($m, $n, "Freeze/thaw does not create equal PMCs");
        Assert::not_same($m, $n, "Freeze/thaw returns original");
    }

    method test_VTABLE_get_string() {
        self.RequireOverride("test_VTABLE_get_string");
    }

    method test_VTABLE_get_string_keyed() {
        my $m := self.factory.fancymatrix2x2();
        my $factory := self.factory;
        Q:PIR {
            .local pmc me
            me = find_lex "$factory"
            $P0 = find_lex "$m"

            $S0 = $P0[0;0]
            $S1 = me.'fancyvalue'(0)
            $S2 = "Expected '" . $S1
            $S2 .= "' got '"
            $S2 .= $S0
            $S2 .= "'"
            #"get_string_keyed fails 0;0"
            equal($S1, $S0, $S2)

            $S0 = $P0[0;1]
            $S1 = me.'fancyvalue'(1)
            equal($S1, $S0, "get_string_keyed fails 0;1")

            $S0 = $P0[1;0]
            $S1 = me.'fancyvalue'(2)
            equal($S1, $S0, "get_string_keyed fails 1;0")

            $S0 = $P0[1;1]
            $S1 = me.'fancyvalue'(3)
            equal($S1, $S0, "get_string_keyed fails 1;1")
        };
    }

    method test_VTABLE_get_number_keyed_int() {
        my $m := self.factory.fancymatrix2x2();
        my $factory := self.factory;
        Q:PIR {
            .local pmc me
            me = find_lex "$factory"
            $P0 = find_lex "$m"

            $N0 = $P0[0]
            $N1 = me.'fancyvalue'(0)
            equal($N0, $N1, "Can get number 0 by linear index")

            $N0 = $P0[1]
            $N1 = me.'fancyvalue'(1)
            equal($N0, $N1, "Can get number 1 by linear index")

            $N0 = $P0[2]
            $N1 = me.'fancyvalue'(2)
            equal($N0, $N1, "Can get number 2 by linear index")

            $N0 = $P0[3]
            $N1 = me.'fancyvalue'(3)
            equal($N0, $N1, "Can get number 3 by linear index")
        }
    }

    method test_VTABLE_get_integer_keyed_int() {
        my $m := self.factory.fancymatrix2x2();
        my $factory := self.factory;
        Q:PIR {
            .local pmc me
            me = find_lex "$factory"
            $P0 = find_lex "$m"

            $I0 = $P0[0]
            $I1 = me.'fancyvalue'(0)
            equal($I0, $I1, "Can get integer 0 by linear index")

            $I0 = $P0[1]
            $I1 = me.'fancyvalue'(1)
            equal($I0, $I1, "Can get integer 1 by linear index")

            $I0 = $P0[2]
            $I1 = me.'fancyvalue'(2)
            equal($I0, $I1, "Can get integer 2 by linear index")

            $I0 = $P0[3]
            $I1 = me.'fancyvalue'(3)
            equal($I0, $I1, "Can get integer 3 by linear index")
        }
    }

    method test_VTABLE_get_string_keyed_int() {
        my $m := self.factory.fancymatrix2x2();
        my $factory := self.factory;
        Q:PIR {
            .local pmc me
            me = find_lex "$factory"
            $P0 = find_lex "$m"

            $S0 = $P0[0]
            $S1 = me.'fancyvalue'(0)
            equal($S0, $S1, "Cannot get string keyed int 0")

            $S0 = $P0[1]
            $S1 = me.'fancyvalue'(1)
            equal($S0, $S1, "Cannot get string keyed int 1")

            $S0 = $P0[2]
            $S1 = me.'fancyvalue'(2)
            equal($S0, $S1, "Cannot get string keyed int 2")

            $S0 = $P0[3]
            $S1 = me.'fancyvalue'(3)
            equal($S0, $S1, "Cannot get string keyed int 3")
        }
    }

    method test_VTABLE_get_pmc_keyed_int() {
        my $m := self.factory.fancymatrix2x2();
        my $factory := self.factory;
        Q:PIR {
            .local pmc me
            me = find_lex "$factory"
            $P0 = find_lex "$m"

            $P1 = $P0[0]
            $P2 = me.'fancyvalue'(0)
            equal($P1, $P2, "Got PMC 0 from linear index")

            $P1 = $P0[1]
            $P2 = me.'fancyvalue'(1)
            equal($P1, $P2, "Got PMC 1 from linear index")

            $P1 = $P0[2]
            $P2 = me.'fancyvalue'(2)
            equal($P1, $P2, "Got PMC 2 from linear index")

            $P1 = $P0[3]
            $P2 = me.'fancyvalue'(3)
            equal($P1, $P2, "Got PMC 3 from linear index")
        }
    }

    # Test to show that autoresizing behavior of the type is consistent.
    method test_MISC_autoresizing() {
        my $m := self.factory.matrix();
        self.AssertSize($m, 0, 0);

        $m{Key.new(3, 4)} := self.factory.defaultvalue;
        self.AssertSize($m, 4, 5);

        $m{Key.new(7, 11)} := self.factory.defaultvalue;
        self.AssertSize($m, 8, 12);
    }

    # Test how we access values if we use one key instead of two
    method test_MISC_linear_indexing() {
        my $m := self.factory.fancymatrix2x2();
        Assert::equal($m[0], $m{Key.new(0,0)}, "cannot get first element linearly");
        Assert::equal($m[1], $m{Key.new(0,1)}, "cannot get first element linearly");
        Assert::equal($m[2], $m{Key.new(1,0)}, "cannot get first element linearly");
        Assert::equal($m[3], $m{Key.new(1,1)}, "cannot get first element linearly");
    }

    # TODO: Test the case where we pass a key with order greater than 2

    # Test that all core matrix types have some common methods
    method test_MISC_have_Matrix_role_methods() {
        my $m := self.factory.matrix();
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


    method test_negative_array() {
        my $m := self.factory.defaultmatrix2x2();

        Assert::throws(Exception::OutOfBounds, "negative PCM array should throw exception", {
            my $e := $m{[-1]};
        });
    }

    method test_empty_array() {
        my $m := self.factory.defaultmatrix2x2();

        Assert::throws(Exception::OutOfBounds, "empty PCM array should throw exception", {
            my $e := $m{[]};
        });
    }

    method test_1_element_array() {
        my $m := self.factory.fancymatrix2x2();
        $m.'item_at'(0,1,3);
        my $e := $m{[1]};

        Assert::equal($e, 3, "1 element PCM array should work");
    }

    method test_1_element_array_not_in_first_row() {
        my $m := self.factory.defaultmatrix3x3();
        $m.'item_at'(2,2,3);
        my $e := $m{[8]};

        Assert::equal($e, 3, "1 element PCM array should work");
    }

    method test_2_elements_array() {
        my $m := self.factory.fancymatrix2x2();
        $m.'item_at'(1,1,3);
        my $e := $m{[1,1]};

        Assert::equal($e, 3, "2 elements PCM array should work");
    }

    method test_more_than_2_elements_array() {
        my $m := self.factory.fancymatrix2x2();

        Assert::throws(Exception::OutOfBounds, "more than 2 elements PCM array should throw exception", {
          my $e := $m{[1,2,3]};
        });
    }


    method test_negative_key() {
        my $m := self.factory.defaultmatrix2x2();

        Assert::throws(Exception::OutOfBounds, "negative PCM key should throw exception", {
            my $e := $m{Key.new(-1)};
        });
    }

    method test_empty_key() {
        my $m := self.factory.fancymatrix2x2();

        Assert::throws(Exception::OutOfBounds, "empty PCM key should throw exception", {
            my $e := $m{Key.new()};
        });
    }

    method test_1_element_key() {
        my $m := self.factory.fancymatrix2x2();
        $m.'item_at'(0,1,3);
        my $e := $m{Key.new(1)};

        Assert::equal($e, 3, "1 element PCM key should work");
    }

    method test_1_element_key_not_in_first_row() {
        my $m := self.factory.defaultmatrix3x3();
        $m.'item_at'(2,2,3);
        my $e := $m{Key.new(8)};

        Assert::equal($e, 3, "1 element PCM key should work");
    }

    method test_2_elements_key() {
        my $m := self.factory.fancymatrix2x2();
        $m.'item_at'(1,1,3);
        my $e := $m{Key.new(1,1)};

        Assert::equal($e, 3, "2 elements PCM key should work");
    }

    method test_more_than_2_elements_key() {
        my $m := self.factory.fancymatrix2x2();

        Assert::throws(Exception::OutOfBounds, "more than 2 elements PCM key should throw exception", {
          my $e := $m{Key.new(0,1,3)};
        });
    }
}
