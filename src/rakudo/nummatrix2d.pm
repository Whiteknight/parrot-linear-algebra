class P6NumMatrix2D {

    has $.matrix;

    method new(:$matrix?) {
        my $m = $matrix;
        unless $matrix.defined {
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
        }
        my $new = self.bless(*, matrix => $m);
        return $new;
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

    method set($row, $col, $val) {
        self!matrix.item_at($row, $col, $val);
    }

    method set($row, $col, $rows, $cols, $block) {
        self!matrix.set_block($row, $col, $rows, $cols, $block);
    }

    method map(&block) {
        my $matrix = self!iterate_function_external(
            -> $me, $val, $row, $col {
                &block($val);
            });
        my $new = NumMatrix2D.new($matrix);
        return $new;
    }

    method fill($value, *@coords) {
        if +@coords == 0 { $.matrix.fill($value); }
        elsif +@coords == 1 { $.matrix.fill($value, @coords[0]); }
        elsif +@coords == 2 { $.matrix.fill($value, @coords[0], @coords[1]); }
    }

    method transpose(:$mem?) {
        if $mem.defined { self!matrix.mem_transpose(); }
        else { self!matrix.transpose(); }
    }
}
