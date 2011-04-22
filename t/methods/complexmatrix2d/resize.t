my $context := PLA::TestContext.new;
$context.set_factory(Pla::MatrixFactory::ComplexMatrix2D);
Rosella::Test::test(Test::ComplexMatrix2D::Resize, :context($context));

class Test::ComplexMatrix2D::Resize is Pla::Methods::Resize {

}
