	# AND_FRAG Fragement
	.intel_syntax noprefix
	.section .data

	.section .text
	# INPUTS: rax -> x
	#         rbx -> &y address of where in memory y is
	# OUTPUTS: x = x bitwise and y : update rax with bit wise and of the
	#                                8 byte quantity at the location of &y
	#          rbx should be updated to equal &y + 8
	.global AND_FRAG
AND_FRAG:
	AND rax, QWORD PTR [rbx] # bitwise and: extract a subset of the bits in common between rax and the values stored at the memory address that is stored at rbx.
	add rbx, 8 # update rbx to equal &y+8.
done_cond:
	ret  # use ret to return back to where they get called from
