my $context := PLA::TestContext.new;
$context.set_factory(Pla::MatrixFactory::ComplexMatrix2D);
Rosella::Test::test(Test::ComplexMatrix2D::IterateFunctionExternal, :context($context));

class Test::ComplexMatrix2D::IterateFunctionExternal is Pla::Methods::IterateFunctionExternal {

}
