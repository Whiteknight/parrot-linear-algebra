INIT {
    pir::load_bytecode__vS("src/nqp/pla.pbc");
}

MAIN();

sub MAIN() {
    my $nm := NumMatrix2D.new();
    $nm.initialize_from_args(2, 2, 1, 2, 3, 4);
    pir::say($nm);
}
