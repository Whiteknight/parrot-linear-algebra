
class Pla::Matrix::Loader is Rosella::Test::Loader {

    method order_tests(@tests) {
        my $test_method := 'test_ME';
        my $test_op := 'test_OP';
        my $test_vtable := 'test_VT';

        my $len := $test_op.length;	# The shortest

        my %partition;
        for <test_me test_op test_vt MISC> {
            %partition{$_} := [ ];
        }

        for @tests -> $name {
            my $name_lc := pir::downcase__SS($name).substr(0, $len);

            if %partition.contains( $name_lc ) {
                %partition{$name_lc}.push: $name;
            }
            else {
                %partition<MISC>.push: $name;
            }
        }

        my @result;
        for <test_op test_vt MISC test_me> {
            @result.append: %partition{$_}.unsort;
        }

        @result;
    }
}
