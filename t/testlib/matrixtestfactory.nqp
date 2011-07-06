class Pla::MatrixFactory {
    # A default value which can be set at a particular location and tested
    method defaultvalue() {
        $!assert.RequireOverride(self.defaultvalue);
    }

    sub key(*@parts) {
        my $key;
        my $segment;

        for @parts {
            $segment := pir::new__PS('Key');

            if pir::isa($_, 'Integer' )	{ pir::assign__vPI($segment, $_); }
            elsif pir::isa($_, 'Float' )	{ pir::assign__vPN($segment, $_); }
            elsif pir::isa($_, 'String' )	{ pir::assign__vPS($segment, $_); }
            else {
                pir::die('Arguments to key must be Integer, String, or Float');
            }

            if pir::defined($key) {
                pir::push__vpp($key, $segment);
            }
            else {
                $key := $segment;
            }
        }

        $key;
    }

    method key(*@parts) {
        key(|@parts);
    }

    # The null value which is auto-inserted into the matrix on resize.
    method nullvalue() {
        $!assert.RequireOverride(self.nullvalue);
    }

    # A novel value which can be used to flag interesting changes in tests.
    method fancyvalue($idx) {
        $!assert.RequireOverride(self.fancyvalue);
    }

    # Create an empty matrix of the given type
    method matrix() {
        $!assert.RequireOverride(self.matrix);
    }

    # Create a 2x2 matrix of the type with given values row-first
    method matrix2x2($aa, $ab, $ba, $bb) {
        my $m := self.matrix();
        $m{key(0,0)} := $aa;
        $m{key(0,1)} := $ab;
        $m{key(1,0)} := $ba;
        $m{key(1,1)} := $bb;
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
        $m{key(0,0)} := $aa;
        $m{key(0,1)} := $ab;
        $m{key(0,2)} := $ac;
        $m{key(1,0)} := $ba;
        $m{key(1,1)} := $bb;
        $m{key(1,2)} := $bc;
        $m{key(2,0)} := $ca;
        $m{key(2,1)} := $cb;
        $m{key(2,2)} := $cc;
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

    our method matrix() { pir::new__PS("ComplexMatrix2D"); }

    method matrix2x2($aa, $ab, $ba, $bb) {
        my $m := self.matrix();
        if (pir::typeof__SP($aa) eq "String") { $aa := pir::new__PSP("Complex", $aa); }
        if (pir::typeof__SP($ab) eq "String") { $ab := pir::new__PSP("Complex", $ab); }
        if (pir::typeof__SP($ba) eq "String") { $ba := pir::new__PSP("Complex", $ba); }
        if (pir::typeof__SP($bb) eq "String") { $bb := pir::new__PSP("Complex", $bb); }
        $m{Pla::MatrixFactory::key(0,0)} := $aa;
        $m{Pla::MatrixFactory::key(0,1)} := $ab;
        $m{Pla::MatrixFactory::key(1,0)} := $ba;
        $m{Pla::MatrixFactory::key(1,1)} := $bb;
        return ($m);
    }

    method defaultmatrix2x2() {
        return (self.matrix2x2("1+1i", "1+1i", "1+1i", "1+1i"));
    }
}

class Pla::MatrixFactory::NumMatrix2D is Pla::MatrixFactory {
    method matrix() { pir::new__PS("NumMatrix2D"); }

    method defaultvalue() { 1.0; }
    method nullvalue() { 0.0; }
    method fancyvalue($idx) {
        [5.1, 6.2, 7.3, 8.4][$idx];
    }
}

class Pla::MatrixFactory::PMCMatrix2D is Pla::MatrixFactory {
    method matrix() { pir::new__PS("PMCMatrix2D"); }

    method defaultvalue() { 1; }
    method nullvalue() { return (pir::null__P()); }
    method fancyvalue($idx) {
        [5, 6, 7, 8][$idx];
    }
}
