	.intel_syntax noprefix

	.section .text
	# INPUTS: rax -> x
	#         rbx -> &y address of where in memory y is
	# OUTPUTS: x = x bitwise or y : update rax with bitwise or of the
	#                               8 byte quantity at the location of &y
	#          rbx should be updated to equal &y + 8
	.global OR_FRAG
OR_FRAG:
	or rax, QWORD PTR [rbx]  # Bitwise or: set a subset of the bits from both values.
	add rbx, 8  # update rbx to &y + 8.
done_cond:
	ret  # use ret to return back to where they get called from
