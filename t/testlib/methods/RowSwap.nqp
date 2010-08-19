class Pla::Methods::RowSwap is Pla::MatrixTestBase {

    INIT {
        use('UnitTest::Testcase');
        use('UnitTest::Assertions');
    }

    method test_METHOD_row_swap() {
        my $A := self.factory.matrix();
        $A.initialize_from_args(3, 3,
                self.factory.fancyvalue(0), self.factory.fancyvalue(0), self.factory.fancyvalue(0),
                self.factory.fancyvalue(1), self.factory.fancyvalue(1), self.factory.fancyvalue(1),
                self.factory.fancyvalue(2), self.factory.fancyvalue(2), self.factory.fancyvalue(2));

        my $B := self.factory.matrix();
        $B.initialize_from_args(3, 3,
                self.factory.fancyvalue(1), self.factory.fancyvalue(1), self.factory.fancyvalue(1),
                self.factory.fancyvalue(2), self.factory.fancyvalue(2), self.factory.fancyvalue(2),
                self.factory.fancyvalue(0), self.factory.fancyvalue(0), self.factory.fancyvalue(0));
        $A.row_swap(0, 2);
        $A.row_swap(0, 1);
        assert_equal($A, $B, "cannot row_swap");
    }

    method test_METHOD_row_swap_NEGINDICES_A() {
        assert_throws(Exception::OutOfBounds, "Index A is out of bounds",
        {
            my $A := self.factory.defaultmatrix3x3();
            $A.row_swap(-1, 1);
        });
    }

    method test_METHOD_row_swap_BOUNDS_A() {
        assert_throws(Exception::OutOfBounds, "Index A is out of bounds",
        {
            my $A := self.factory.defaultmatrix3x3();
            $A.row_swap(7, 1);
        });
    }

    method test_METHOD_row_swap_NEGINDICES_B() {
        assert_throws(Exception::OutOfBounds, "Index B is out of bounds",
        {
            my $A := self.factory.defaultmatrix3x3();
            $A.row_swap(1, -1);
        });
    }

    method test_METHOD_row_swap_BOUNDS_B() {
        assert_throws(Exception::OutOfBounds, "Index B is out of bounds",
        {
            my $A := self.factory.defaultmatrix3x3();
            $A.row_swap(1, 7);
        });
    }
}