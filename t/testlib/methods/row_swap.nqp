class Pla::Methods::RowSwap is Pla::MatrixTestBase {
    method test_row_swap() {
        my $A := $!context.factory.matrix();
        $A.initialize_from_args(3, 3,
                $!context.factory.fancyvalue(0), $!context.factory.fancyvalue(0), $!context.factory.fancyvalue(0),
                $!context.factory.fancyvalue(1), $!context.factory.fancyvalue(1), $!context.factory.fancyvalue(1),
                $!context.factory.fancyvalue(2), $!context.factory.fancyvalue(2), $!context.factory.fancyvalue(2));

        my $B := $!context.factory.matrix();
        $B.initialize_from_args(3, 3,
                $!context.factory.fancyvalue(1), $!context.factory.fancyvalue(1), $!context.factory.fancyvalue(1),
                $!context.factory.fancyvalue(2), $!context.factory.fancyvalue(2), $!context.factory.fancyvalue(2),
                $!context.factory.fancyvalue(0), $!context.factory.fancyvalue(0), $!context.factory.fancyvalue(0));
        $A.row_swap(0, 2);
        $A.row_swap(0, 1);
        $!assert.equal($A, $B, "cannot row_swap");
    }

    method test_negative_index_A() {
        $!assert.throws("Index A is out of bounds",
        {
            my $A := $!context.factory.defaultmatrix3x3();
            $A.row_swap(-1, 1);
        });
    }

    method test_index_A_out_of_bounds() {
        $!assert.throws("Index A is out of bounds",
        {
            my $A := $!context.factory.defaultmatrix3x3();
            $A.row_swap(7, 1);
        });
    }

    method test_negative_index_B() {
        $!assert.throws("Index B is out of bounds",
        {
            my $A := $!context.factory.defaultmatrix3x3();
            $A.row_swap(1, -1);
        });
    }

    method test_index_B_out_of_bounds() {
        $!assert.throws("Index B is out of bounds",
        {
            my $A := $!context.factory.defaultmatrix3x3();
            $A.row_swap(1, 7);
        });
    }
}
