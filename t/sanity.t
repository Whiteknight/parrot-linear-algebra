#! parrot-nqp

class Test::Sanity is UnitTest::Testcase;

MAIN();
sub MAIN() {
    my $proto := Opcode::get_root_global(pir::get_namespace__P().get_name);
    $proto.suite.run;
}

method test_load_linalg_group() {
    my $pla := pir::loadlib__ps("./dynext/linalg_group");
    UnitTest::Assertions::assert_not_instance_of($pla, "Undef", "Cannot load PLA library, linalg_group");
}

