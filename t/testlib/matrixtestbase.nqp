# Copyright (C) 2010, Andrew Whitworth. See accompanying LICENSE file, or
# http://www.opensource.org/licenses/artistic-license-2.0.php for license.

# Basic test class for testing matrices. Provides the utilities necessary for
# testing a matrix. Actual test cases should not inherit from this class
# directly, but instead inherit from a specialized sub-type depending on the
# PMC being tested
class Pla::MatrixTestBase is UnitTest::Testcase {

    INIT {
        use('UnitTest::Testcase');
        use('UnitTest::Assertions');
    }

    method factory() {
        self.RequireOverride("factory");
    }

    method RequireOverride($m) {
        Exception::MethodNotFound.new(
            :message("Must subclass " ~ $m ~ " in your test class")
        ).throw;
    }

    method AssertSize($m, $rows, $cols) {
        my $real_rows := pir::getattribute__PPS($m, "rows");
        my $real_cols := pir::getattribute__PPS($m, "cols");
        assert_equal($real_rows, $rows,
            "matrix does not have correct number of rows. $rows expected, $real_rows actual");
        assert_equal($real_cols, $cols,
            "matrix does not have correct number of columns. $cols expected, $real_cols actual");
    }

    method AssertNullValueAt($m, $row, $col) {
        my $nullval := self.factory.nullvalue;
        my $val := $m{Key.new($row, $col)};
        if pir::isnull__IP($nullval) == 1 {
            assert_instance_of($val, "Undef",
                "Expected null value at position ($row,$col). Had $val.");
        } else {
            assert_equal($val, $nullval,
                "Expected default value $nullval at position ($row,$col). Had $val");
        }
    }

    method AssertValueAtIs($m, $row, $col, $expected) {
        my $val := $m{Key.new($row, $col)};
        if pir::isnull__IP($expected) {
            assert_null($val, "Value not null at ($row,$col). Have $val");
        } else {
            assert_equal($val, $expected,
                "Values not equal at ($row,$col). Had $val, wanted $expected");
        }
    }

    method AssertHasMethod($x, $meth) {
        my $found;
        Q:PIR {
            $P0 = find_lex "$x"
            $P1 = find_lex "$meth"
            $S0 = $P1
            $P2 = find_method $P0, $S0
            store_lex "$found", $P2
        };
        my $type := pir::typeof__SP($x);
        assert_not_null($found, $type ~ " does not have method " ~ $meth);
    }
}

