INIT {
    pir::load_bytecode__vS("P6object.pbc");
    my $pla := pir::loadlib__PS("./dynext/linalg_group");
    pir::set_hll_global__vSP(<$PLALibrary>, $pla);
    P6metaclass.register("NumMatrix2D");
    P6metaclass.register("PMCMatrix2D");
    P6metaclass.register("ComplexMatrix2D");
}
