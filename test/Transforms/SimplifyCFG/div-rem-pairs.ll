; RUN: opt -simplifycfg -S < %s | FileCheck %s

; FIXME: Hoist the sdiv because it's safe and free.
; PR31028 - https://bugs.llvm.org/show_bug.cgi?id=31028

define i32 @hoist_sdiv(i32 %a, i32 %b) {
; CHECK-LABEL: @hoist_sdiv(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[REM:%.*]] = srem i32 %a, %b
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[REM]], 42
; CHECK-NEXT:    br i1 [[CMP]], label %if, label %end
; CHECK:       if:
; CHECK-NEXT:    [[DIV:%.*]] = sdiv i32 %a, %b
; CHECK-NEXT:    br label %end
; CHECK:       end:
; CHECK-NEXT:    [[RET:%.*]] = phi i32 [ [[DIV]], %if ], [ 3, %entry ]
; CHECK-NEXT:    ret i32 [[RET]]
;
entry:
  %rem = srem i32 %a, %b
  %cmp = icmp eq i32 %rem, 42
  br i1 %cmp, label %if, label %end

if:
  %div = sdiv i32 %a, %b
  br label %end

end:
  %ret = phi i32 [ %div, %if ], [ 3, %entry ]
  ret i32 %ret
}

; FIXME: Hoist the udiv because it's safe and free.

define i64 @hoist_udiv(i64 %a, i64 %b) {
; CHECK-LABEL: @hoist_udiv(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[REM:%.*]] = urem i64 %a, %b
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i64 [[REM]], 42
; CHECK-NEXT:    br i1 [[CMP]], label %if, label %end
; CHECK:       if:
; CHECK-NEXT:    [[DIV:%.*]] = udiv i64 %a, %b
; CHECK-NEXT:    br label %end
; CHECK:       end:
; CHECK-NEXT:    [[RET:%.*]] = phi i64 [ [[DIV]], %if ], [ 3, %entry ]
; CHECK-NEXT:    ret i64 [[RET]]
;
entry:
  %rem = urem i64 %a, %b
  %cmp = icmp eq i64 %rem, 42
  br i1 %cmp, label %if, label %end

if:
  %div = udiv i64 %a, %b
  br label %end

end:
  %ret = phi i64 [ %div, %if ], [ 3, %entry ]
  ret i64 %ret
}

; FIXME: Hoist the srem because it's safe and likely free.

define i16 @hoist_srem(i16 %a, i16 %b) {
; CHECK-LABEL: @hoist_srem(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[DIV:%.*]] = sdiv i16 %a, %b
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i16 [[DIV]], 42
; CHECK-NEXT:    br i1 [[CMP]], label %if, label %end
; CHECK:       if:
; CHECK-NEXT:    [[REM:%.*]] = srem i16 %a, %b
; CHECK-NEXT:    br label %end
; CHECK:       end:
; CHECK-NEXT:    [[RET:%.*]] = phi i16 [ [[REM]], %if ], [ 3, %entry ]
; CHECK-NEXT:    ret i16 [[RET]]
;
entry:
  %div = sdiv i16 %a, %b
  %cmp = icmp eq i16 %div, 42
  br i1 %cmp, label %if, label %end

if:
  %rem = srem i16 %a, %b
  br label %end

end:
  %ret = phi i16 [ %rem, %if ], [ 3, %entry ]
  ret i16 %ret
}

; FIXME: Hoist the urem because it's safe and likely free.

define i8 @hoist_urem(i8 %a, i8 %b) {
; CHECK-LABEL: @hoist_urem(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[DIV:%.*]] = udiv i8 %a, %b
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i8 [[DIV]], 42
; CHECK-NEXT:    br i1 [[CMP]], label %if, label %end
; CHECK:       if:
; CHECK-NEXT:    [[REM:%.*]] = urem i8 %a, %b
; CHECK-NEXT:    br label %end
; CHECK:       end:
; CHECK-NEXT:    [[RET:%.*]] = phi i8 [ [[REM]], %if ], [ 3, %entry ]
; CHECK-NEXT:    ret i8 [[RET]]
;
entry:
  %div = udiv i8 %a, %b
  %cmp = icmp eq i8 %div, 42
  br i1 %cmp, label %if, label %end

if:
  %rem = urem i8 %a, %b
  br label %end

end:
  %ret = phi i8 [ %rem, %if ], [ 3, %entry ]
  ret i8 %ret
}

