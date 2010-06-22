#! parrot-nqp

INIT {
    pir::load_bytecode('./library/kakapo_full.pbc');
    pir::loadlib__ps("./linalg_group");
}

main();

sub main() {
    pir::say("Matrix A:");
    my $A := matrix3x3(1.0, 2.0, 3.0,
                       4.0, 5.0, 6.0,
                       7.0, 8.0, 9.0);
    pir::say($A);
    my $B := pir::clone($A);
    gaussian_elimination($A);
    pir::say("Row Eschelon Form:");
    pir::say($A);

    gauss_jordan_elimination($B);
    pir::say("Reduced Row Eschelon Form:");
    pir::say($B);
}

sub matrix3x3($aa, $ab, $ac, $ba, $bb, $bc, $ca, $cb, $cc) {
    my $m := Parrot::new("NumMatrix2D");
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

sub gaussian_elimination($A) {
    my $i := 0;
    my $j := 0;
    my $m := pir::getattribute__PPS($A, "rows");
    my $n := pir::getattribute__PPS($A, "cols");
    while ($i < $m && $j < $n) {
        my $maxi := pir::clone($i);
        my $k := pir::clone($i) + 1;
        while ($k < $m) {
            if ($A{Key.new($k, $j)} > $A{Key.new($maxi, $j)}) {
                $maxi := pir::clone($k);
            }
            $k++;
        }
        if ($A{Key.new($maxi, $j)} != 0) {
            pir::say("row " ~ $maxi ~ " <-> row " ~ $i);
            $A.row_swap($maxi, $i);
            #pir::say($A);

            my $scale := $A{Key.new($i, $j)};
            pir::say("row " ~ $i ~ " / " ~ $scale);
            $A.row_scale($i, (1/$scale));
            #pir::say($A);

            my $u := pir::clone($i) + 1;
            while ($u < $m) {
                my $gain_u := $A{Key.new($u, $j)};
                pir::say((-$gain_u) ~ " * row " ~ $u ~ " -> row " ~ $i);
                $A.row_combine($i, $u, -$gain_u);
                #pir::say($A);

                $u++;
            }
            $i++;
        }
        $j++;
    }
}

sub gauss_jordan_elimination($A) {
    my $i := 0;
    my $j := 0;
    my $m := pir::getattribute__PPS($A, "rows");
    my $n := pir::getattribute__PPS($A, "cols");
    while ($i < $m && $j < $n) {
        my $maxi := pir::clone($i);
        my $k := pir::clone($i) + 1;
        while ($k < $m) {
            if ($A{Key.new($k, $j)} > $A{Key.new($maxi, $j)}) {
                $maxi := pir::clone($k);
            }
            $k++;
        }
        if ($A{Key.new($maxi, $j)} != 0) {
            pir::say("row " ~ $maxi ~ " <-> row " ~ $i);
            $A.row_swap($maxi, $i);
            #pir::say($A);

            my $scale := $A{Key.new($i, $j)};
            pir::say("row " ~ $i ~ " / " ~ $scale);
            $A.row_scale($i, (1/$scale));
            #pir::say($A);

            my $u := pir::clone($i) + 1;
            while ($u < $m) {
                my $gain_u := $A{Key.new($u, $j)};
                pir::say((-$gain_u) ~ " * row " ~ $u ~ " -> row " ~ $i);
                $A.row_combine($i, $u, -$gain_u);
                #pir::say($A);

                $u++;
            }
            $u := pir::clone($i) - 1;
            while ($u >= 0) {
                my $gain_u := $A{Key.new($u, $j)};
                pir::say((-$gain_u) ~ " * row " ~ $u ~ " -> row " ~ $i);
                $A.row_combine($i, $u, -$gain_u);
                #pir::say($A);

                $u--;
            }
            $i++;
        }
        $j++;
    }
}
