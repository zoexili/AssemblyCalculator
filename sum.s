	.intel_syntax noprefix
	.section .data
	.global SUM_POSITIVE # make SUM_POSITIVE global so that sumtest can use it
	.global SUM_NEGATIVE # make SUM_NEGATIVE global so that sumtest can use it
SUM_POSITIVE:
	.quad 0  # set aside 8 bytes
SUM_NEGATIVE:
	.quad 0  # set aside 8 byte
	.section .text
	# INPUTS: rax -> x
	#         rbx -> &y address of where in memory y is
	# OUTPUTS: x = x + y : update rax by adding y
	#                      quantity at the location of &y
	#          if y is positive then add y into an 8 byte value
	#          at stored at a location marked by a symbol
	#          named SUM_POSTIVE
	#          else add y into an 8 byte value stored at a
	#          location marked by a symbol named SUM_NEGATIVE
	#          final rbx should be updated to equal &y + 8
	# This file must provide the symbols SUM_POSTIVE
	# and SUM_NEGATIVE and associated memory
	.global SUM_FRAG
SUM_FRAG:
	add rax, QWORD PTR [rbx] # add values in rax and the values saved in the memory address in rbx.
	cmp QWORD PTR [rbx], 0  # compare 8-byte value at the address in rbx to 0
	# if negative (y < 0) jump to negative case
	jl is_neg
	# positive case y > 0
	mov r12, QWORD PTR [rbx]  # add values saved in the address of rbx into rcx
	add QWORD PTR [SUM_POSITIVE], r12  # add values saved in rcx into the address of SUM_POSITIVE
	jmp done_cond  # jump to done_cond
is_neg:	 # negative case
	mov r12, QWORD PTR [rbx]  # add values saved in the address of rbx into rcx.
	add QWORD PTR [SUM_NEGATIVE], r12  # add values saved in rcx into the address of SUM_NEGATIVE.
done_cond:
	add rbx, 8  # update rbx to equal &y+8
	ret   # use ret instruction to return back to where they get called from
