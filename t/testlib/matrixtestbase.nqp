# Copyright (C) 2010, Andrew Whitworth. See accompanying LICENSE file, or
# http://www.opensource.org/licenses/artistic-license-2.0.php for license.

# Basic test class for testing matrices. Provides the utilities necessary for
# testing a matrix. Actual test cases should not inherit from this class
# directly, but instead inherit from a specialized sub-type depending on the
# PMC being tested
class Pla::MatrixAsserter is Rosella::Test::Asserter {
    method RequireOverride($m) {
        Exception::MethodNotFound.new(
            :message("Must subclass " ~ $m ~ " in your test class")
        ).throw;
    }

    method Size($m, $rows, $cols) {
        my $real_rows := pir::getattribute__PPS($m, "rows");
        my $real_cols := pir::getattribute__PPS($m, "cols");
        self.equal($real_rows, $rows,
            "matrix does not have correct number of rows. $rows expected, $real_rows actual");
        self.equal($real_cols, $cols,
            "matrix does not have correct number of columns. $cols expected, $real_cols actual");
    }

    method NullValueAt($factory, $m, $row, $col) {
        my $nullval := $factory.nullvalue;
        my $val := $m{$factory.key($row, $col)};
        if pir::isnull__IP($nullval) == 1 {
            self.instance_of($val, "Undef",
                "Expected null value at position ($row,$col). Had $val.");
        } else {
            self.equal($val, $nullval,
                "Expected default value $nullval at position ($row,$col). Had $val");
        }
    }

    method ValueAtIs($factory, $m, $row, $col, $expected) {
        my $val := $m{$factory.key($row, $col)};
        if pir::isnull__IP($expected) {
            self.null($val, "Value not null at ($row,$col). Have $val");
        } else {
            self.equal($val, $expected,
                "Values not equal at ($row,$col). Had $val, wanted $expected");
        }
    }

    method HasMethod($x, $meth) {
        my $found;
        Q:PIR {
            $P0 = find_lex "$x"
            $P1 = find_lex "$meth"
            $S0 = $P1
            $P2 = find_method $P0, $S0
            store_lex "$found", $P2
        };
        my $type := pir::typeof__SP($x);
        self.not_null($found, $type ~ " does not have method " ~ $meth);
    }
}

module Pla::MatrixTestBase {
    our sub Test($type, $factorytype) {
        my $pla := pir::loadlib__ps("./dynext/linalg_group");
        my $context := Rosella::construct(PLA::TestContext);
        $context.set_factory($factorytype);
        $context.set_data("factory_complex", Pla::MatrixFactory::ComplexMatrix2D.new);
        $context.set_data("factory_pmc", Pla::MatrixFactory::PMCMatrix2D.new);
        $context.set_data("factory_number", Pla::MatrixFactory::NumMatrix2D.new);
        my $asserter := Rosella::construct(Pla::MatrixAsserter);
        Rosella::Test::add_matcher("matrix", Pla::MatrixTestMatcher.new);
        Rosella::Test::test($type, :context($context), :asserter($asserter));
    }
}

class Pla::MatrixTestBase { }

class Pla::MatrixTestMatcher is Rosella::Test::Matcher {
    method expect_match($a, $b) {
        my $a_rows := pir::getattribute__PPS($a, "rows");
        my $a_cols := pir::getattribute__PPS($a, "cols");
        my $b_rows := pir::getattribute__PPS($b, "rows");
        my $b_cols := pir::getattribute__PPS($b, "cols");
        if ($a_rows != $b_rows || $a_cols != $b_cols) {
            return Rosella::construct(Rosella::Test::FailureResult, "Matrix dimensions [$a_rows, $a_cols] does not equal [$b_rows, $b_cols]");
        }
        my $i := 0;
        while $i < $a_rows {
            my $j := 0;
            while $j < $a_cols {
                my $val_a := $a{$!context.factory.key($i, $j)};
                my $val_b := $b{$!context.factory.key($i, $j)};
                if ($val_a != $val_b) {
                    Rosella::construct(Rosella::Test::FailureResult, "Value at [$i, $j] does not match");
                }
            }
        }
        Rosella::construct(Rosella::Test::SuccessResult);
    }

    method expect_no_match($a, $b) {
        my $a_rows := pir::getattribute__PPS($a, "rows");
        my $a_cols := pir::getattribute__PPS($a, "cols");
        my $b_rows := pir::getattribute__PPS($b, "rows");
        my $b_cols := pir::getattribute__PPS($b, "cols");
        if ($a_rows != $b_rows || $a_cols != $b_cols) {
            return Rosella::construct(Rosella::Test::SuccessResult);
        }
        my $i := 0;
        while $i < $a_rows {
            my $j := 0;
            while $j < $a_cols {
                my $val_a := $a{$!context.factory.key($i, $j)};
                my $val_b := $b{$!context.factory.key($i, $j)};
                if ($val_a != $val_b) {
                    Rosella::construct(Rosella::Test::SuccessResult);
                }
            }
        }
        Rosella::construct(Rosella::Test::FailureResult, "Matrices match (and shouldn't)");
    }

    method can_match($a, $b) {
        return pir::does__ips($a, "matrix") && pir::does__ips($b, "matrix");
    }
}
