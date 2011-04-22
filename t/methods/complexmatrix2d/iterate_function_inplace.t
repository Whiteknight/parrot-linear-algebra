my $context := PLA::TestContext.new;
$context.set_factory(Pla::MatrixFactory::ComplexMatrix2D);
Rosella::Test::test(Test::ComplexMatrix2D::IterateFunctionInplace, :context($context));

class Test::ComplexMatrix2D::IterateFunctionInplace is Pla::Methods::IterateFunctionInplace {

}
