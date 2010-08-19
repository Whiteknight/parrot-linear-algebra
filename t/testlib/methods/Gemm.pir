
.namespace []
.sub "_block11"  :anon :subid("10_1282252083.69791")
.annotate 'line', 0
    get_hll_global $P14, ["Pla";"Methods";"Gemm"], "_block13" 
    capture_lex $P14
.annotate 'line', 1
    $P0 = find_dynamic_lex "$*CTXSAVE"
    if null $P0 goto ctxsave_done
    $I0 = can $P0, "ctxsave"
    unless $I0 goto ctxsave_done
    $P0."ctxsave"()
  ctxsave_done:
    get_hll_global $P14, ["Pla";"Methods";"Gemm"], "_block13" 
    capture_lex $P14
    $P236 = $P14()
    .return ($P236)
    .const 'Sub' $P238 = "37_1282252083.69791" 
    .return ($P238)
.end


.namespace []
.sub "" :load :init :subid("post38") :outer("10_1282252083.69791")
.annotate 'line', 0
    .const 'Sub' $P12 = "10_1282252083.69791" 
    .local pmc block
    set block, $P12
    $P241 = get_root_global ["parrot"], "P6metaclass"
    $P241."new_class"("Pla::Methods::Gemm", "Pla::MatrixTestBase" :named("parent"))
.end


.namespace ["Pla";"Methods";"Gemm"]
.sub "_block13"  :subid("11_1282252083.69791") :outer("10_1282252083.69791")
.annotate 'line', 1
    .const 'Sub' $P230 = "36_1282252083.69791" 
    capture_lex $P230
    .const 'Sub' $P225 = "35_1282252083.69791" 
    capture_lex $P225
    .const 'Sub' $P220 = "34_1282252083.69791" 
    capture_lex $P220
    .const 'Sub' $P215 = "33_1282252083.69791" 
    capture_lex $P215
    .const 'Sub' $P210 = "32_1282252083.69791" 
    capture_lex $P210
    .const 'Sub' $P205 = "31_1282252083.69791" 
    capture_lex $P205
    .const 'Sub' $P200 = "30_1282252083.69791" 
    capture_lex $P200
    .const 'Sub' $P195 = "29_1282252083.69791" 
    capture_lex $P195
    .const 'Sub' $P190 = "28_1282252083.69791" 
    capture_lex $P190
    .const 'Sub' $P164 = "26_1282252083.69791" 
    capture_lex $P164
    .const 'Sub' $P138 = "24_1282252083.69791" 
    capture_lex $P138
    .const 'Sub' $P112 = "22_1282252083.69791" 
    capture_lex $P112
    .const 'Sub' $P88 = "20_1282252083.69791" 
    capture_lex $P88
    .const 'Sub' $P64 = "18_1282252083.69791" 
    capture_lex $P64
    .const 'Sub' $P40 = "16_1282252083.69791" 
    capture_lex $P40
    .const 'Sub' $P34 = "15_1282252083.69791" 
    capture_lex $P34
    .const 'Sub' $P28 = "14_1282252083.69791" 
    capture_lex $P28
    .const 'Sub' $P22 = "13_1282252083.69791" 
    capture_lex $P22
    .const 'Sub' $P15 = "12_1282252083.69791" 
    capture_lex $P15
.annotate 'line', 83
    .const 'Sub' $P230 = "36_1282252083.69791" 
    newclosure $P235, $P230
.annotate 'line', 1
    .return ($P235)
.end


.namespace ["Pla";"Methods";"Gemm"]
.sub "" :load :init :subid("post39") :outer("11_1282252083.69791")
.annotate 'line', 1
    get_hll_global $P14, ["Pla";"Methods";"Gemm"], "_block13" 
    .local pmc block
    set block, $P14
.annotate 'line', 4
    "use"("UnitTest::Testcase")
.annotate 'line', 5
    "use"("UnitTest::Assertions")
.end


.namespace ["Pla";"Methods";"Gemm"]
.include "except_types.pasm"
.sub "test_METHOD_gemm_aA"  :subid("12_1282252083.69791") :method :outer("11_1282252083.69791")
.annotate 'line', 8
    new $P17, 'ExceptionHandler'
    set_addr $P17, control_16
    $P17."handle_types"(.CONTROL_RETURN)
    push_eh $P17
    .lex "self", self
    find_lex $P18, "self"
    $P19 = $P18."factory"()
    $P20 = $P19."RequireOverride"("test_METHOD_gemm_aA")
    .return ($P20)
  control_16:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P21, exception, "payload"
    .return ($P21)
.end


.namespace ["Pla";"Methods";"Gemm"]
.include "except_types.pasm"
.sub "test_METHOD_gemm_AB"  :subid("13_1282252083.69791") :method :outer("11_1282252083.69791")
.annotate 'line', 9
    new $P24, 'ExceptionHandler'
    set_addr $P24, control_23
    $P24."handle_types"(.CONTROL_RETURN)
    push_eh $P24
    .lex "self", self
    find_lex $P25, "self"
    $P26 = $P25."RequireOverride"("test_METHOD_gemm_AB")
    .return ($P26)
  control_23:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P27, exception, "payload"
    .return ($P27)
.end


.namespace ["Pla";"Methods";"Gemm"]
.include "except_types.pasm"
.sub "test_METHOD_gemm_aAB"  :subid("14_1282252083.69791") :method :outer("11_1282252083.69791")
.annotate 'line', 10
    new $P30, 'ExceptionHandler'
    set_addr $P30, control_29
    $P30."handle_types"(.CONTROL_RETURN)
    push_eh $P30
    .lex "self", self
    find_lex $P31, "self"
    $P32 = $P31."RequireOverride"("test_METHOD_gemm_aAB")
    .return ($P32)
  control_29:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P33, exception, "payload"
    .return ($P33)
.end


.namespace ["Pla";"Methods";"Gemm"]
.include "except_types.pasm"
.sub "test_METHOD_gemm_aABbC"  :subid("15_1282252083.69791") :method :outer("11_1282252083.69791")
.annotate 'line', 11
    new $P36, 'ExceptionHandler'
    set_addr $P36, control_35
    $P36."handle_types"(.CONTROL_RETURN)
    push_eh $P36
    .lex "self", self
    find_lex $P37, "self"
    $P38 = $P37."RequireOverride"("test_METHOD_gemm_aABbC")
    .return ($P38)
  control_35:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P39, exception, "payload"
    .return ($P39)
.end


.namespace ["Pla";"Methods";"Gemm"]
.include "except_types.pasm"
.sub "test_METHOD_gemm_BADTYPE_A"  :subid("16_1282252083.69791") :method :outer("11_1282252083.69791")
.annotate 'line', 13
    .const 'Sub' $P45 = "17_1282252083.69791" 
    capture_lex $P45
    new $P42, 'ExceptionHandler'
    set_addr $P42, control_41
    $P42."handle_types"(.CONTROL_RETURN)
    push_eh $P42
    .lex "self", self
.annotate 'line', 14
    get_hll_global $P43, ["Exception"], "OutOfBounds"
.annotate 'line', 15
    .const 'Sub' $P45 = "17_1282252083.69791" 
    newclosure $P61, $P45
    $P62 = "assert_throws"($P43, "A is bad type", $P61)
.annotate 'line', 13
    .return ($P62)
  control_41:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P63, exception, "payload"
    .return ($P63)
.end


.namespace ["Pla";"Methods";"Gemm"]
.sub "_block44"  :anon :subid("17_1282252083.69791") :outer("16_1282252083.69791")
.annotate 'line', 16
    new $P46, "Undef"
    .lex "$A", $P46
.annotate 'line', 17
    new $P47, "Undef"
    .lex "$B", $P47
.annotate 'line', 18
    new $P48, "Undef"
    .lex "$C", $P48
.annotate 'line', 16
    new $P49, "String"
    assign $P49, "foobar"
    store_lex "$A", $P49
.annotate 'line', 17
    find_lex $P50, "self"
    $P51 = $P50."factory"()
    $P52 = $P51."defaultmatrix3x3"()
    store_lex "$B", $P52
.annotate 'line', 18
    find_lex $P53, "self"
    $P54 = $P53."factory"()
    $P55 = $P54."defaultmatrix3x3"()
    store_lex "$C", $P55
.annotate 'line', 19
    find_lex $P56, "$B"
    find_lex $P57, "$A"
    find_lex $P58, "$B"
    find_lex $P59, "$C"
    $P60 = $P56."gemm"(1, $P57, $P58, 1, $P59)
.annotate 'line', 15
    .return ($P60)
.end


.namespace ["Pla";"Methods";"Gemm"]
.include "except_types.pasm"
.sub "test_METHOD_gemm_BADTYPE_B"  :subid("18_1282252083.69791") :method :outer("11_1282252083.69791")
.annotate 'line', 23
    .const 'Sub' $P69 = "19_1282252083.69791" 
    capture_lex $P69
    new $P66, 'ExceptionHandler'
    set_addr $P66, control_65
    $P66."handle_types"(.CONTROL_RETURN)
    push_eh $P66
    .lex "self", self
.annotate 'line', 24
    get_hll_global $P67, ["Exception"], "OutOfBounds"
.annotate 'line', 25
    .const 'Sub' $P69 = "19_1282252083.69791" 
    newclosure $P85, $P69
    $P86 = "assert_throws"($P67, "B is bad type", $P85)
.annotate 'line', 23
    .return ($P86)
  control_65:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P87, exception, "payload"
    .return ($P87)
.end


.namespace ["Pla";"Methods";"Gemm"]
.sub "_block68"  :anon :subid("19_1282252083.69791") :outer("18_1282252083.69791")
.annotate 'line', 26
    new $P70, "Undef"
    .lex "$A", $P70
.annotate 'line', 27
    new $P71, "Undef"
    .lex "$B", $P71
.annotate 'line', 28
    new $P72, "Undef"
    .lex "$C", $P72
.annotate 'line', 26
    find_lex $P73, "self"
    $P74 = $P73."factory"()
    $P75 = $P74."defaultmatrix3x3"()
    store_lex "$A", $P75
.annotate 'line', 27
    new $P76, "String"
    assign $P76, "foobar"
    store_lex "$B", $P76
.annotate 'line', 28
    find_lex $P77, "self"
    $P78 = $P77."factory"()
    $P79 = $P78."defaultmatrix3x3"()
    store_lex "$C", $P79
.annotate 'line', 29
    find_lex $P80, "$A"
    find_lex $P81, "$A"
    find_lex $P82, "$B"
    find_lex $P83, "$C"
    $P84 = $P80."gemm"(1, $P81, $P82, 1, $P83)
.annotate 'line', 25
    .return ($P84)
.end


.namespace ["Pla";"Methods";"Gemm"]
.include "except_types.pasm"
.sub "test_METHOD_gemm_BADTYPE_C"  :subid("20_1282252083.69791") :method :outer("11_1282252083.69791")
.annotate 'line', 33
    .const 'Sub' $P93 = "21_1282252083.69791" 
    capture_lex $P93
    new $P90, 'ExceptionHandler'
    set_addr $P90, control_89
    $P90."handle_types"(.CONTROL_RETURN)
    push_eh $P90
    .lex "self", self
.annotate 'line', 34
    get_hll_global $P91, ["Exception"], "OutOfBounds"
.annotate 'line', 35
    .const 'Sub' $P93 = "21_1282252083.69791" 
    newclosure $P109, $P93
    $P110 = "assert_throws"($P91, "C is bad type", $P109)
.annotate 'line', 33
    .return ($P110)
  control_89:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P111, exception, "payload"
    .return ($P111)
.end


.namespace ["Pla";"Methods";"Gemm"]
.sub "_block92"  :anon :subid("21_1282252083.69791") :outer("20_1282252083.69791")
.annotate 'line', 36
    new $P94, "Undef"
    .lex "$A", $P94
.annotate 'line', 37
    new $P95, "Undef"
    .lex "$B", $P95
.annotate 'line', 38
    new $P96, "Undef"
    .lex "$C", $P96
.annotate 'line', 36
    find_lex $P97, "self"
    $P98 = $P97."factory"()
    $P99 = $P98."defaultmatrix3x3"()
    store_lex "$A", $P99
.annotate 'line', 37
    find_lex $P100, "self"
    $P101 = $P100."factory"()
    $P102 = $P101."defaultmatrix3x3"()
    store_lex "$B", $P102
.annotate 'line', 38
    new $P103, "String"
    assign $P103, "foobar"
    store_lex "$C", $P103
.annotate 'line', 39
    find_lex $P104, "$A"
    find_lex $P105, "$A"
    find_lex $P106, "$B"
    find_lex $P107, "$C"
    $P108 = $P104."gemm"(1, $P105, $P106, 1, $P107)
.annotate 'line', 35
    .return ($P108)
.end


.namespace ["Pla";"Methods";"Gemm"]
.include "except_types.pasm"
.sub "test_METHOD_gemm_BADSIZE_A"  :subid("22_1282252083.69791") :method :outer("11_1282252083.69791")
.annotate 'line', 43
    .const 'Sub' $P117 = "23_1282252083.69791" 
    capture_lex $P117
    new $P114, 'ExceptionHandler'
    set_addr $P114, control_113
    $P114."handle_types"(.CONTROL_RETURN)
    push_eh $P114
    .lex "self", self
.annotate 'line', 44
    get_hll_global $P115, ["Exception"], "OutOfBounds"
.annotate 'line', 45
    .const 'Sub' $P117 = "23_1282252083.69791" 
    newclosure $P135, $P117
    $P136 = "assert_throws"($P115, "A has incorrect size", $P135)
.annotate 'line', 43
    .return ($P136)
  control_113:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P137, exception, "payload"
    .return ($P137)
.end


.namespace ["Pla";"Methods";"Gemm"]
.sub "_block116"  :anon :subid("23_1282252083.69791") :outer("22_1282252083.69791")
.annotate 'line', 46
    new $P118, "Undef"
    .lex "$A", $P118
.annotate 'line', 47
    new $P119, "Undef"
    .lex "$B", $P119
.annotate 'line', 48
    new $P120, "Undef"
    .lex "$C", $P120
.annotate 'line', 46
    find_lex $P121, "self"
    $P122 = $P121."factory"()
    $P123 = $P122."defaultmatrix2x2"()
    store_lex "$A", $P123
.annotate 'line', 47
    find_lex $P124, "self"
    $P125 = $P124."factory"()
    $P126 = $P125."defaultmatrix3x3"()
    store_lex "$B", $P126
.annotate 'line', 48
    find_lex $P127, "self"
    $P128 = $P127."factory"()
    $P129 = $P128."defaultmatrix3x3"()
    store_lex "$C", $P129
.annotate 'line', 49
    find_lex $P130, "$A"
    find_lex $P131, "$A"
    find_lex $P132, "$B"
    find_lex $P133, "$C"
    $P134 = $P130."gemm"(1, $P131, $P132, 1, $P133)
.annotate 'line', 45
    .return ($P134)
.end


.namespace ["Pla";"Methods";"Gemm"]
.include "except_types.pasm"
.sub "test_METHOD_gemm_BADSIZE_B"  :subid("24_1282252083.69791") :method :outer("11_1282252083.69791")
.annotate 'line', 53
    .const 'Sub' $P143 = "25_1282252083.69791" 
    capture_lex $P143
    new $P140, 'ExceptionHandler'
    set_addr $P140, control_139
    $P140."handle_types"(.CONTROL_RETURN)
    push_eh $P140
    .lex "self", self
.annotate 'line', 54
    get_hll_global $P141, ["Exception"], "OutOfBounds"
.annotate 'line', 55
    .const 'Sub' $P143 = "25_1282252083.69791" 
    newclosure $P161, $P143
    $P162 = "assert_throws"($P141, "B has incorrect size", $P161)
.annotate 'line', 53
    .return ($P162)
  control_139:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P163, exception, "payload"
    .return ($P163)
.end


.namespace ["Pla";"Methods";"Gemm"]
.sub "_block142"  :anon :subid("25_1282252083.69791") :outer("24_1282252083.69791")
.annotate 'line', 56
    new $P144, "Undef"
    .lex "$A", $P144
.annotate 'line', 57
    new $P145, "Undef"
    .lex "$B", $P145
.annotate 'line', 58
    new $P146, "Undef"
    .lex "$C", $P146
.annotate 'line', 56
    find_lex $P147, "self"
    $P148 = $P147."factory"()
    $P149 = $P148."defaultmatrix3x3"()
    store_lex "$A", $P149
.annotate 'line', 57
    find_lex $P150, "self"
    $P151 = $P150."factory"()
    $P152 = $P151."defaultmatrix2x2"()
    store_lex "$B", $P152
.annotate 'line', 58
    find_lex $P153, "self"
    $P154 = $P153."factory"()
    $P155 = $P154."defaultmatrix3x3"()
    store_lex "$C", $P155
.annotate 'line', 59
    find_lex $P156, "$A"
    find_lex $P157, "$A"
    find_lex $P158, "$B"
    find_lex $P159, "$C"
    $P160 = $P156."gemm"(1, $P157, $P158, 1, $P159)
.annotate 'line', 55
    .return ($P160)
.end


.namespace ["Pla";"Methods";"Gemm"]
.include "except_types.pasm"
.sub "test_METHOD_gemm_BADSIZE_C"  :subid("26_1282252083.69791") :method :outer("11_1282252083.69791")
.annotate 'line', 63
    .const 'Sub' $P169 = "27_1282252083.69791" 
    capture_lex $P169
    new $P166, 'ExceptionHandler'
    set_addr $P166, control_165
    $P166."handle_types"(.CONTROL_RETURN)
    push_eh $P166
    .lex "self", self
.annotate 'line', 64
    get_hll_global $P167, ["Exception"], "OutOfBounds"
.annotate 'line', 65
    .const 'Sub' $P169 = "27_1282252083.69791" 
    newclosure $P187, $P169
    $P188 = "assert_throws"($P167, "C has incorrect size", $P187)
.annotate 'line', 63
    .return ($P188)
  control_165:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P189, exception, "payload"
    .return ($P189)
.end


.namespace ["Pla";"Methods";"Gemm"]
.sub "_block168"  :anon :subid("27_1282252083.69791") :outer("26_1282252083.69791")
.annotate 'line', 66
    new $P170, "Undef"
    .lex "$A", $P170
.annotate 'line', 67
    new $P171, "Undef"
    .lex "$B", $P171
.annotate 'line', 68
    new $P172, "Undef"
    .lex "$C", $P172
.annotate 'line', 66
    find_lex $P173, "self"
    $P174 = $P173."factory"()
    $P175 = $P174."defaultmatrix3x3"()
    store_lex "$A", $P175
.annotate 'line', 67
    find_lex $P176, "self"
    $P177 = $P176."factory"()
    $P178 = $P177."defaultmatrix3x3"()
    store_lex "$B", $P178
.annotate 'line', 68
    find_lex $P179, "self"
    $P180 = $P179."factory"()
    $P181 = $P180."defaultmatrix2x2"()
    store_lex "$C", $P181
.annotate 'line', 69
    find_lex $P182, "$A"
    find_lex $P183, "$A"
    find_lex $P184, "$B"
    find_lex $P185, "$C"
    $P186 = $P182."gemm"(1, $P183, $P184, 1, $P185)
.annotate 'line', 65
    .return ($P186)
.end


.namespace ["Pla";"Methods";"Gemm"]
.include "except_types.pasm"
.sub "test_METHOD_gemm_AUTOCONVERT_A_NumMatrix2D"  :subid("28_1282252083.69791") :method :outer("11_1282252083.69791")
.annotate 'line', 73
    new $P192, 'ExceptionHandler'
    set_addr $P192, control_191
    $P192."handle_types"(.CONTROL_RETURN)
    push_eh $P192
    .lex "self", self
    $P193 = "todo"("Write this!")
    .return ($P193)
  control_191:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P194, exception, "payload"
    .return ($P194)
.end


.namespace ["Pla";"Methods";"Gemm"]
.include "except_types.pasm"
.sub "test_METHOD_gemm_AUTOCONVERT_B_NumMatrix2D"  :subid("29_1282252083.69791") :method :outer("11_1282252083.69791")
.annotate 'line', 74
    new $P197, 'ExceptionHandler'
    set_addr $P197, control_196
    $P197."handle_types"(.CONTROL_RETURN)
    push_eh $P197
    .lex "self", self
    $P198 = "todo"("Write this!")
    .return ($P198)
  control_196:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P199, exception, "payload"
    .return ($P199)
.end


.namespace ["Pla";"Methods";"Gemm"]
.include "except_types.pasm"
.sub "test_METHOD_gemm_AUTOCONVERT_C_NumMatrix2D"  :subid("30_1282252083.69791") :method :outer("11_1282252083.69791")
.annotate 'line', 75
    new $P202, 'ExceptionHandler'
    set_addr $P202, control_201
    $P202."handle_types"(.CONTROL_RETURN)
    push_eh $P202
    .lex "self", self
    $P203 = "todo"("Write this!")
    .return ($P203)
  control_201:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P204, exception, "payload"
    .return ($P204)
.end


.namespace ["Pla";"Methods";"Gemm"]
.include "except_types.pasm"
.sub "test_METHOD_gemm_AUTOCONVERT_A_ComplexMatrix2D"  :subid("31_1282252083.69791") :method :outer("11_1282252083.69791")
.annotate 'line', 77
    new $P207, 'ExceptionHandler'
    set_addr $P207, control_206
    $P207."handle_types"(.CONTROL_RETURN)
    push_eh $P207
    .lex "self", self
    $P208 = "todo"("Write this!")
    .return ($P208)
  control_206:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P209, exception, "payload"
    .return ($P209)
.end


.namespace ["Pla";"Methods";"Gemm"]
.include "except_types.pasm"
.sub "test_METHOD_gemm_AUTOCONVERT_B_ComplexMatrix2D"  :subid("32_1282252083.69791") :method :outer("11_1282252083.69791")
.annotate 'line', 78
    new $P212, 'ExceptionHandler'
    set_addr $P212, control_211
    $P212."handle_types"(.CONTROL_RETURN)
    push_eh $P212
    .lex "self", self
    $P213 = "todo"("Write this!")
    .return ($P213)
  control_211:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P214, exception, "payload"
    .return ($P214)
.end


.namespace ["Pla";"Methods";"Gemm"]
.include "except_types.pasm"
.sub "test_METHOD_gemm_AUTOCONVERT_C_ComplexMatrix2D"  :subid("33_1282252083.69791") :method :outer("11_1282252083.69791")
.annotate 'line', 79
    new $P217, 'ExceptionHandler'
    set_addr $P217, control_216
    $P217."handle_types"(.CONTROL_RETURN)
    push_eh $P217
    .lex "self", self
    $P218 = "todo"("Write this!")
    .return ($P218)
  control_216:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P219, exception, "payload"
    .return ($P219)
.end


.namespace ["Pla";"Methods";"Gemm"]
.include "except_types.pasm"
.sub "test_METHOD_gemm_AUTOCONVERT_A_PMCMatrix2D"  :subid("34_1282252083.69791") :method :outer("11_1282252083.69791")
.annotate 'line', 81
    new $P222, 'ExceptionHandler'
    set_addr $P222, control_221
    $P222."handle_types"(.CONTROL_RETURN)
    push_eh $P222
    .lex "self", self
    $P223 = "todo"("Write this!")
    .return ($P223)
  control_221:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P224, exception, "payload"
    .return ($P224)
.end


.namespace ["Pla";"Methods";"Gemm"]
.include "except_types.pasm"
.sub "test_METHOD_gemm_AUTOCONVERT_B_PMCMatrix2D"  :subid("35_1282252083.69791") :method :outer("11_1282252083.69791")
.annotate 'line', 82
    new $P227, 'ExceptionHandler'
    set_addr $P227, control_226
    $P227."handle_types"(.CONTROL_RETURN)
    push_eh $P227
    .lex "self", self
    $P228 = "todo"("Write this!")
    .return ($P228)
  control_226:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P229, exception, "payload"
    .return ($P229)
.end


.namespace ["Pla";"Methods";"Gemm"]
.include "except_types.pasm"
.sub "test_METHOD_gemm_AUTOCONVERT_C_PMCMatrix2D"  :subid("36_1282252083.69791") :method :outer("11_1282252083.69791")
.annotate 'line', 83
    new $P232, 'ExceptionHandler'
    set_addr $P232, control_231
    $P232."handle_types"(.CONTROL_RETURN)
    push_eh $P232
    .lex "self", self
    $P233 = "todo"("Write this!")
    .return ($P233)
  control_231:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P234, exception, "payload"
    .return ($P234)
.end


.namespace []
.sub "_block237" :load :anon :subid("37_1282252083.69791")
.annotate 'line', 1
    .const 'Sub' $P239 = "10_1282252083.69791" 
    $P240 = $P239()
    .return ($P240)
.end

