.data
newline:      	.asciiz "\n"
x:		.word 0

.text 0x3000
main:
ori     $sp, $0, 0x3000     # Initialize stack pointer to the top word below .text
                            # The first value on stack will actually go at 0x2ffc
                            #   because $sp is decremented first.
addi    $fp, $sp, -4        # Set $fp to the start of main's stack frame

# n in $s0
addi	$v0, $0, 5		# system call 5 is for reading an integer
syscall 			# integer value read is in $v0
add	$s0, $0, $v0		# $s0 = n

add	$s1, $0, $s0		# $s1 = x

la $a0, x			#$a0 = location of x
add $a1, $0, $s0		# $a1 = len
add $a2, $0, $s1		# $a2 = x

jal BinaryPattern		#call BianryPattern

end: 
ori   $v0, $0, 10     # system call 10 for exit
syscall               # we are out of here.
	
BinaryPattern:
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
#----------------------------------------------------------------#
sub	$t0, $a1, $a2	# $t0 = $a1-$a2 = len-x
sll	$t0, $t0, 2	# $t0 = $t0*4
add	$t0, $a0, $t0	# $t0 = $a0 + $t0 = current position
sw	$0, 0($t0)

beq	$a2,1,print1
j else1

print1:
add $t1, $0, $0	# $t1 = i = 0
la $t2, x	# $t2 = the beginning of the array
	Lfor1:
	sll $t3, $t1, 2 	#$t3 = i*4
	add $t3, $t3, $t2 	#$t3 = $t2+i*4
	lw $t4, 0($t3)		# load the current of array in $t3
	addi 	$v0, $0, 1  			# system call 1 is for printing an integer
  	add 	$a0, $0, $t4			# $t4 into $a0
  	syscall  
  	
  	addi $t1, $t1, 1	#i++
  	slt $t5, $t1, $a1	#$t5 = ($i<len)
	bne $t5, $0, Lfor1 	#$t5 is true?
	
addi 	$v0, $0, 4  		# system call 4 is for printing a string
la 	$a0, newline 		# address of areaIs string is in $a0
syscall           		# print the string
  	
la $a0,x	#restore $a0
j endIfElse1
  	
else1:
la 	$a0, x
add 	$a1, $s0, $0
add	$s1, $a2, $0	# a2 store in s0
sub 	$a2, $a2, 1
jal BinaryPattern
la 	$a0, x
add	$a1, $s0, $0
add	$a2, $s1, $0	# a2 might be changed, restore

endIfElse1:
sub	$t0, $a1, $a2	# $t0 = $a1-$a2 = len-x
sll	$t0, $t0, 2	# $t0 = $t0*4
add	$t0, $a0, $t0	# $t0 = $a0 + $t0 = current position
addi	$t7, $0, 1	#put 1 in $t7
sw	$t7, 0($t0)	# 1 in current location

beq	$a2,1,print2
j else2

print2:
add $t1, $0, $0	# $t1 = i = 0
add $t2, $0, $a0	# $t2 = the beginning of the array
	Lfor2:
	sll $t3, $t1, 2 	#$t3 = i*4
	add $t3, $t3, $t2 	#$t3 = $t2+i*4
	lw $t4, 0($t3)		# load the current of array in $t3
	addi 	$v0, $0, 1  			# system call 1 is for printing an integer
  	add 	$a0, $0, $t4			# $t3 into $a0
  	syscall  
  	
  	addi $t1, $t1, 1	#i++
  	slt $t5, $t1, $a1	#$t5 = ($i<len)
	bne $t5, $0, Lfor2 	#$t5 is true?
	
addi 	$v0, $0, 4  		# system call 4 is for printing a string
la 	$a0, newline 		# address of areaIs string is in $a0
syscall           		# print the string
  	
add 	$a0, $t2, $0	#restore $a0
j endIfElse2

else2:
add 	$a0, $a0, $0
add 	$a1, $a1, $0
add	$s1, $a2, $0	# a2 store in s0
sub 	$a2, $a2, 1
jal BinaryPattern
#----------------------------------------------------------------#
endIfElse2:
lw $s0, -8($fp) 	#restore $s0
lw $s1, -12($fp)	#restore $s1
#----------------------------------------------------------------#
return:
addi    $sp, $fp, 4     # Restore $sp
lw      $ra, 0($fp)     # Restore $ra
lw      $fp, -4($fp)    # Restore $fp
jr      $ra             # Return from procedure