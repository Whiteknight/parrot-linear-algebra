class Pla::Methods::RowScale is Pla::MatrixTestBase {
    method test_row_scale() {
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

    method test_negative_row_index() {
        assert_throws(Exception::OutOfBounds, "index is negative",
        {
            my $A := self.factory.defaultmatrix3x3();
            $A.row_scale(-1, 1);
        });
    }

    method test_row_index_out_of_bounds() {
        assert_throws(Exception::OutOfBounds, "index is negative",
        {
            my $A := self.factory.defaultmatrix3x3();
            $A.row_scale(7, 1);
        });
    }
}
