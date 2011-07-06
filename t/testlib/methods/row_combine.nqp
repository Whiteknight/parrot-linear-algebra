class Pla::Methods::RowCombine is Pla::MatrixTestBase {
    method test_row_combine() {
        my $A := $!context.factory.fancymatrix2x2();
        my $val1;
        my $val2;
        my $factory := $!context.factory;
        Q:PIR {
            .local pmc me
            me = find_lex "$factory"
            $P0 = me."fancyvalue"(0)
            $P1 = me."fancyvalue"(1)
            $P2 = me."fancyvalue"(2)
            $P3 = me."fancyvalue"(3)

            $P4 = $P0 + $P2
            $P5 = $P1 + $P3
            store_lex "$val1", $P4
            store_lex "$val2", $P5
        };

        my $B := $!context.factory.matrix2x2($val1, $val2,
                                $!context.factory.fancyvalue(2), $!context.factory.fancyvalue(3));
        $A.row_combine(1, 0, 1);
        $!assert.equal($A, $B, "cannot row_combine");
    }

    method test_non_unity_gain() {
        my $A := $!context.factory.fancymatrix2x2();
        my $B := $!context.factory.matrix2x2($!context.factory.fancyvalue(0) + $!context.factory.fancyvalue(2) * $!context.factory.fancyvalue(0),
                                $!context.factory.fancyvalue(1) + $!context.factory.fancyvalue(3)  * $!context.factory.fancyvalue(0),
                                $!context.factory.fancyvalue(2), $!context.factory.fancyvalue(3));
        $A.row_combine(1, 0, $!context.factory.fancyvalue(0));
        $!assert.equal($A, $B, "cannot row_combine");
    }

    method test_negative_index_A() {
        $!assert.throws("Index A is out of bounds",
        {
            my $A := $!context.factory.defaultmatrix3x3();
            $A.row_combine(-1, 1, 1);
        });
    }

    method test_index_A_out_of_bounds() {
        $!assert.throws("Index A is out of bounds",
        {
            my $A := $!context.factory.defaultmatrix3x3();
            $A.row_combine(7, 1, 1);
        });
    }

    method test_negative_index_B() {
        $!assert.throws("Index B is out of bounds",
        {
            my $A := $!context.factory.defaultmatrix3x3();
            $A.row_combine(1, -1, 1);
        });
    }

    method test_index_B_out_of_bounds() {
        $!assert.throws("Index B is out of bounds",
        {
            my $A := $!context.factory.defaultmatrix3x3();
            $A.row_combine(1, 7, 1);
        });
    }
}
