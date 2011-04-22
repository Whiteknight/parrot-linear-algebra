my $context := PLA::TestContext.new;
$context.set_factory(Pla::MatrixFactory::ComplexMatrix2D);
Rosella::Test::test(Test::ComplexMatrix2D::RowCombine, :context($context));

class Test::ComplexMatrix2D::RowCombine is Pla::Methods::RowCombine {

    method test_row_combine_complex() {
        my $A := $!context.factory.fancymatrix2x2();
        my $val1;
        my $val2;
        my $factory := $!context.factory;
        Q:PIR {
            .local pmc me
            me = find_lex "$factory"
            $P0 = new 'Complex'
            $P0 = "6+6i"
            $P1 = new 'Complex'
            $P1 = "7+7i"
            $P2 = new 'Complex'
            $P2 = "8+8i"
            $P3 = new 'Complex'
            $P3 = "9+9i"

            $P4 = $P0 + $P2
            $P5 = $P1 + $P3
            store_lex "$val1", $P4
            store_lex "$val2", $P5
        };

        my $B := $!context.factory.matrix2x2($val1, $val2,
                                $!context.factory.fancyvalue(2), $!context.factory.fancyvalue(3));
        $A.row_combine(1, 0, 1);
        Assert::equal($A, $B, "cannot row_combine");
    }

    method test_non_unity_gain_complex() {
        my $A := $!context.factory.fancymatrix2x2();
        my $B := $!context.factory.matrix2x2($!context.factory.fancyvalue(0) + $!context.factory.fancyvalue(2) * $!context.factory.fancyvalue(0),
                                $!context.factory.fancyvalue(1) + $!context.factory.fancyvalue(3)  * $!context.factory.fancyvalue(0),
                                $!context.factory.fancyvalue(2), $!context.factory.fancyvalue(3));
        $A.row_combine(1, 0, $!context.factory.fancyvalue(0));
        Assert::equal($A, $B, "cannot row_combine");
    }
}
