# Bootstrapper file to setup PLA for use in an NQP program. This does three
# things:
#   1) Loads the linalg_group library into Parrot
#   2) Stores a reference to the library object in the global $PLALibrary
#   3) Registers the PMC types with P6metaclass

INIT {
    pir::load_bytecode__vS("P6object.pbc");
    my $pla := pir::loadlib__PS("linalg_group");
    pir::set_hll_global__vSP(<$PLALibrary>, $pla);
    P6metaclass.register("NumMatrix2D");
    P6metaclass.register("PMCMatrix2D");
    P6metaclass.register("ComplexMatrix2D");
}
