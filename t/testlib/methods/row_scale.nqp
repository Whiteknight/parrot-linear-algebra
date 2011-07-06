class Pla::Methods::RowScale is Pla::MatrixTestBase {
    method test_row_scale() {
        my $A := $!context.factory.matrix();
        $A.initialize_from_args(3, 3,
                $!context.factory.fancyvalue(0), $!context.factory.fancyvalue(0), $!context.factory.fancyvalue(0),
                $!context.factory.fancyvalue(1), $!context.factory.fancyvalue(1), $!context.factory.fancyvalue(1),
                $!context.factory.fancyvalue(2), $!context.factory.fancyvalue(2), $!context.factory.fancyvalue(2));

        my $B := $!context.factory.matrix();
        $B.initialize_from_args(3, 3,
                $!context.factory.fancyvalue(0) * 2, $!context.factory.fancyvalue(0) * 2, $!context.factory.fancyvalue(0) * 2,
                $!context.factory.fancyvalue(1) * 3, $!context.factory.fancyvalue(1) * 3, $!context.factory.fancyvalue(1) * 3,
                $!context.factory.fancyvalue(2) * 4, $!context.factory.fancyvalue(2) * 4, $!context.factory.fancyvalue(2) * 4);
        $A.row_scale(0, 2);
        $A.row_scale(1, 3);
        $A.row_scale(2, 4);
        $!assert.equal($A, $B, "cannot scale rows");
    }

    method test_negative_row_index() {
        $!assert.throws("index is negative",
        {
            my $A := $!context.factory.defaultmatrix3x3();
            $A.row_scale(-1, 1);
        });
    }

    method test_row_index_out_of_bounds() {
        $!assert.throws("index is negative",
        {
            my $A := $!context.factory.defaultmatrix3x3();
            $A.row_scale(7, 1);
        });
    }
}
