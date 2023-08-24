func.func @not_with_maybe_overflow(%arg0 : i32) {
    %ci32_smax = arith.constant 0x7fffffff : i32
    %c1 = arith.constant 1 : i32
    %c4 = arith.constant 4 : i32
    %0 = arith.minui %arg0, %ci32_smax : i32
    %1 = arith.addi %0, %c1 : i32
    %2 = arith.divsi %1, %c4 : i32
    %3 = arith.ceildivsi %1, %c4 : i32
    %4 = arith.floordivsi %1, %c4 : i32
    %5 = arith.remsi %1, %c4 : i32
    %6 = arith.minsi %1, %c4 : i32
    %7 = arith.maxsi %1, %c4 : i32
    %8 = arith.extsi %1 : i32 to i64
    %9 = arith.cmpi sle, %1, %c4 : i32
    %10 = arith.cmpi slt, %1, %c4 : i32
    %11 = arith.cmpi sge, %1, %c4 : i32
    %12 = arith.cmpi sgt, %1, %c4 : i32
    func.return
}
