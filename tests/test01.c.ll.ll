; ModuleID = 'tests/test01.c.ll'
source_filename = "test01.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.1 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %i = alloca i32, align 4
  %i5 = alloca i32, align 4
  store i32 0, ptr %retval, align 4
  %call = call i32 (ptr, ...) @__isoc99_scanf(ptr noundef @.str, ptr noundef %a)
  store i32 5, ptr %b, align 4
  %0 = load i32, ptr %a, align 4
  %cmp = icmp sgt i32 %0, 50
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  store i32 0, ptr %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %if.then
  %1 = load i32, ptr %i, align 4
  %2 = load i32, ptr %a, align 4
  %3 = load i32, ptr %a, align 4
  %mul = mul nsw i32 %2, %3
  %cmp1 = icmp slt i32 %1, %mul
  br i1 %cmp1, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %4 = load i32, ptr %i, align 4
  %5 = load i32, ptr %b, align 4
  %mul2 = mul nsw i32 %5, %4
  store i32 %mul2, ptr %b, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %6 = load i32, ptr %i, align 4
  %inc = add nsw i32 %6, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !6

for.end:                                          ; preds = %for.cond
  %7 = load i32, ptr %b, align 4
  %call3 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, i32 noundef %7)
  br label %if.end

if.else:                                          ; preds = %entry
  %call4 = call i32 (ptr, ...) @__isoc99_scanf(ptr noundef @.str, ptr noundef %a)
  store i32 0, ptr %i5, align 4
  br label %for.cond6

for.cond6:                                        ; preds = %for.inc12, %if.else
  %8 = load i32, ptr %i5, align 4
  %9 = load i32, ptr %a, align 4
  %10 = load i32, ptr %a, align 4
  %mul7 = mul nsw i32 %9, %10
  %11 = load i32, ptr %a, align 4
  %mul8 = mul nsw i32 %mul7, %11
  %cmp9 = icmp slt i32 %8, %mul8
  br i1 %cmp9, label %for.body10, label %for.end14

for.body10:                                       ; preds = %for.cond6
  %12 = load i32, ptr %i5, align 4
  %13 = load i32, ptr %b, align 4
  %mul11 = mul nsw i32 %13, %12
  store i32 %mul11, ptr %b, align 4
  br label %for.inc12

for.inc12:                                        ; preds = %for.body10
  %14 = load i32, ptr %i5, align 4
  %inc13 = add nsw i32 %14, 1
  store i32 %inc13, ptr %i5, align 4
  br label %for.cond6, !llvm.loop !8

for.end14:                                        ; preds = %for.cond6
  %15 = load i32, ptr %b, align 4
  %call15 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, i32 noundef %15)
  br label %if.end

if.end:                                           ; preds = %for.end14, %for.end
  %16 = load i32, ptr %retval, align 4
  ret i32 %16
}

declare i32 @__isoc99_scanf(ptr noundef, ...) #1

declare i32 @printf(ptr noundef, ...) #1

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"clang version 17.0.6 (https://github.com/Casperento/llvm-project.git 9b0073551ece0d22bf3378af2b03e456a26031b6)"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !7}
