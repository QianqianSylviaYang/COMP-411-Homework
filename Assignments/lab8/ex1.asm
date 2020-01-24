# Starter file for ex1.asm

.data

newline:      	.asciiz "\n"     
.text 0x3000 

main:
ori     $sp, $0, 0x3000     # Initialize stack pointer to the top word below .text
                            # The first value on stack will actually go at 0x2ffc
                            #   because $sp is decremented first.
addi    $fp, $sp, -4        # Set $fp to the start of main's stack frame



	#----------------------------------------------------------------#
	# Write code here to do exactly what main does in the C program.
	#
	# Please follow these guidelines:
	#
	#	Use syscall 5 each time to read an integer (scanf("%d", ...))
	#	Then call NchooseK to compute the function
	#	Then use syscall 1 to print the result
	#   Put all of the above inside a loop
	#----------------------------------------------------------------#
	
	Lwhile:
	
	
	# $s0 = n 
	addi	$v0, $0, 5			# system call 5 is for reading an integer
 	syscall 				# integer value read is in $v0
  	add	$s0, $0, $v0			# copy the width into $s0
  	beq $s0, $0, end
  	
  	# $s1 = k
  	addi	$v0, $0, 5			# system call 5 is for reading an integer
 	syscall 				# integer value read is in $v0
  	add	$s1, $0, $v0			# copy the width into $s1
	beq $s1, $0, end
	
	add $a0, $0, $s0	# n first argument $a0
	add $a1, $0, $s1	# k second argument $a1
	
	jal NchooseK		#call NchooseK
	
	add $s3, $0, $v0	#store the result in $s3
	
	addi 	$v0, $0, 1  			# system call 1 is for printing an integer
  	add 	$a0, $0, $s3			# bring the area value from $10 into $a0
  	syscall           			# print the integer
  	
  	addi 	$v0, $0, 4  			# system call 4 is for printing a string
  	la 	$a0, newline 			# address of areaIs string is in $a0
  	syscall           			# print the string
	
	j Lwhile
	

end: 
	ori   $v0, $0, 10     # system call 10 for exit
	syscall               # we are out of here.



NchooseK:    		# PLEASE DO NOT CHANGE THE NAME "NchooseK"
	#----------------------------------------------------------------#
	# $a0 has the number n, $a1 has k, from which to compute n choose k
	#
	# Write code here to implement the function you wrote in C.
	# Your implementation MUST be recursive; an iterative
	# implementation is not acceptable.
	#
	# $v0 should have the NchooseK result to be returned to main.
	#----------------------------------------------------------------#
#----------------------------------------------------------------#
addi    $sp, $sp, -8        # Make room on stack for saving $ra and $fp
sw      $ra, 4($sp)         # Save $ra
sw      $fp, 0($sp)         # Save $fp

addi    $fp, $sp, 4         # Set $fp to the start of proc1's stack frame

                            # From now on:
                            #     0($fp) --> $ra's saved value
                            #    -4($fp) --> caller's $fp's saved value
#----------------------------------------------------------------#
addi	$sp, $sp, -4
sw	$s0, 0($sp)	#save $s0, n
			# From now on: -8($fp) --> $s0's saved value

addi	$sp, $sp, -4
sw	$s1, 0($sp)	#save $s1, k
			# From now on: -12($fp) --> $s1's saved value
			
addi	$sp, $sp, -4
sw	$s2, 0($sp)	#save $s2, k
			# From now on: -16($fp) --> $s2's saved value

#----------------------------------------------------------------#
addi $v0, $0, 1
beq $a1, $0, return	#base case, if k=0, return 1
beq $a1, $a0, return	#base case, if k=n, return 1
#----------------------------------------------------------------#
addi $a0, $a0, -1	# n = n-1
add $s0, $a0, $0	#n in $s1
add $s1, $a1, $0	#k in $s2
jal NchooseK		# call NchooseK(n-1,k)
add $s2, $0, $v0	#save the result for NchooseK(n-1,k) in $s3
add $a0, $0, $s0	#n in $a0
add $a1, $0, $s1	#n in $a1
addi $a1, $a1, -1	#k=k-1
jal NchooseK		# call NchooseK(n-1, k-1)
add $v0, $v0, $s2	#the return value $v0 = NchooseK(n-1,k)+NchooseK(n-1,k-1)
#----------------------------------------------------------------#
#----------------------------------------------------------------#
lw $s0, -8($fp) 	#restore $s0
lw $s1, -12($fp)	#restore $s1
lw $s2, -16($fp)
#----------------------------------------------------------------#
return:
addi    $sp, $fp, 4     # Restore $sp
lw      $ra, 0($fp)     # Restore $ra
lw      $fp, -4($fp)    # Restore $fp
jr      $ra             # Return from procedure

