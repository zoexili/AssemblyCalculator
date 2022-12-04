	# UPPER_FRAG Fragment
	.intel_syntax noprefix
	.section .data
	.section .text
	.global UPPER_FRAG
UPPER_FRAG:
	xor r13, r13 # initialize r13, the pointer to the string
	xor r15, r15 # initialize r15
loop_start:	
	mov r15, QWORD PTR [rbx]  # save rbx memory address into r15
	mov cl, BYTE PTR [r15 + r13] # [r15 + r13] is the current char
	cmp cl, 0  # compare cl and 0, if cl=0, go to loop_end
	je loop_end
	cmp cl, 0x61 # compare cl and 'a'
	jb loop_next # if below 'a', increment r13 pointer, and go to loop_start
	cmp cl, 0x7A # compare cl and 'z'
	ja loop_next # if above 'z', increment r13 and go to loop_start
	sub cl, 0x20 # if btn 'a' and 'z', subtract it by 32
	mov BYTE PTR [r15 + r13], cl  # write back to the string
loop_next:
	inc r13  # increment r13 pointer
	jmp loop_start
loop_end:
	add rax, r13  # update rax to be the length of the string
	add rbx, 8    # advance rbx 
done:	
	ret
