begin
  repeat
    print_string("Hello"); newline()
  until true
end.

(*<<
Hello
>>*)

(*[[
@ picoPascal compiler output
	.global pmain

	.text
pmain:
	mov ip, sp
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
@     print_string("Hello"); newline()
	mov r1, #5
	ldr r0, =g1
	bl print_string
	bl newline
	ldmfd fp, {r4-r10, fp, sp, pc}
	.pool

	.data
g1:
	.byte 72, 101, 108, 108, 111
	.byte 0
@ End
]]*)
