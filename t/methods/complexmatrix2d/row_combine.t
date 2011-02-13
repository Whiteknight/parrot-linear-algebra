my $tests := Test::ComplexMatrix2D::RowCombine.new();
$tests.suite.run;

class Test::ComplexMatrix2D::RowCombine is Pla::Methods::RowCombine {
    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::ComplexMatrix2D.new();
        }
        return $!factory;
    }

    method test_row_combine_complex() {
        my $A := self.factory.fancymatrix2x2();
        my $val1;
        my $val2;
        my $factory := self.factory;
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

        my $B := self.factory.matrix2x2($val1, $val2,
                                self.factory.fancyvalue(2), self.factory.fancyvalue(3));
        $A.row_combine(1, 0, 1);
        assert_equal($A, $B, "cannot row_combine");
    }

    method test_non_unity_gain_complex() {
        my $A := self.factory.fancymatrix2x2();
        my $B := self.factory.matrix2x2(self.factory.fancyvalue(0) + self.factory.fancyvalue(2) * self.factory.fancyvalue(0),
                                self.factory.fancyvalue(1) + self.factory.fancyvalue(3)  * self.factory.fancyvalue(0),
                                self.factory.fancyvalue(2), self.factory.fancyvalue(3));
        $A.row_combine(1, 0, self.factory.fancyvalue(0));
        assert_equal($A, $B, "cannot row_combine");
    }
}
