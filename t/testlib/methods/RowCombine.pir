
.namespace []
.sub "_block11"  :anon :subid("10_1282246489.55033")
.annotate 'line', 0
    get_hll_global $P14, ["Pla";"Methods";"RowCombine"], "_block13" 
    capture_lex $P14
.annotate 'line', 1
    $P0 = find_dynamic_lex "$*CTXSAVE"
    if null $P0 goto ctxsave_done
    $I0 = can $P0, "ctxsave"
    unless $I0 goto ctxsave_done
    $P0."ctxsave"()
  ctxsave_done:
    get_hll_global $P14, ["Pla";"Methods";"RowCombine"], "_block13" 
    capture_lex $P14
    $P154 = $P14()
    .return ($P154)
    .const 'Sub' $P156 = "22_1282246489.55033" 
    .return ($P156)
.end


.namespace []
.sub "" :load :init :subid("post23") :outer("10_1282246489.55033")
.annotate 'line', 0
    .const 'Sub' $P12 = "10_1282246489.55033" 
    .local pmc block
    set block, $P12
    $P159 = get_root_global ["parrot"], "P6metaclass"
    $P159."new_class"("Pla::Methods::RowCombine", "Pla::MatrixTestBase" :named("parent"))
.end


.namespace ["Pla";"Methods";"RowCombine"]
.sub "_block13"  :subid("11_1282246489.55033") :outer("10_1282246489.55033")
.annotate 'line', 1
    .const 'Sub' $P138 = "20_1282246489.55033" 
    capture_lex $P138
    .const 'Sub' $P123 = "18_1282246489.55033" 
    capture_lex $P123
    .const 'Sub' $P108 = "16_1282246489.55033" 
    capture_lex $P108
    .const 'Sub' $P93 = "14_1282246489.55033" 
    capture_lex $P93
    .const 'Sub' $P46 = "13_1282246489.55033" 
    capture_lex $P46
    .const 'Sub' $P15 = "12_1282246489.55033" 
    capture_lex $P15
.annotate 'line', 66
    .const 'Sub' $P138 = "20_1282246489.55033" 
    newclosure $P153, $P138
.annotate 'line', 1
    .return ($P153)
.end


.namespace ["Pla";"Methods";"RowCombine"]
.sub "" :load :init :subid("post24") :outer("11_1282246489.55033")
.annotate 'line', 1
    get_hll_global $P14, ["Pla";"Methods";"RowCombine"], "_block13" 
    .local pmc block
    set block, $P14
.annotate 'line', 4
    "use"("UnitTest::Testcase")
.annotate 'line', 5
    "use"("UnitTest::Assertions")
.end


.namespace ["Pla";"Methods";"RowCombine"]
.include "except_types.pasm"
.sub "test_METHOD_row_combine"  :subid("12_1282246489.55033") :method :outer("11_1282246489.55033")
.annotate 'line', 8
    new $P17, 'ExceptionHandler'
    set_addr $P17, control_16
    $P17."handle_types"(.CONTROL_RETURN)
    push_eh $P17
    .lex "self", self
.annotate 'line', 9
    new $P18, "Undef"
    .lex "$A", $P18
.annotate 'line', 10
    new $P19, "Undef"
    .lex "$val1", $P19
.annotate 'line', 11
    new $P20, "Undef"
    .lex "$val2", $P20
.annotate 'line', 12
    new $P21, "Undef"
    .lex "$factory", $P21
.annotate 'line', 27
    new $P22, "Undef"
    .lex "$B", $P22
.annotate 'line', 9
    find_lex $P23, "self"
    $P24 = $P23."factory"()
    $P25 = $P24."fancymatrix2x2"()
    store_lex "$A", $P25
    find_lex $P26, "$val1"
    find_lex $P27, "$val2"
.annotate 'line', 12
    find_lex $P28, "self"
    $P29 = $P28."factory"()
    store_lex "$factory", $P29
.annotate 'line', 13

            .local pmc me
            me = find_lex "$factory"
            $P0 = me."fancyvalue"(0)
            $P1 = me."fancyvalue"(1)
            $P2 = me."fancyvalue"(2)
            $P3 = me."fancyvalue"(3)

            $P4 = $P0 + $P2
            $P5 = $P1 + $P3
            store_lex "$val1", $P4
            store_lex "$val2", $P5
        
.annotate 'line', 27
    find_lex $P30, "self"
    $P31 = $P30."factory"()
    find_lex $P32, "$val1"
    find_lex $P33, "$val2"
.annotate 'line', 28
    find_lex $P34, "self"
    $P35 = $P34."factory"()
    $P36 = $P35."fancyvalue"(2)
    find_lex $P37, "self"
    $P38 = $P37."factory"()
    $P39 = $P38."fancyvalue"(3)
    $P40 = $P31."matrix2x2"($P32, $P33, $P36, $P39)
.annotate 'line', 27
    store_lex "$B", $P40
.annotate 'line', 29
    find_lex $P41, "$A"
    $P41."row_combine"(1, 0, 1)
.annotate 'line', 30
    find_lex $P42, "$A"
    find_lex $P43, "$B"
    $P44 = "assert_equal"($P42, $P43, "cannot row_combine")
.annotate 'line', 8
    .return ($P44)
  control_16:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P45, exception, "payload"
    .return ($P45)
.end


.namespace ["Pla";"Methods";"RowCombine"]
.include "except_types.pasm"
.sub "test_METHOD_row_combine_GAIN"  :subid("13_1282246489.55033") :method :outer("11_1282246489.55033")
.annotate 'line', 33
    new $P48, 'ExceptionHandler'
    set_addr $P48, control_47
    $P48."handle_types"(.CONTROL_RETURN)
    push_eh $P48
    .lex "self", self
.annotate 'line', 34
    new $P49, "Undef"
    .lex "$A", $P49
.annotate 'line', 35
    new $P50, "Undef"
    .lex "$B", $P50
.annotate 'line', 34
    find_lex $P51, "self"
    $P52 = $P51."factory"()
    $P53 = $P52."fancymatrix2x2"()
    store_lex "$A", $P53
.annotate 'line', 35
    find_lex $P54, "self"
    $P55 = $P54."factory"()
    find_lex $P56, "self"
    $P57 = $P56."factory"()
    $P58 = $P57."fancyvalue"(0)
    find_lex $P59, "self"
    $P60 = $P59."factory"()
    $P61 = $P60."fancyvalue"(2)
    find_lex $P62, "self"
    $P63 = $P62."factory"()
    $N64 = $P63."fancyvalue"(0)
    mul $P65, $P61, $N64
    add $P66, $P58, $P65
.annotate 'line', 36
    find_lex $P67, "self"
    $P68 = $P67."factory"()
    $P69 = $P68."fancyvalue"(1)
    find_lex $P70, "self"
    $P71 = $P70."factory"()
    $P72 = $P71."fancyvalue"(3)
    find_lex $P73, "self"
    $P74 = $P73."factory"()
    $N75 = $P74."fancyvalue"(0)
    mul $P76, $P72, $N75
    add $P77, $P69, $P76
.annotate 'line', 37
    find_lex $P78, "self"
    $P79 = $P78."factory"()
    $P80 = $P79."fancyvalue"(2)
    find_lex $P81, "self"
    $P82 = $P81."factory"()
    $P83 = $P82."fancyvalue"(3)
    $P84 = $P55."matrix2x2"($P66, $P77, $P80, $P83)
.annotate 'line', 35
    store_lex "$B", $P84
.annotate 'line', 38
    find_lex $P85, "$A"
    find_lex $P86, "self"
    $P87 = $P86."factory"()
    $P88 = $P87."fancyvalue"(0)
    $P85."row_combine"(1, 0, $P88)
.annotate 'line', 39
    find_lex $P89, "$A"
    find_lex $P90, "$B"
    $P91 = "assert_equal"($P89, $P90, "cannot row_combine")
.annotate 'line', 33
    .return ($P91)
  control_47:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P92, exception, "payload"
    .return ($P92)
.end


.namespace ["Pla";"Methods";"RowCombine"]
.include "except_types.pasm"
.sub "test_METHOD_row_combine_NEGINDICES_A"  :subid("14_1282246489.55033") :method :outer("11_1282246489.55033")
.annotate 'line', 42
    .const 'Sub' $P98 = "15_1282246489.55033" 
    capture_lex $P98
    new $P95, 'ExceptionHandler'
    set_addr $P95, control_94
    $P95."handle_types"(.CONTROL_RETURN)
    push_eh $P95
    .lex "self", self
.annotate 'line', 43
    get_hll_global $P96, ["Exception"], "OutOfBounds"
.annotate 'line', 44
    .const 'Sub' $P98 = "15_1282246489.55033" 
    newclosure $P105, $P98
    $P106 = "assert_throws"($P96, "Index A is out of bounds", $P105)
.annotate 'line', 42
    .return ($P106)
  control_94:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P107, exception, "payload"
    .return ($P107)
.end


.namespace ["Pla";"Methods";"RowCombine"]
.sub "_block97"  :anon :subid("15_1282246489.55033") :outer("14_1282246489.55033")
.annotate 'line', 45
    new $P99, "Undef"
    .lex "$A", $P99
    find_lex $P100, "self"
    $P101 = $P100."factory"()
    $P102 = $P101."defaultmatrix3x3"()
    store_lex "$A", $P102
.annotate 'line', 46
    find_lex $P103, "$A"
    $P104 = $P103."row_combine"(-1, 1, 1)
.annotate 'line', 44
    .return ($P104)
.end


.namespace ["Pla";"Methods";"RowCombine"]
.include "except_types.pasm"
.sub "test_METHOD_row_combine_BOUNDS_A"  :subid("16_1282246489.55033") :method :outer("11_1282246489.55033")
.annotate 'line', 50
    .const 'Sub' $P113 = "17_1282246489.55033" 
    capture_lex $P113
    new $P110, 'ExceptionHandler'
    set_addr $P110, control_109
    $P110."handle_types"(.CONTROL_RETURN)
    push_eh $P110
    .lex "self", self
.annotate 'line', 51
    get_hll_global $P111, ["Exception"], "OutOfBounds"
.annotate 'line', 52
    .const 'Sub' $P113 = "17_1282246489.55033" 
    newclosure $P120, $P113
    $P121 = "assert_throws"($P111, "Index A is out of bounds", $P120)
.annotate 'line', 50
    .return ($P121)
  control_109:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P122, exception, "payload"
    .return ($P122)
.end


.namespace ["Pla";"Methods";"RowCombine"]
.sub "_block112"  :anon :subid("17_1282246489.55033") :outer("16_1282246489.55033")
.annotate 'line', 53
    new $P114, "Undef"
    .lex "$A", $P114
    find_lex $P115, "self"
    $P116 = $P115."factory"()
    $P117 = $P116."defaultmatrix3x3"()
    store_lex "$A", $P117
.annotate 'line', 54
    find_lex $P118, "$A"
    $P119 = $P118."row_combine"(7, 1, 1)
.annotate 'line', 52
    .return ($P119)
.end


.namespace ["Pla";"Methods";"RowCombine"]
.include "except_types.pasm"
.sub "test_METHOD_row_combine_NEGINDICES_B"  :subid("18_1282246489.55033") :method :outer("11_1282246489.55033")
.annotate 'line', 58
    .const 'Sub' $P128 = "19_1282246489.55033" 
    capture_lex $P128
    new $P125, 'ExceptionHandler'
    set_addr $P125, control_124
    $P125."handle_types"(.CONTROL_RETURN)
    push_eh $P125
    .lex "self", self
.annotate 'line', 59
    get_hll_global $P126, ["Exception"], "OutOfBounds"
.annotate 'line', 60
    .const 'Sub' $P128 = "19_1282246489.55033" 
    newclosure $P135, $P128
    $P136 = "assert_throws"($P126, "Index B is out of bounds", $P135)
.annotate 'line', 58
    .return ($P136)
  control_124:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P137, exception, "payload"
    .return ($P137)
.end


.namespace ["Pla";"Methods";"RowCombine"]
.sub "_block127"  :anon :subid("19_1282246489.55033") :outer("18_1282246489.55033")
.annotate 'line', 61
    new $P129, "Undef"
    .lex "$A", $P129
    find_lex $P130, "self"
    $P131 = $P130."factory"()
    $P132 = $P131."defaultmatrix3x3"()
    store_lex "$A", $P132
.annotate 'line', 62
    find_lex $P133, "$A"
    $P134 = $P133."row_combine"(1, -1, 1)
.annotate 'line', 60
    .return ($P134)
.end


.namespace ["Pla";"Methods";"RowCombine"]
.include "except_types.pasm"
.sub "test_METHOD_row_combine_BOUNDS_B"  :subid("20_1282246489.55033") :method :outer("11_1282246489.55033")
.annotate 'line', 66
    .const 'Sub' $P143 = "21_1282246489.55033" 
    capture_lex $P143
    new $P140, 'ExceptionHandler'
    set_addr $P140, control_139
    $P140."handle_types"(.CONTROL_RETURN)
    push_eh $P140
    .lex "self", self
.annotate 'line', 67
    get_hll_global $P141, ["Exception"], "OutOfBounds"
.annotate 'line', 68
    .const 'Sub' $P143 = "21_1282246489.55033" 
    newclosure $P150, $P143
    $P151 = "assert_throws"($P141, "Index B is out of bounds", $P150)
.annotate 'line', 66
    .return ($P151)
  control_139:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P152, exception, "payload"
    .return ($P152)
.end


.namespace ["Pla";"Methods";"RowCombine"]
.sub "_block142"  :anon :subid("21_1282246489.55033") :outer("20_1282246489.55033")
.annotate 'line', 69
    new $P144, "Undef"
    .lex "$A", $P144
    find_lex $P145, "self"
    $P146 = $P145."factory"()
    $P147 = $P146."defaultmatrix3x3"()
    store_lex "$A", $P147
.annotate 'line', 70
    find_lex $P148, "$A"
    $P149 = $P148."row_combine"(1, 7, 1)
.annotate 'line', 68
    .return ($P149)
.end


.namespace []
.sub "_block155" :load :anon :subid("22_1282246489.55033")
.annotate 'line', 1
    .const 'Sub' $P157 = "10_1282246489.55033" 
    $P158 = $P157()
    .return ($P158)
.end

