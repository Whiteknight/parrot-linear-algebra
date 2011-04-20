#! parrot-nqp

Rosella::Test::test(Test::Sanity);

class Test::Sanity {

    method test_load_linalg_group() {
        my $pla := pir::loadlib__ps("./dynext/linalg_group");
        Assert::defined($pla, "Cannot load PLA library, linalg_group");
    }
}
