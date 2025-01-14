# IRtoDOT
This project was created as an introductory project to LLVM IR when I joined CompilerLab. Its a parser that takes an LLVM IR file as input and generates a corresponding DOT file, enabling visualization of the intermediate representation as a graph.

### Example

Using [](main.ll) IR showed below, we have this control-flow PDF from my pass:

![image](https://github.com/user-attachments/assets/fb6a0934-cdd5-4243-86dd-27932e0d2f2a)

and from dot-cfg common pass to generate dot files:

![image](https://github.com/user-attachments/assets/7949e900-411f-44d5-bb92-d2236b0522d9)

[main.ll]
``` llvm
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


```

