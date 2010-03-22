#! parrot-nqp

class Test::Sanity is UnitTest::Testcase;

INIT {
    use('UnitTest::Testcase');
    use('UnitTest::Assertions');
}

MAIN();
sub MAIN() {
	my $proto := Opcode::get_root_global(pir::get_namespace__P().get_name);
	$proto.suite.run;
}

method test_load_linalg_group() {
    my $pla := pir::loadlib__ps("./linalg_group");
    assert_not_instance_of($pla, "Undef", "Cannot load PLA library, linalg_group");
}

