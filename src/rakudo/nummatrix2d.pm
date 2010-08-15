class P6NumMatrix2D {

    has $.matrix is rw;

    submethod BUILD(*%n) {
        if %n.contains("matrix") {
            say "m not null";
            $.matrix = %n<matrix>;
        } else {
            my $m;
            Q:PIR {
                $P0 = get_root_global "PLALibrary"
                unless null $P0 goto __PLA_have_library
                $P0 = loadlib "linalg_group"
                set_root_global "PLALibrary", $P0
                unless null $P0 goto __PLA_have_library
                die "cannot load linalg_group"
                __PLA_have_library:
                $P1 = root_new ["parrot";"NumMatrix2D"]
                store_lex '$m', $P1
            };
            $.matrix = $m;
        }
        #}
    }

    method Str() {
        return ~$.matrix;
    }

    multi method get($row, $col) {
        return self!matrix.item_at($row, $col);
    }

    multi method get($row, $col, $rows, $cols) {
        my $block = self.get_block($row, $col, $rows, $cols);
        my $new = NumMatrix2D.new($block);
        return $new;
    }

    multi method set($row, $col, $val) {
        $.matrix.item_at($row, $col, $val);
    }

    multi method set($row, $col, $rows, $cols, $block) {
        $.matrix.set_block($row, $col, $rows, $cols, $block);
    }

    method map(&block) {
        my $matrix = $.matrix.iterate_function_external(
            -> $me, $val, $row, $col {
                &block($val);
            });
        my $new = P6NumMatrix2D.new(matrix => $matrix);
        return $new;
    }

    method fill($value, *@coords) {
        if +@coords == 0 { $.matrix.fill($value); }
        elsif +@coords == 1 { $.matrix.fill($value, @coords[0]); }
        elsif +@coords == 2 { $.matrix.fill($value, @coords[0], @coords[1]); }
    }

    method transpose(:$mem?) {
        if $mem.defined { $.matrix.mem_transpose(); }
        else { $.matrix.transpose(); }
    }
}
