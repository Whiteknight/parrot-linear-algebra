
class Pla::Matrix::NumericMatrixTest is Pla::Matrix::MatrixTest {

    INIT {
        use('UnitTest::Testcase');
        use('UnitTest::Assertions');
    }

    # Test that a numeric matrix does numericmatrix
    method test_OP_does_Matrix() {
        my $m := self.matrix();
        assert_true(pir::does($m, "numericmatrix"), "Does not do numericmatrix");
    }

    # Test that all core matrix types have some common methods
    method test_MISC_have_NumericMatrix_role_methods() {
        my $m := self.matrix();
        # Core matrix types should all have these methods in common.
        # Individual types may have additional methods. The signatures for
        # these will change depending on the type, so we don't check those
        # here.
        self.AssertHasMethod($m, "gemm");
        self.AssertHasMethod($m, "row_combine");
        self.AssertHasMethod($m, "row_scale");
        self.AssertHasMethod($m, "row_swap");
    }

    method test_VTABLE_set_number_keyed() {
        assert_throws_nothing("Cannot create NumMatrix2D", {
            my $m := self.matrix();
            Q:PIR {
                $P0 = find_lex "$m"
                $P0[2;2] = 3.0
                $P0[0;0] = 1.0
                $P0[1;1] = 2.0
            }
        });
    }

    method test_VTABLE_get_number_keyed() {
        my $m := self.matrix();
        Q:PIR {
            $P0 = find_lex "$m"
            $P0[2;2] = 3.0
            $P0[0;0] = 1.0
            $P0[1;1] = 2.0

            $N0 = $P0[0;0]
            assert_equal($N0, 1.0, "Got 0,0")

            $N0 = $P0[0;1]
            assert_equal($N0, 0.0, "Got 0,1")

            $N0 = $P0[0;2]
            assert_equal($N0, 0.0, "Got 0,2")

            $N0 = $P0[1;0]
            assert_equal($N0, 0.0, "Got 1,0")

            $N0 = $P0[1;1]
            assert_equal($N0, 2.0, "Got 1,1")

            $N0 = $P0[1;2]
            assert_equal($N0, 0.0, "Got 1,2")

            $N0 = $P0[2;0]
            assert_equal($N0, 0.0, "Got 2,0")

            $N0 = $P0[2;1]
            assert_equal($N0, 0.0, "Got 2,1")

            $N0 = $P0[2;2]
            assert_equal($N0, 3.0, "Got 2,2")
        }
    }

    method test_VTABLE_get_integer_keyed() {
        my $m := self.matrix2x2(4.0, 2.0, 3.0, 1.0);
        Q:PIR {
            $P0 = find_lex "$m"

            $I0 = $P0[1;1]
            assert_equal($I0, 1, "get integer 1,1")

            $I0 = $P0[0;1]
            assert_equal($I0, 2, "get integer 0,1")

            $I0 = $P0[1;0]
            assert_equal($I0, 3, "get integer 1,0")

            $I0 = $P0[0;0]
            assert_equal($I0, 4, "get integer 0,0")
        };
    }

    method test_VTABLE_set_integer_keyed() {
        my $m := self.matrix();
        Q:PIR {
            $P0 = find_lex "$m"
            $P0[1;1] = 1
            $P0[0;1] = 2
            $P0[1;0] = 3
            $P0[0;0] = 4

            $N0 = $P0[1;1]
            assert_equal($N0, 1.0, "got 1,1 set as integer")

            $N0 = $P0[0;1]
            assert_equal($N0, 2.0, "got 0,1 set as integer")

            $N0 = $P0[1;0]
            assert_equal($N0, 3.0, "got 1,0 set as integer")

            $N0 = $P0[0;0]
            assert_equal($N0, 4.0, "got 0,0 set as integer")
        };
    }

    method test_VTABLE_add_DEFAULT() {
        my $m := self.matrix2x2(1.0, 3.0, 2.0, 4.0);
        my $n := self.matrix2x2(3.5, 5.5, 4.5, 6.5);
        my $o := 2.5;
        my $p := pir::add__PPP($m, $o);
        assert_equal($p, $n, "Cannot add float");
    }

    method test_VTABLE_add_int() {
        my $m := self.matrix2x2(1.0, 3.0, 2.0, 4.0);
        my $n := self.matrix2x2(5.0, 7.0, 6.0, 8.0);
        Q:PIR {
            $P0 = find_lex "$m"
            $P1 = find_lex "$n"
            $P2 = add $P0, 4
            assert_equal($P1, $P2, "Cannot add_int")
        }
    }

    method test_VTABLE_add_float() {
        my $m := self.matrix2x2(1.0, 3.0, 2.0, 4.0);
        my $n := self.matrix2x2(3.5, 5.5, 4.5, 6.5);
        Q:PIR {
            $P0 = find_lex "$m"
            $P1 = find_lex "$n"
            $P2 = add $P0, 2.5
            assert_equal($P1, $P2, "Cannot add_float")
        }
    }

    method test_VTABLE_i_add_DEFAULT() {
        my $m := self.matrix2x2(1.0, 3.0, 2.0, 4.0);
        my $n := self.matrix2x2(3.5, 5.5, 4.5, 6.5);
        Q:PIR {
            $P0 = find_lex "$m"
            $P1 = find_lex "$n"
            $P2 = box 2.5
            add $P0, $P2
            assert_equal($P0, $P1, "Cannot i_add FLOAT")
        }
    }

    method test_VTABLE_i_add_int() {
        my $m := self.matrix2x2(1.0, 3.0, 2.0, 4.0);
        my $n := self.matrix2x2(5.0, 7.0, 6.0, 8.0);
        Q:PIR {
            $P0 = find_lex "$m"
            $P1 = find_lex "$n"
            add $P0, 4
            assert_equal($P0, $P1, "Cannot i_add_int")
        }
    }

    method test_VTABLE_i_add_float() {
        my $m := self.matrix2x2(1.0, 3.0, 2.0, 4.0);
        my $n := self.matrix2x2(5.5, 7.5, 6.5, 8.5);
        Q:PIR {
            $P0 = find_lex "$m"
            $P1 = find_lex "$n"
            add $P0, 4.5
            assert_equal($P0, $P1, "Cannot i_add_float")
        }
    }

    method test_VTABLE_subtract_DEFAULT() {
        my $m := self.matrix2x2(1.0, 3.0, 2.0, 4.0);
        my $n := self.matrix2x2(-1.5, 0.5, -0.5, 1.5);
        my $o := 2.5;
        my $p := pir::sub__PPP($m, $o);
        assert_equal($p, $n, "Cannot subtract float");
    }

    method test_VTABLE_subtract_int() {
        my $m := self.matrix2x2(1.0, 3.0, 2.0, 4.0);
        my $n := self.matrix2x2(0.0, 2.0, 1.0, 3.0);
        Q:PIR {
            $P0 = find_lex "$m"
            $P1 = find_lex "$n"
            $P2 = sub $P0, 1
            assert_equal($P1, $P2, "Cannot add_int")
        }
    }

    method test_VTABLE_subtract_float() {
        my $m := self.matrix2x2(1.0, 3.0, 2.0, 4.0);
        my $n := self.matrix2x2(0.5, 2.5, 1.5, 3.5);
        Q:PIR {
            $P0 = find_lex "$m"
            $P1 = find_lex "$n"
            $P2 = sub $P0, 0.5
            assert_equal($P1, $P2, "Cannot subtract_float")
        }
    }

    method test_VTABLE_i_subtract_DEFAULT() {
        my $m := self.matrix2x2(1.0, 3.0, 2.0, 4.0);
        my $n := self.matrix2x2(-1.5, 0.5, -0.5, 1.5);
        my $o := 2.5;
        Q:PIR {
            $P0 = find_lex "$m"
            $P1 = find_lex "$n"
            $P2 = find_lex "$o"
            sub $P0, $P2
            assert_equal($P0, $P1, "can not i_subtract Float")
        }
    }

    method test_VTABLE_i_subtract_int() {
        my $m := self.matrix2x2(1.0, 3.0, 2.0, 4.0);
        my $n := self.matrix2x2(-3.0, -1.0, -2.0, 0.0);
        Q:PIR {
            $P0 = find_lex "$m"
            $P1 = find_lex "$n"
            sub $P0, 4
            assert_equal($P0, $P1, "Cannot i_subtract_int")
        }
    }

    method test_VTABLE_i_subtract_float() {
        my $m := self.matrix2x2(1.0, 3.0, 2.0, 4.0);
        my $n := self.matrix2x2(-3.5, -1.5, -2.5, -0.5);
        Q:PIR {
            $P0 = find_lex "$m"
            $P1 = find_lex "$n"
            sub $P0, 4.5
            assert_equal($P0, $P1, "Cannot i_subtract_float")
        }
    }

    method test_VTABLE_multiply_DEFAULT() {
        my $m := self.matrix2x2(1.0, 2.0, 3.0, 4.0);
        my $n := self.matrix2x2(2.5, 5.0, 7.5, 10.0);
        my $p := pir::mul__PPP($m, 2.5);
        assert_equal($n, $p, "multiply matrix * float");
    }

    method test_VTABLE_multiply_int() {
        my $m := self.matrix2x2(1.0, 3.0, 2.0, 4.0);
        my $n := self.matrix2x2(5.0, 15.0, 10.0, 20.0);
        Q:PIR {
            $P0 = find_lex "$m"
            $P1 = find_lex "$n"
            $P2 = mul $P0, 5
            assert_equal($P1, $P2, "Cannot multiply_int")
        }
    }

    method test_VTABLE_multiply_float() {
        my $m := self.matrix2x2(1.0, 3.0, 2.0, 4.0);
        my $n := self.matrix2x2(2.5, 7.5, 5.0, 10.0);
        Q:PIR {
            $P0 = find_lex "$m"
            $P1 = find_lex "$n"
            $P2 = mul $P0, 2.5
            assert_equal($P1, $P2, "Cannot multiply_float")
        }
    }

    method test_VTABLE_i_multiply_DEFAULT() {
        my $A := self.matrix3x3(1.0, 2.0, 3.0,
                                4.0, 5.0, 6.0,
                                7.0, 8.0, 9.0);
        my $B := self.matrix3x3(2.0, 4.0, 6.0,
                                8.0, 10.0, 12.0,
                                14.0, 16.0, 18.0);
        Q:PIR {
            $P0 = find_lex "$A"
            $P1 = find_lex "$B"
            $P2 = box 2.0
            mul $P0,  $P2
            assert_equal($P1, $P0, "i_multiply by a Float is not right")
        }
    }

    method test_VTABLE_i_multiply_int() {
        my $A := self.matrix3x3(1.0, 2.0, 3.0,
                                4.0, 5.0, 6.0,
                                7.0, 8.0, 9.0);
        my $B := self.matrix3x3(2.0, 4.0, 6.0,
                                8.0, 10.0, 12.0,
                                14.0, 16.0, 18.0);
        Q:PIR {
            $P0 = find_lex "$A"
            $P1 = find_lex "$B"
            mul $P0,  2
            assert_equal($P1, $P0, "i_multiply by a Float is not right")
        }
    }

    method test_VTABLE_i_multiply_float() {
        my $A := self.matrix3x3(1.0, 2.0, 3.0,
                                4.0, 5.0, 6.0,
                                7.0, 8.0, 9.0);
        my $B := self.matrix3x3(2.0, 4.0, 6.0,
                                8.0, 10.0, 12.0,
                                14.0, 16.0, 18.0);
        Q:PIR {
            $P0 = find_lex "$A"
            $P1 = find_lex "$B"
            mul $P0,  2
            assert_equal($P1, $P0, "i_multiply by a Float is not right")
        }
    }

    method test_METHOD_gemm_aA() { self.RequireOverride("test_METHOD_gemm_aA"); }
    method test_METHOD_gemm_AB() { self.RequireOverride("test_METHOD_gemm_AB"); }
    method test_METHOD_gemm_aAB() { self.RequireOverride("test_METHOD_gemm_aAB"); }
    method test_METHOD_gemm_aABbC() { self.RequireOverride("test_METHOD_gemm_aABbC"); }

    method test_METHOD_gemm_BADTYPE_A() {
        assert_throws(Exception::OutOfBounds, "A is bad type",
        {
            my $A := "foobar";
            my $B := self.defaultmatrix3x3();
            my $C := self.defaultmatrix3x3();
            $B.gemm(1.0, $A, $B, 1.0, $C);
        });
    }

    method test_METHOD_gemm_BADTYPE_B() {
        assert_throws(Exception::OutOfBounds, "B is bad type",
        {
            my $A := self.defaultmatrix3x3();
            my $B := "foobar";
            my $C := self.defaultmatrix3x3();
            $A.gemm(1.0, $A, $B, 1.0, $C);
        });
    }

    method test_METHOD_gemm_BADTYPE_C() {
        assert_throws(Exception::OutOfBounds, "C is bad type",
        {
            my $A := self.defaultmatrix3x3();
            my $B := self.defaultmatrix3x3();
            my $C := "foobar";
            $A.gemm(1.0, $A, $B, 1.0, $C);
        });
    }

    method test_METHOD_gemm_BADSIZE_A() {
        assert_throws(Exception::OutOfBounds, "A has incorrect size",
        {
            my $A := self.defaultmatrix2x2();
            my $B := self.defaultmatrix3x3();
            my $C := self.defaultmatrix3x3();
            $A.gemm(1.0, $A, $B, 1.0, $C);
        });
    }

    method test_METHOD_gemm_BADSIZE_B() {
        assert_throws(Exception::OutOfBounds, "B has incorrect size",
        {
            my $A := self.defaultmatrix3x3();
            my $B := self.defaultmatrix2x2();
            my $C := self.defaultmatrix3x3();
            $A.gemm(1.0, $A, $B, 1.0, $C);
        });
    }

    method test_METHOD_gemm_BADSIZE_C() {
        assert_throws(Exception::OutOfBounds, "C has incorrect size",
        {
            my $A := self.defaultmatrix3x3();
            my $B := self.defaultmatrix3x3();
            my $C := self.defaultmatrix2x2();
            $A.gemm(1.0, $A, $B, 1.0, $C);
        });
    }

    method test_METHOD_row_combine() {
        my $A := self.fancymatrix2x2();
        my $B := self.matrix2x2(self.fancyvalue(0) + self.fancyvalue(2), self.fancyvalue(1) + self.fancyvalue(3),
                                self.fancyvalue(2), self.fancyvalue(3));
        $A.row_combine(1, 0, 1);
        assert_equal($A, $B, "cannot row_combine");
    }

    method test_METHOD_row_combine_GAIN() {
        my $A := self.fancymatrix2x2();
        my $B := self.matrix2x2(self.fancyvalue(0) + self.fancyvalue(2) * self.fancyvalue(0),
                                self.fancyvalue(1) + self.fancyvalue(3)  * self.fancyvalue(0),
                                self.fancyvalue(2), self.fancyvalue(3));
        $A.row_combine(1, 0, self.fancyvalue(0));
        assert_equal($A, $B, "cannot row_combine");
    }

    method test_METHOD_row_combine_NEGINDICES_A() {
        assert_throws(Exception::OutOfBounds, "Index A is out of bounds",
        {
            my $A := self.defaultmatrix3x3();
            $A.row_combine(-1, 1, 1);
        });
    }

    method test_METHOD_row_combine_BOUNDS_A() {
        assert_throws(Exception::OutOfBounds, "Index A is out of bounds",
        {
            my $A := self.defaultmatrix3x3();
            $A.row_combine(7, 1, 1);
        });
    }

    method test_METHOD_row_combine_NEGINDICES_B() {
        assert_throws(Exception::OutOfBounds, "Index B is out of bounds",
        {
            my $A := self.defaultmatrix3x3();
            $A.row_combine(1, -1, 1);
        });
    }

    method test_METHOD_row_combine_BOUNDS_B() {
        assert_throws(Exception::OutOfBounds, "Index B is out of bounds",
        {
            my $A := self.defaultmatrix3x3();
            $A.row_combine(1, 7, 1);
        });
    }

    method test_METHOD_row_swap() {
        my $A := self.matrix();
        $A.initialize_from_args(3, 3,
                self.fancyvalue(0), self.fancyvalue(0), self.fancyvalue(0),
                self.fancyvalue(1), self.fancyvalue(1), self.fancyvalue(1),
                self.fancyvalue(2), self.fancyvalue(2), self.fancyvalue(2));

        my $B := self.matrix();
        $B.initialize_from_args(3, 3,
                self.fancyvalue(1), self.fancyvalue(1), self.fancyvalue(1),
                self.fancyvalue(2), self.fancyvalue(2), self.fancyvalue(2),
                self.fancyvalue(0), self.fancyvalue(0), self.fancyvalue(0));
        $A.row_swap(0, 2);
        $A.row_swap(0, 1);
        assert_equal($A, $B, "cannot row_swap");
    }

    method test_METHOD_row_swap_NEGINDICES_A() {
        assert_throws(Exception::OutOfBounds, "Index A is out of bounds",
        {
            my $A := self.defaultmatrix3x3();
            $A.row_swap(-1, 1);
        });
    }

    method test_METHOD_row_swap_BOUNDS_A() {
        assert_throws(Exception::OutOfBounds, "Index A is out of bounds",
        {
            my $A := self.defaultmatrix3x3();
            $A.row_swap(7, 1);
        });
    }

    method test_METHOD_row_swap_NEGINDICES_B() {
        assert_throws(Exception::OutOfBounds, "Index B is out of bounds",
        {
            my $A := self.defaultmatrix3x3();
            $A.row_swap(1, -1);
        });
    }

    method test_METHOD_row_swap_BOUNDS_B() {
        assert_throws(Exception::OutOfBounds, "Index B is out of bounds",
        {
            my $A := self.defaultmatrix3x3();
            $A.row_swap(1, 7);
        });
    }

    method test_METHOD_row_scale() {
        my $A := self.matrix();
        $A.initialize_from_args(3, 3,
                self.fancyvalue(0), self.fancyvalue(0), self.fancyvalue(0),
                self.fancyvalue(1), self.fancyvalue(1), self.fancyvalue(1),
                self.fancyvalue(2), self.fancyvalue(2), self.fancyvalue(2));

        my $B := self.matrix();
        $B.initialize_from_args(3, 3,
                self.fancyvalue(0) * 2, self.fancyvalue(0) * 2, self.fancyvalue(0) * 2,
                self.fancyvalue(1) * 3, self.fancyvalue(1) * 3, self.fancyvalue(1) * 3,
                self.fancyvalue(2) * 4, self.fancyvalue(2) * 4, self.fancyvalue(2) * 4);
        $A.row_scale(0, 2);
        $A.row_scale(1, 3);
        $A.row_scale(2, 4);
        assert_equal($A, $B, "cannot scale rows");
    }

    method test_METHOD_row_scale_NEGINDICES() {
        assert_throws(Exception::OutOfBounds, "index is negative",
        {
            my $A := self.defaultmatrix3x3();
            $A.row_scale(-1, 1);
        });
    }

    method test_METHOD_row_scale_BOUNDS() {
        assert_throws(Exception::OutOfBounds, "index is negative",
        {
            my $A := self.defaultmatrix3x3();
            $A.row_scale(7, 1);
        });
    }
}
