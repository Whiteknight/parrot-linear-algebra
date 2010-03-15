# Copyright (C) 2010, Andrew Whitworth. See accompanying LICENSE file, or
# http://www.opensource.org/licenses/artistic-license-2.0.php for license.

INIT {
    use('UnitTest::Testcase');
    use('UnitTest::Assertions');
}

class Pla::Testcase is UnitTest::Testcase {
    method default_loader() {
    	Pla::Loader.new;
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
    method fancyvalue() {
        return (2);
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

    method defaultmatrix2x2() {
        return self.matrix2x2(
            self.defaultvalue(),
            self.defaultvalue(),
            self.defaultvalue(),
            self.defaultvalue()
        );
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
        assert_throws_nothing("Cannot create ComplexMatrix2D", {
            my $m := self.matrix();
            assert_not_null($m, "Could not create a ComplexMatrix2D");
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
        $n{Key.new(1,1)} := self.fancyvalue();
        assert_not_equal($m, $n, "non-equal matrices are equal");
    }

    method test_VTABLE_get_attr_str() {
        my $m := self.matrix();
        $m{Key.new(5,7)} := self.defaultvalue;
        assert_equal(pir::getattribute__PPS($m, "rows"), 6, "matrix does not have right size");
        assert_equal(pir::getattribute__PPS($m, "cols"), 8, "matrix does not have right size");
    }

    method test_VTABLE_get_attr_str_EMPTY() {
        my $m := self.matrix();
        assert_equal(pir::getattribute__PPS($m, "rows"), 0, "empty matrix has non-zero row count");
        assert_equal(pir::getattribute__PPS($m, "cols"), 0, "empty matrix has non-zero col count");
    }

    # TODO: Add tests that get_pmc_keyed_int and set_pmc_keyed_int share a
    #       correct linear relationship with get_pmc_keyed and set_pmc_keyed.

    # Test to show that autoresizing behavior of the type is consistent.
    method test_autoresizing() {
        todo("Tests Needed!");
    }

    method test_METHOD_resize() {
        my $m := self.matrix();
        $m.resize(3,3);
        assert_equal(pir::getattribute__PPS($m, "rows"), 3, "matrix does not have right size");
        assert_equal(pir::getattribute__PPS($m, "cols"), 3, "matrix does not have right size");
    }

    method test_METHOD_resize_SHRINK() {
        my $m := self.matrix();
        $m.resize(3,3);
        $m.resize(1,1);
        assert_equal(pir::getattribute__PPS($m, "rows"), 3, "matrix does not have right size");
        assert_equal(pir::getattribute__PPS($m, "cols"), 3, "matrix does not have right size");
    }

    method test_METHOD_resize_NEGATIVEINDICES() {
        my $m := self.matrix();
        $m.resize(-1, -1);
        assert_equal(pir::getattribute__PPS($m, "cols"), 0, "negative indices silently ignored");
        assert_equal(pir::getattribute__PPS($m, "rows"), 0, "negative indices silently ignored");
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
            self.fancyvalue(),
            self.fancyvalue(),
            self.fancyvalue(),
            self.fancyvalue()
        );
        $m.fill(self.fancyvalue());
        assert_equal($n, $m, "Cannot fill");
    }


    # Test transposing square matrices
    method test_METHOD_transpose() {
        todo("Tests Needed!");
    }

    # Test transposing non-square matrices
    method test_METHOD_transpose_DIMCHANGE() {
        todo("Tests Needed!");
    }

    # Test transposing square matrices
    method test_METHOD_mem_transpose() {
        todo("Tests Needed!");
    }

    # Test transposing non-square matrices
    method test_METHOD_mem_transpose_DIMCHANGE() {
        todo("Tests Needed!");
    }

    # TODO: Come up with a good way to test that we are iterating and all values
    #       are correct
    method test_METHOD_iterate_function_inplace() {
        todo("Tests Needed!");
    }

    # TODO: Come up with a good consistant way to test that we are hitting all
    #       the coords, and hitting each only once.
    method test_METHOD_iterate_function_inplace_COORDS() {
        todo("Tests Needed!");
        #my $m := self.defaultmatrix2x2();
        #my $n := matrix2x2(0.0, 1.0, 1.0, 2.0);
        #$m.iterate_function_inplace(-> $matrix, $value, $x, $y{
        #    return ($x + $y);
        #});
        #assert_equal($m, $n, "Cannot iterate with args");
    }

    # TODO: Come up with a good consistant way to test that we are hitting all
    #       the coords, and can pass constant args to each.
    method test_METHOD_iterate_function_inplace_ARGS() {
        todo("Tests Needed!");
        #my $m := matrix2x2(1.0, 2.0, 3.0, 4.0);
        #my $n := matrix2x2(1.0, 4.0, 9.0, 16.0);
        #$m.iterate_function_inplace(-> $matrix, $value, $x, $y, $a, $b {
        #    return ($value * $value);
        #}, 5, 2);
        #assert_equal($m, $n, "Cannot iterate with args");
    }

    method test_METHOD_iterate_function_external() {
        todo("Tests Needed!");
    }

    method test_METHOD_initialize_from_array() {
        todo("Tests Needed!");
    }

    method test_METHOD_initialize_from_array_ZEROPAD() {
        todo("Tests Needed!");
    }

    method test_METHOD_initialize_from_array_UNDERSIZE() {
        todo("Tests Needed!");
    }

    method test_METHOD_initialize_from_args() {
        todo("Tests Needed!");
    }

    method test_METHOD_initialize_from_args_ZEROPAD() {
        todo("Tests Needed!");
    }

    method test_METHOD_initialize_from_args_UNDERSIZE() {
        todo("Tests Needed!");
    }

    method test_METHOD_get_block() {
        todo("Tests Needed!");
    }

    # Test that get_block(0,0,0,0) returns a zero-size matrix
    method test_METHOD_get_block_ZEROSIZE() {
        todo("Tests Needed!");
    }

    # Test that get_block(-1,-1,0,0) throws the proper exception
    method test_METHOD_get_block_NEGINDICES() {
        todo("Tests Needed!");
    }

    # Test that get_block(0,0,-1,-1) throws the proper exception
    method test_METHOD_get_block_NEGSIZES() {
        todo("Tests Needed!");
    }

    # Test the behavior of get_block when we request a block crossing or outside
    # the boundaries of the matrix
    method test_METHOD_get_block_OVERFLOW() {
        todo("Tests Needed!");
    }

    method test_METHOD_set_block() {
        todo("Tests Needed!");
    }

    method test_METHOD_set_block_ZEROSIZE() {
        todo("Tests Needed!");
    }

    method test_METHOD_set_block_NEGINDICES() {
        todo("Tests Needed!");
    }

    method test_METHOD_set_block_NEGSIZE() {
        todo("Tests Needed!");
    }

    method test_METHOD_set_block_OVERFLOW() {
        todo("Tests Needed!");
    }
}

class Pla::Loader is UnitTest::Loader ;

method order_tests(@tests) {
    my $test_method := 'test_METHOD';
    my $test_op := 'test_OP';
    my $test_vtable := 'test_VTABLE';

    my $len := $test_op.length;	# The shortest

    my %partition;
    for <test_METHOD test_OP test_VTABLE MISC> {
    	%partition{$_} := [ ];
    }

    for @tests -> $name {
    	my $name_lc := $name.downcase.substr(0, $len);

    	if %partition.contains( $name_lc ) {
            %partition{$name_lc}.push: $name;
    	}
    	else {
            %partition<MISC>.push: $name;
    	}
    }

    my @result;
    for <test_OP test_VTABLE test_METHOD MISC> {
    	@result.append: %partition{$_}.unsort;
    }

    @result;
}