#! parrot-nqp

INIT {
    my $rosella := pir::load_bytecode__Ps("rosella/core.pbc");
    Rosella::initialize_rosella("test");
    Rosella::load_bytecode_file('t/testlib/pla_test.pbc', "load");
}

Rosella::Test::test(Test::Sanity);

class Test::Sanity {

    method test_load_linalg_group() {
        my $pla := pir::loadlib__ps("./dynext/linalg_group");
        $!assert.defined($pla, "Cannot load PLA library, linalg_group");
    }
}
