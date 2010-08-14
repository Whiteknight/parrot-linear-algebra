class NumMatrix2D does Matrix {

    method new(:$matrix?) {
        my $new = self.bless(*);
        unless $matrix.defined {
            $matrix = pir::new__PS("NumMatrix2D");
        }
        pir::setattribute__vpsp($new, "$!matrix", $matrix);
        return $new;
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
        if +@coords == 0 { self!matrix.fill($value); }
        elsif +@coords == 1 { self!matrix.fill($value, @coords[0]); }
        elsif +@coords == 2 { self!matrix.fill($value, @coords[0], @coords[1]; }
    }

    method transpose(:$mem?) {
        if $mem.defined { self!matrix.mem_transpose(); }
        else { self!matrix.transpose(); }
    }

}
