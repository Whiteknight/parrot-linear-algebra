use v6;
use src::rakudo::nummatrix2d;

my $matrix = P6NumMatrix2D.new();
$matrix.fill(1.0, 2, 2);
say $matrix;
