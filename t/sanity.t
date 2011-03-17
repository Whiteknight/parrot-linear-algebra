#! parrot-nqp

Rosella::Test::test(Test::Sanity);

class Test::Sanity is Rosella::Test::Testcase {

    method test_load_linalg_group() {
        my $pla := pir::loadlib__ps("./dynext/linalg_group");
        Assert::not_instance_of($pla, "Undef", "Cannot load PLA library, linalg_group");
    }
}
