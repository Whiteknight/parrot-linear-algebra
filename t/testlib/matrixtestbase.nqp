# Copyright (C) 2010, Andrew Whitworth. See accompanying LICENSE file, or
# http://www.opensource.org/licenses/artistic-license-2.0.php for license.

# Basic test class for testing matrices. Provides the utilities necessary for
# testing a matrix. Actual test cases should not inherit from this class
# directly, but instead inherit from a specialized sub-type depending on the
# PMC being tested
class Pla::Matrix::MatrixTestBase is UnitTest::Testcase {

    INIT {
        use('UnitTest::Testcase');
        use('UnitTest::Assertions');
    }

    method default_loader() { Pla::Matrix::Loader.new; }

    method RequireOverride($m) {
        Exception::MethodNotFound.new(
            :message("Must subclass " ~ $m ~ " in your test class")
        ).throw;
    }

    # A default value which can be set at a particular location and tested
    method defaultvalue() {
        self.RequireOverride(self.defaultvalue);
    }

    # The null value which is auto-inserted into the matrix on resize.
    method nullvalue() {
        self.RequireOverride(self.nullvalue);
    }

    # A novel value which can be used to flag interesting changes in tests.
    method fancyvalue($idx) {
        self.RequireOverride(self.fancyvalue);
    }

    # Create an empty matrix of the given type
    method matrix() {
        self.RequireOverride(self.matrix);
    }

    # Create a 2x2 matrix of the type with given values row-first
    method matrix2x2($aa, $ab, $ba, $bb) {
        my $m := self.matrix();
        $m{Key.new(0,0)} := $aa;
        $m{Key.new(0,1)} := $ab;
        $m{Key.new(1,0)} := $ba;
        $m{Key.new(1,1)} := $bb;
        return ($m);
    }

    # Create a 2x2 matrix completely filled with a single default value
    method defaultmatrix2x2() {
        return self.matrix2x2(
            self.defaultvalue(),
            self.defaultvalue(),
            self.defaultvalue(),
            self.defaultvalue()
        );
    }

    # Create a 2x2 matrix with interesting values in each slot.
    method fancymatrix2x2() {
        return self.matrix2x2(
            self.fancyvalue(0),
            self.fancyvalue(1),
            self.fancyvalue(2),
            self.fancyvalue(3)
        );
    }

    # Create a 3x3 matrix of the type with given values row-first
    method matrix3x3($aa, $ab, $ac, $ba, $bb, $bc, $ca, $cb, $cc) {
        my $m := self.matrix();
        $m{Key.new(0,0)} := $aa;
        $m{Key.new(0,1)} := $ab;
        $m{Key.new(0,2)} := $ac;
        $m{Key.new(1,0)} := $ba;
        $m{Key.new(1,1)} := $bb;
        $m{Key.new(1,2)} := $bc;
        $m{Key.new(2,0)} := $ca;
        $m{Key.new(2,1)} := $cb;
        $m{Key.new(2,2)} := $cc;
        return ($m);
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
        my $nullval := self.nullvalue;
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

