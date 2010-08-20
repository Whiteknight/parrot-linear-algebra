class Pla::Methods::RowScale is Pla::MatrixTestBase {

    INIT {
        use('UnitTest::Testcase');
        use('UnitTest::Assertions');
    }

    method test_METHOD_row_scale() {
        my $A := self.factory.matrix();
        $A.initialize_from_args(3, 3,
                self.factory.fancyvalue(0), self.factory.fancyvalue(0), self.factory.fancyvalue(0),
                self.factory.fancyvalue(1), self.factory.fancyvalue(1), self.factory.fancyvalue(1),
                self.factory.fancyvalue(2), self.factory.fancyvalue(2), self.factory.fancyvalue(2));

        my $B := self.factory.matrix();
        $B.initialize_from_args(3, 3,
                self.factory.fancyvalue(0) * 2, self.factory.fancyvalue(0) * 2, self.factory.fancyvalue(0) * 2,
                self.factory.fancyvalue(1) * 3, self.factory.fancyvalue(1) * 3, self.factory.fancyvalue(1) * 3,
                self.factory.fancyvalue(2) * 4, self.factory.fancyvalue(2) * 4, self.factory.fancyvalue(2) * 4);
        $A.row_scale(0, 2);
        $A.row_scale(1, 3);
        $A.row_scale(2, 4);
        assert_equal($A, $B, "cannot scale rows");
    }

    method test_METHOD_row_scale_NEGINDICES() {
        assert_throws(Exception::OutOfBounds, "index is negative",
        {
            my $A := self.factory.defaultmatrix3x3();
            $A.row_scale(-1, 1);
        });
    }

    method test_METHOD_row_scale_BOUNDS() {
        assert_throws(Exception::OutOfBounds, "index is negative",
        {
            my $A := self.factory.defaultmatrix3x3();
            $A.row_scale(7, 1);
        });
    }
}