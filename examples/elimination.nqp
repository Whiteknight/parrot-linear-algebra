#! parrot-nqp

INIT {
    pir::load_bytecode('./src/nqp/pla.pbc');
}

main();

sub main() {
    pir::say("Matrix A:");
    my $A := NumMatrix2D.new();
    $A.initialize_from_args(3, 3,
                            1.0, 2.0, 3.0,
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

sub gaussian_elimination($A) {
    my $i := 0;
    my $j := 0;
    my $m := pir::getattribute__PPS($A, "rows");
    my $n := pir::getattribute__PPS($A, "cols");
    while ($i < $m && $j < $n) {
        my $maxi := pir::clone($i);
        my $k := pir::clone($i) + 1;
        while ($k < $m) {
            if ($A.item_at($k, $j) > $A.item_at($maxi, $j)) {
                $maxi := pir::clone($k);
            }
            $k++;
        }
        if ($A.item_at($maxi, $j) != 0) {
            pir::say("row " ~ $maxi ~ " <-> row " ~ $i);
            $A.row_swap($maxi, $i);
            #pir::say($A);

            my $scale := $A.item_at($i, $j);
            pir::say("row " ~ $i ~ " / " ~ $scale);
            $A.row_scale($i, (1/$scale));
            #pir::say($A);

            my $u := pir::clone($i) + 1;
            while ($u < $m) {
                my $gain_u := $A.item_at($u, $j);
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
            if ($A.item_at($k, $j) > $A.item_at($maxi, $j)) {
                $maxi := pir::clone($k);
            }
            $k++;
        }
        if ($A.item_at($maxi, $j) != 0) {
            pir::say("row " ~ $maxi ~ " <-> row " ~ $i);
            $A.row_swap($maxi, $i);
            #pir::say($A);

            my $scale := $A.item_at($i, $j);
            pir::say("row " ~ $i ~ " / " ~ $scale);
            $A.row_scale($i, (1/$scale));
            #pir::say($A);

            my $u := pir::clone($i) + 1;
            while ($u < $m) {
                my $gain_u := $A.item_at($u, $j);
                pir::say((-$gain_u) ~ " * row " ~ $u ~ " -> row " ~ $i);
                $A.row_combine($i, $u, -$gain_u);
                #pir::say($A);

                $u++;
            }
            $u := pir::clone($i) - 1;
            while ($u >= 0) {
                my $gain_u := $A.item_at($u, $j);
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
