class Pla::Methods::IterateFunctionExternal is Pla::MatrixTestBase {

    # Test that we can iterate_function_external, and create a new matrix
    method test_iterate_function_external() {
        my $m := self.factory.fancymatrix2x2();
        my $sub := sub ($matrix, $value, $x, $y) {
            return $value;
        };
        my $o := $m.iterate_function_external($sub);
        assert_equal($o, $m, "Cannot copy by iterating external");
    }

    # Test that iterate_function_external passes the correct coordinates
    method test_get_correct_coordinates() {
        my $m := self.factory.matrix2x2(self.factory.nullvalue, self.factory.nullvalue,
                                self.factory.nullvalue, self.factory.nullvalue);
        my $n := self.factory.matrix2x2(self.factory.fancyvalue(0), self.factory.fancyvalue(1),
                                self.factory.fancyvalue(1), self.factory.fancyvalue(2));
        my $sub := pir::newclosure__PP(sub ($matrix, $value, $x, $y) {
            return (self.factory.fancyvalue($x + $y));
        });
        my $o := $m.iterate_function_external($sub);
        assert_equal($o, $n, "cannot iterate external with proper coords");
    }

    # Test that iterate_function_external passes the correct args
    method test_passes_optional_args() {
        my $m := self.factory.matrix2x2(self.factory.nullvalue, self.factory.nullvalue,
                                self.factory.nullvalue, self.factory.nullvalue);
        my $n := self.factory.matrix2x2(self.factory.fancyvalue(3), self.factory.fancyvalue(3),
                                self.factory.fancyvalue(3), self.factory.fancyvalue(3));
        my $sub := pir::newclosure__PP(sub ($matrix, $value, $x, $y, $a, $b) {
            return (self.factory.fancyvalue($a + $b));
        });
        my $o := $m.iterate_function_external($sub, 1, 2);
        assert_equal($o, $n, "cannot iterate external with args");
    }

    # Test that iterate_function_external respects the transpose state of the
    # matrix
    method test_handles_lazy_transpose() {
        my $m := self.factory.fancymatrix2x2();
        $m.transpose();
        my $n := self.factory.matrix2x2(self.factory.fancyvalue(0) * 2, self.factory.fancyvalue(2) * 2,
                                self.factory.fancyvalue(1) * 2, self.factory.fancyvalue(3) * 2);
        my $sub := sub ($matrix, $value, $x, $y) {
            return $value * 2;
        };
        my $o := $m.iterate_function_external($sub);
        assert_equal($o, $n, "external iteration does not respect transpose");
    }
}
