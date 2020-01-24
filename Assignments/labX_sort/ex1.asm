.data
newline:	.asciiz "\n"
Strings:	.space 10000
temp: 		.word 0


.text 0x3000
main:
ori     $sp, $0, 0x3000     # Initialize stack pointer to the top word below .text
                            # The first value on stack will actually go at 0x2ffc
                            #   because $sp is decremented first.
addi    $fp, $sp, -4        # Set $fp to the start of main's stack frame
#-------------------------Enter N---------------------------------------#
addi	$v0, $0, 5		# system call 5 is for reading an integer
syscall 			# integer value read is in $v0
add	$s0, $0, $v0		# $s0 = N
#-------------------------Enter String---------------------------------------#

	addi $t0, $0, 100
	mult $s0,$t0
	mflo $s1
	
	add $t0, $0, $0		# No. of String index, increase by 100 to 100N

	LForSIn:
	add $t2, $t1, $t0	#calaculate the loaction
	addi	$v0, $0, 8		# system call 5 is for reading an integer
	la $a0, Strings($t0)
	addi $a1, $0, 100
	syscall 			# integer value read is in $v0
	
	toNextString1:
	addi $t0, $t0, 100
	slt $t6, $t0, $s1	# if $t0 < 1000
	beq $t6, 0, out2
	j LForSIn

#---------------------Sort-------------------------------------------#
out2:	
	add $s2, $0, $0		# pointer for string1 i
	LForSort1:
			
		add $s3, $0, $0	# pointer for string2 j
		LForSort2:
		add $a0, $s3, 0
            	addi $a1, $s3, 100
            	jal my_compare_strings
            	add $t2, $v0, $0
            	
            	bne $t2, 1, NoSwap
            	add $a0, $s3, 0
            	addi $a1, $s3, 100
            	jal my_swap_strings

		NoSwap:
            	addi $t3, $s1, -100	# NUM-1
            	sub $t3, $t3, $s2	# NUM-1-i
            	addi $s3, $s3, 100	# j++
            	slt $t4, $s3, $t3
            	bne $t4, 0, LForSort2
            	
	addi $t5, $s1, -100
	addi $s2, $s2, 100
	slt $t6, $s2, $t5
	bne $t6, 0, LForSort1
	
	
	
add $t0, $0, $0		# No. of String index, increase by 100 to 100N
	add $t1, $0, $0		# No. of char index, increase by 1 to 100
	LForSOut1:
	add $t2, $t1, $t0	#calaculate the loaction
	lb $a0, Strings($t2)
	addi	$v0, $0, 11		# system call 5 is for reading an integer
	syscall 			# integer value read is in $v0
	
	li $t3,'\n'
	lb $t4, Strings($t2)
	beq $t3, $t4, toNextString3
	
	addi $t1, $t1, 1
	slti $t5, $t1, 100 	# if $t1 < 100
	bne $t5, 0, LForSOut1
	
	toNextString3:
	addi $t0, $t0, 100
	slt $t6, $t0, $s1	# if $t0 < 1000
	beq $t6, 0, end
	add $t1, $0, $0	
	j LForSOut1
#------------------------End----------------------------------------#           	
end: 
ori   $v0, $0, 10     # system call 10 for exit
syscall               # we are out of here.	
#----------------------------------------------------------------#
		# Compare
#----------------------------------------------------------------#
my_compare_strings:
addi    $sp, $sp, -8        # Make room on stack for saving $ra and $fp
sw      $ra, 4($sp)         # Save $ra
sw      $fp, 0($sp)         # Save $fp

addi    $fp, $sp, 4         # Set $fp to the start of proc1's stack frame

                             # From now on:
                             #     0($fp) --> $ra's saved value
              	         #    -4($fp) --> caller's $fp's saved value
#----------------------------------------------------------------#
  # Save any $sx registers that proc1 will modify
                                # Save any of the $sx registers that proc1 modifies
    addi    $sp, $sp, -16       # e.g., $s0, $s1, $s2, $s3
    sw      $s0, 12($sp)        # Save $s0
    sw      $s1, 8($sp)         # Save $s1
    sw      $s2, 4($sp)         # Save $s2
    sw      $s3, 0($sp)         # Save $s3

                                # From now on:
                                #    -8($fp) --> $s0's saved value
                                #   -12($fp) --> $s1's saved value
                                #   -16($fp) --> $s2's saved value
                                #   -20($fp) --> $s3's saved value
#----------------------------------------------------------------#
	add $s0, $a0, $0
	add $s1, $a1, $0
	add $t0, $0, $0
	LForC:
	add $t1, $t0, $s0
	lb $t2, Strings($t1)
		
	add $t3, $t0, $s1
	lb $t4, Strings($t3)
	 	
	li $t5,'\n'
	beq $t2, $t5, String1End
	beq $t4, $t5, String2End
	
	slt $t6, $t2, $t4
	beq $t6, 1, Char1Small
	slt $t7, $t4, $t2
	beq $t7, 1, Char2Small
	
	addi $t0, $t0, 1
	slti $t8, $t0, 100
	bne $t8, 0, LForC
#----------------------------------------------------------------#	
String1End:
li $t5, '\n'
beq $t4, $t5, return0
j return_1

String2End:
j return1

Char1Small:
j return_1

Char2Small:
j return1

return0:
add $v0, $0, $0
j return

return_1:
addi $v0, $0, -1
j return 

return1:
addi $v0, $0, 1
j return
#----------------------------------------------------------------#
return:
    # Restore $sx registers
    lw  $s0,  -8($fp)           # Restore $s0
    lw  $s1, -12($fp)           # Restore $s1
    lw  $s2, -16($fp)           # Restore $s2
    lw  $s3, -20($fp)           # Restore $s3
    addi    $sp, $fp, 4     # Restore $sp
    lw      $ra, 0($fp)     # Restore $ra
    lw      $fp, -4($fp)    # Restore $fp
    jr      $ra             # Return from procedure
#----------------------------------------------------------------#
	# Swap
#----------------------------------------------------------------#
my_swap_strings:
addi    $sp, $sp, -8        # Make room on stack for saving $ra and $fp
sw      $ra, 4($sp)         # Save $ra
sw      $fp, 0($sp)         # Save $fp

addi    $fp, $sp, 4         # Set $fp to the start of proc1's stack frame

                             # From now on:
                             #     0($fp) --> $ra's saved value
              	         #    -4($fp) --> caller's $fp's saved value
#----------------------------------------------------------------#
  # Save any $sx registers that proc1 will modify
                                # Save any of the $sx registers that proc1 modifies
    addi    $sp, $sp, -16       # e.g., $s0, $s1, $s2, $s3
    sw      $s0, 12($sp)        # Save $s0
    sw      $s1, 8($sp)         # Save $s1
    sw      $s2, 4($sp)         # Save $s2
    sw      $s3, 0($sp)         # Save $s3

                                # From now on:
                                #    -8($fp) --> $s0's saved value
                                #   -12($fp) --> $s1's saved value
                                #   -16($fp) --> $s2's saved value
                                #   -20($fp) --> $s3's saved value
#----------------------------------------------------------------#
add $s0, $a0, $0
add $s1, $a1, $0
	add $t0, $0, $0
	LForS:
	add $t1, $s0, $t0
	lb $t2, Strings($t1)
	add $t3, $s1, $t0
	lb $t4, Strings($t3)
	
	sb $t4, Strings($t1)
	sb $t2, Strings($t3)
	
	addi $t0, $t0, 1
	slti $t5, $t0, 100
	bne $t5, 0, LForS

# Restore $sx registers
    lw  $s0,  -8($fp)           # Restore $s0
    lw  $s1, -12($fp)           # Restore $s1
    lw  $s2, -16($fp)           # Restore $s2
    lw  $s3, -20($fp)           # Restore $s3
    addi    $sp, $fp, 4     # Restore $sp
    lw      $ra, 0($fp)     # Restore $ra
    lw      $fp, -4($fp)    # Restore $fp
    jr      $ra             # Return from procedure	
