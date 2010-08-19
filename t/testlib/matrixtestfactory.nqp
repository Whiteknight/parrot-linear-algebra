class Pla::MatrixFactory {
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

    method defaultmatrix3x3() {
        return self.matrix3x3(
            self.defaultvalue(),
            self.defaultvalue(),
            self.defaultvalue(),
            self.defaultvalue(),
            self.defaultvalue(),
            self.defaultvalue(),
            self.defaultvalue(),
            self.defaultvalue(),
            self.defaultvalue()
        );
    }
}

class Pla::MatrixFactory::ComplexMatrix2D is Pla::MatrixFactory {
    our method defaultvalue() {
        return (pir::new__PSP("Complex", "1+1i"));
    }

    method nullvalue() {
        return (pir::new__PSP("Complex", "0+0i"));
    }

    method fancyvalue($idx) {
        return (
            pir::new__PSP("Complex",
                ["6+6i", "7+7i", "8+8i", "9+9i"][$idx]
            )
        );
    }

    our method matrix() {
        my $m := Parrot::new("ComplexMatrix2D");
        return ($m);
    }

    method matrix2x2($aa, $ab, $ba, $bb) {
        my $m := self.matrix();
        if (pir::typeof__SP($aa) eq "String") { $aa := pir::new__PSP("Complex", $aa); }
        if (pir::typeof__SP($ab) eq "String") { $ab := pir::new__PSP("Complex", $ab); }
        if (pir::typeof__SP($ba) eq "String") { $ba := pir::new__PSP("Complex", $ba); }
        if (pir::typeof__SP($bb) eq "String") { $bb := pir::new__PSP("Complex", $bb); }
        $m{Key.new(0,0)} := $aa;
        $m{Key.new(0,1)} := $ab;
        $m{Key.new(1,0)} := $ba;
        $m{Key.new(1,1)} := $bb;
        return ($m);
    }

    method defaultmatrix2x2() {
        return (self.matrix2x2("1+1i", "1+1i", "1+1i", "1+1i"));
    }
}

class Pla::MatrixFactory::NumMatrix2D is Pla::MatrixFactory {
    method matrix() {
        my $m := Parrot::new("NumMatrix2D");
        return ($m);
    }

    method defaultvalue() { 1.0; }
    method nullvalue() { 0.0; }
    method fancyvalue($idx) {
        [5.1, 6.2, 7.3, 8.4][$idx];
    }
}

class Pla::MatrixFactory::PMCMatrix2D is Pla::MatrixFactory {
    method matrix() {
        return (Parrot::new("PMCMatrix2D"));
    }

    method defaultvalue() { 1; }
    method nullvalue() { return (pir::null__P()); }
    method fancyvalue($idx) {
        [5, 6, 7, 8][$idx];
    }
}
