(* Knuth's "Man or Boy" test *)

proc A(k: integer; proc x1(): integer; proc x2(): integer; 
       proc x3(): integer; proc x4(): integer; proc x5(): integer): integer;
  proc B(): integer;
  begin
    k := k-1;
    return A(k, B, x1, x2, x3, x4)
  end;
begin
  if k <= 0 then return x4() + x5() else return B() end
end;

proc One(): integer; begin return 1 end;
proc MOne(): integer; begin return -1 end;
proc Zero(): integer; begin return 0 end;

begin
  print_num(A(10, One, MOne, MOne, One, Zero)); newline()
end.

(*<<
-67
>>*)

(*[[
@ picoPascal compiler output
	.global pmain

@ proc A(k: integer; proc x1(): integer; proc x2(): integer; 
	.text
_A:
	mov ip, sp
	stmfd sp!, {r0-r3}
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
@   if k <= 0 then return x4() + x5() else return B() end
	ldr r0, [fp, #40]
	cmp r0, #0
	bgt .L4
	ldr r10, [fp, #72]
	ldr r0, [fp, #68]
	blx r0
	ldr r10, [fp, #80]
	mov r4, r0
	ldr r0, [fp, #76]
	blx r0
	add r0, r4, r0
	b .L2
.L4:
	mov r10, fp
	bl _B_g1
.L2:
	ldmfd fp, {r4-r10, fp, sp, pc}
	.pool

@   proc B(): integer;
_B_g1:
	mov ip, sp
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
	sub sp, sp, #32
@     k := k-1;
	ldr r0, [fp, #24]
	add r4, r0, #40
	ldr r0, [r4]
	sub r0, r0, #1
	str r0, [r4]
@     return A(k, B, x1, x2, x3, x4)
	ldr r4, [fp, #24]
	ldr r0, [r4, #72]
	str r0, [sp, #24]
	ldr r0, [r4, #68]
	str r0, [sp, #20]
	ldr r0, [r4, #64]
	str r0, [sp, #16]
	ldr r0, [r4, #60]
	str r0, [sp, #12]
	ldr r0, [r4, #56]
	str r0, [sp, #8]
	ldr r0, [r4, #52]
	str r0, [sp, #4]
	ldr r0, [r4, #48]
	str r0, [sp]
	ldr r3, [r4, #44]
	mov r2, r4
	ldr r1, =_B_g1
	ldr r0, [r4, #40]
	bl _A
	ldmfd fp, {r4-r10, fp, sp, pc}
	.pool

@ proc One(): integer; begin return 1 end;
_One:
	mov ip, sp
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
@ proc One(): integer; begin return 1 end;
	mov r0, #1
	ldmfd fp, {r4-r10, fp, sp, pc}
	.pool

@ proc MOne(): integer; begin return -1 end;
_MOne:
	mov ip, sp
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
@ proc MOne(): integer; begin return -1 end;
	mov r0, #-1
	ldmfd fp, {r4-r10, fp, sp, pc}
	.pool

@ proc Zero(): integer; begin return 0 end;
_Zero:
	mov ip, sp
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
@ proc Zero(): integer; begin return 0 end;
	mov r0, #0
	ldmfd fp, {r4-r10, fp, sp, pc}
	.pool

pmain:
	mov ip, sp
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
	sub sp, sp, #32
@   print_num(A(10, One, MOne, MOne, One, Zero)); newline()
	ldr r4, =_One
	ldr r5, =_MOne
	mov r0, #0
	str r0, [sp, #24]
	ldr r0, =_Zero
	str r0, [sp, #20]
	mov r0, #0
	str r0, [sp, #16]
	str r4, [sp, #12]
	mov r0, #0
	str r0, [sp, #8]
	str r5, [sp, #4]
	mov r0, #0
	str r0, [sp]
	mov r3, r5
	mov r2, #0
	mov r1, r4
	mov r0, #10
	bl _A
	bl print_num
	bl newline
	ldmfd fp, {r4-r10, fp, sp, pc}
	.pool

@ End
]]*)
