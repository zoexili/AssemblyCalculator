	.intel_syntax noprefix
	.data
	.global ptr
ptr:	.quad 0  # to save rax
	.text
	.global _start
_start:
	# zero out rax
	xor rax, rax
	#initialize rbx to the address of CALC_DATA_BEGIN
	mov rbx, OFFSET [CALC_DATA_BEGIN]
	jmp loop_test
loop_start:
	# assign rax the command argument
	# if rbx is &
	cmp QWORD PTR [rbx], 0x26
	# jump to calc_and
	je calc_and
	# if rbx is |
	cmp QWORD PTR [rbx], 0x7c
	# jump to calc_or
	je calc_or
	# if rbx is S
	cmp QWORD PTR [rbx], 0x53
	# jump to calc_sum
	je calc_sum
	# if rbx is U
	cmp QWORD PTR [rbx], 0x55
	# jump to calc_upper
	je calc_upper

	jmp loop_test
calc_upper:  
	# advance rbx by 8 so it points to the command argument
	add rbx, 8
	# call upper function
	call UPPER_FRAG
	jmp loop_test
calc_and:
	add rbx, 8
	# call and function
	call AND_FRAG
	jmp loop_test
calc_or:
	add rbx, 8
	# call or function
	call OR_FRAG
	jmp loop_test
calc_sum:
	add rbx, 8
	# call sum function
	call SUM_FRAG
	jmp loop_test
loop_test:
	# check if first byte of current command is 0
	cmp QWORD PTR [rbx], 0x0
	# if !=0, jump to loop start
	jne loop_start

done_cond:
	# write out the final value of rax
	add QWORD PTR [ptr], rax
	mov rax, 1
	mov rdi, 1
	mov rsi, OFFSET [ptr]
	mov rdx, 8
	syscall

	# write out the final value of SUM_POSITIVE
	mov rax, 1
	mov rdi, 1
	mov rsi, OFFSET [SUM_POSITIVE]
	mov rdx, 8
	syscall

	# write out the final value of SUM_NEGATIVE
	mov rax, 1
	mov rdi, 1
	mov rsi, OFFSET [SUM_NEGATIVE]
	mov rdx, 8
	syscall

	# write out the memory between CALC_DATA_BEGIN and CALC_DATA_END
	mov rax, 1
	mov rdi, 1
	mov r14, OFFSET [CALC_DATA_END] # save CALC_DATA_END into r14
	SUB r14, OFFSET [CALC_DATA_BEGIN] # r14 = r14 - CALC_DATA_BEGIN, number of bytes
	mov rsi, OFFSET [CALC_DATA_BEGIN] # assign rsi to CALC_DATA_BEGIN
	mov rdx, r14 # move r14 into rdx
	syscall

	mov rax, 60
	mov rdi, 0
	syscall 
