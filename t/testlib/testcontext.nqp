class PLA::TestContext is Rosella::Test::TestContext {
    has $!factory;

    method set_factory($f) { $!factory := $f; }
    method factory() { $!factory; }
}
