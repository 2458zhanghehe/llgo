; ModuleID = 'main'
source_filename = "main"

@"main.init$guard" = global ptr null
@0 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@1 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@2 = private unnamed_addr constant [7 x i8] c"%d %d\0A\00", align 1

define { ptr, ptr } @main.add() {
_llgo_0:
  %0 = alloca { ptr, ptr }, align 8
  %1 = getelementptr inbounds { ptr, ptr }, ptr %0, i32 0, i32 0
  store ptr @"__llgo_stub.main.add$1", ptr %1, align 8
  %2 = getelementptr inbounds { ptr, ptr }, ptr %0, i32 0, i32 1
  store ptr null, ptr %2, align 8
  %3 = load { ptr, ptr }, ptr %0, align 8
  ret { ptr, ptr } %3
}

define { { ptr, ptr }, i64 } @main.add2() {
_llgo_0:
  %0 = alloca { ptr, ptr }, align 8
  %1 = getelementptr inbounds { ptr, ptr }, ptr %0, i32 0, i32 0
  store ptr @"__llgo_stub.main.add2$1", ptr %1, align 8
  %2 = getelementptr inbounds { ptr, ptr }, ptr %0, i32 0, i32 1
  store ptr null, ptr %2, align 8
  %3 = load { ptr, ptr }, ptr %0, align 8
  %mrv = insertvalue { { ptr, ptr }, i64 } poison, { ptr, ptr } %3, 0
  %mrv1 = insertvalue { { ptr, ptr }, i64 } %mrv, i64 1, 1
  ret { { ptr, ptr }, i64 } %mrv1
}

define void @main.init() {
_llgo_0:
  %0 = load i1, ptr @"main.init$guard", align 1
  br i1 %0, label %_llgo_2, label %_llgo_1

_llgo_1:                                          ; preds = %_llgo_0
  store i1 true, ptr @"main.init$guard", align 1
  br label %_llgo_2

_llgo_2:                                          ; preds = %_llgo_1, %_llgo_0
  ret void
}

define void @main() {
_llgo_0:
  call void @"github.com/goplus/llgo/internal/runtime.init"()
  call void @main.init()
  %0 = call { ptr, ptr } @"main.main$1"()
  %1 = extractvalue { ptr, ptr } %0, 1
  %2 = extractvalue { ptr, ptr } %0, 0
  %3 = call i64 %2(ptr %1, i64 100, i64 200)
  %4 = call i32 (ptr, ...) @printf(ptr @0, i64 %3)
  %5 = call { ptr, ptr } @main.add()
  %6 = extractvalue { ptr, ptr } %5, 1
  %7 = extractvalue { ptr, ptr } %5, 0
  %8 = call i64 %7(ptr %6, i64 100, i64 200)
  %9 = call i32 (ptr, ...) @printf(ptr @1, i64 %8)
  %10 = call { { ptr, ptr }, i64 } @main.add2()
  %11 = extractvalue { { ptr, ptr }, i64 } %10, 0
  %12 = extractvalue { { ptr, ptr }, i64 } %10, 1
  %13 = call { ptr, ptr } @main.add()
  %14 = extractvalue { ptr, ptr } %13, 1
  %15 = extractvalue { ptr, ptr } %13, 0
  %16 = call i64 %15(ptr %14, i64 100, i64 200)
  %17 = call i32 (ptr, ...) @printf(ptr @2, i64 %16, i64 %12)
  ret void
}

define i64 @"main.add$1"(i64 %0, i64 %1) {
_llgo_0:
  %2 = add i64 %0, %1
  ret i64 %2
}

define linkonce i64 @"__llgo_stub.main.add$1"(ptr %0, i64 %1, i64 %2) {
_llgo_0:
  %3 = tail call i64 @"main.add$1"(i64 %1, i64 %2)
  ret i64 %3
}

define i64 @"main.add2$1"(i64 %0, i64 %1) {
_llgo_0:
  %2 = add i64 %0, %1
  ret i64 %2
}

define linkonce i64 @"__llgo_stub.main.add2$1"(ptr %0, i64 %1, i64 %2) {
_llgo_0:
  %3 = tail call i64 @"main.add2$1"(i64 %1, i64 %2)
  ret i64 %3
}

declare void @"github.com/goplus/llgo/internal/runtime.init"()

define { ptr, ptr } @"main.main$1"() {
_llgo_0:
  %0 = alloca { ptr, ptr }, align 8
  %1 = getelementptr inbounds { ptr, ptr }, ptr %0, i32 0, i32 0
  store ptr @"__llgo_stub.main.main$1$1", ptr %1, align 8
  %2 = getelementptr inbounds { ptr, ptr }, ptr %0, i32 0, i32 1
  store ptr null, ptr %2, align 8
  %3 = load { ptr, ptr }, ptr %0, align 8
  ret { ptr, ptr } %3
}

declare i32 @printf(ptr, ...)

define i64 @"main.main$1$1"(i64 %0, i64 %1) {
_llgo_0:
  %2 = add i64 %0, %1
  ret i64 %2
}

define linkonce i64 @"__llgo_stub.main.main$1$1"(ptr %0, i64 %1, i64 %2) {
_llgo_0:
  %3 = tail call i64 @"main.main$1$1"(i64 %1, i64 %2)
  ret i64 %3
}