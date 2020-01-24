.data
animals:	.space 300	# 20 pair, 15 each
lyrics:		.space 1200	# 20 pair, 60 each
Lyric1:		.asciiz "There was an old lady who swallowed a "
Lyric2_1:	.asciiz "She swallowed the "
Lyric2_2:	.asciiz " to catch the "
Lyric3_1:	.asciiz "I don't know why she swallowed a "
Lyric3_2:	.asciiz " - "
newline:	.asciiz "\n"
END:		.asciiz "END\n"
blank:		.asciiz " "

.text 0x3000
main:
ori     $sp, $0, 0x3000     # Initialize stack pointer to the top word below .text
                            # The first value on stack will actually go at 0x2ffc
                            #   because $sp is decremented first.
addi    $fp, $sp, -4        # Set $fp to the start of main's stack frame
#----------------------------------------------------------------#
add $s0, $0, $0			# $s0, number, i

	add $s1, $0, $0		# number of animals/lyrics
	add $s2, $0, $0
	LforSIn:
	# fgets(animals[i],15, stdin);
	addi	$v0, $0, 8		# system call 5 is for reading an integer
	la $a0, animals($s1)
	addi $a1, $0, 15
	syscall 
	
	# if it is "END\n", we are done reading
	add $a0, $s1, $0
	jal compareEND
	beq $v0, 1, stopEnter
	
	addi	$v0, $0, 8		# system call 5 is for reading an integer
	la $a0, lyrics($s2)
	addi $a1, $0, 60
	syscall 
	
	addi $s0, $s0, 1
	addi $s1, $s1, 15
	addi $s2, $s2, 60
	j LforSIn

stopEnter:	

add $a0, $0, $0
add $a1, $s0, $0
jal nurseryrhyme
#----------------------------------------------------------------#
end: 
ori   $v0, $0, 10     # system call 10 for exit
syscall               # we are out of here.	

#----------------------------------------------------------------#
#----------------------------------------------------------------#
compareEND:
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
	add $t0, $0, $0
	LforC:
	add $t1, $t0, $s0
	lb $t2, animals($t1)
	lb $t3, END($t0)
	bne $t2, $t3, notEqual
	
	addi $t0, $t0, 1
	slti $t4, $t0, 4
	bne $t4, 0, LforC

addi $v0, $0, 1	
j returnC

notEqual:
add $v0, $0, $0
#----------------------------------------------------------------#
returnC:
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
#----------------------------------------------------------------#	
nurseryrhyme:
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
add $s0, $a0, $0	# current
add $s1, $a1, $0	# number
#----------------------------------------------------------------#
	add $t0, $0, $0
	LforSpace1:
	slt $t1, $t0, $s0
	beq $t1, 0, out3
	addi 	$v0, $0, 4  		# system call 4 is for printing a string
	la 	$a0, blank		# address of areaIs string is in $a0
	syscall           		# print the string

	addi $t0, $t0, 1
	j LforSpace1
out3:
beq $s0, 0, printL1
slt $t0, $0, $s0
beq $t0, 1, printL2
#----------------------------------------------------------------#
printL1:
addi 	$v0, $0, 4  		# system call 4 is for printing a string
la 	$a0, Lyric1 		# address of areaIs string is in $a0
syscall           		# print the string

addi $s2, $0, 15
mult $s2, $s0
mflo $s2		# start position for animals[current]

	add $t0, $0, $0
	LforL1:
	add $t1, $t0, $s2
	lb $a0, animals($t1)
	addi	$v0, $0, 11		# system call 5 is for reading an integer
	syscall 
	
	li $t2,'\n'
	lb $t3, animals($t1)
	beq $t2, $t3, back1	
	
	addi $t0, $t0, 1
	slti $t4, $t0, 15
	bne $t4, 0, LforL1
#----------------------------------------------------------------#
printL2:
addi 	$v0, $0, 4  		# system call 4 is for printing a string
la 	$a0, Lyric2_1 		# address of areaIs string is in $a0
syscall           		# print the string

addi $s3, $s0, -1
addi $s2, $0, 15
mult $s2, $s3
mflo $s2		# start position for animals[current-1]

	add $t0, $0, $0
	LforL2_1:
	add $t1, $t0, $s2
	li $t2,'\n'
	lb $t3, animals($t1)
	beq $t2, $t3, out1
	
	lb $a0, animals($t1)
	addi	$v0, $0, 11		# system call 5 is for reading an integer
	syscall 	
	
	addi $t0, $t0, 1
	slti $t4, $t0, 15
	bne $t4, 0, LforL2_1	

out1:
addi 	$v0, $0, 4  		# system call 4 is for printing a string
la 	$a0, Lyric2_2 		# address of areaIs string is in $a0
syscall 

addi $s2, $0, 15
mult $s2, $s0
mflo $s2		# start position for animals[current]

	add $t0, $0, $0
	LforL2_2:
	add $t1, $t0, $s2
	lb $a0, animals($t1)
	addi	$v0, $0, 11		# system call 5 is for reading an integer
	syscall 
	
	li $t2,'\n'
	lb $t3, animals($t1)
	beq $t2, $t3, back1	
	
	addi $t0, $t0, 1
	slti $t4, $t0, 15
	bne $t4, 0, LforL2_2	
#----------------------------------------------------------------#
back1:
addi $s2, $s1, -1	#number-1
slt $t0, $s0, $s2
bne $t0, 1, printL3

addi $a0, $s0, 1
add $a1, $s1, $0
jal nurseryrhyme
#----------------------------------------------------------------#
printL3:
	add $t0, $0, $0
	LforSpace2:
	slt $t1, $t0, $s0
	beq $t1, 0, out4
	addi 	$v0, $0, 4  		# system call 4 is for printing a string
	la 	$a0, blank		# address of areaIs string is in $a0
	syscall           		# print the string

	addi $t0, $t0, 1
	j LforSpace2
out4:	
addi 	$v0, $0, 4  		# system call 4 is for printing a string
la 	$a0, Lyric3_1 		# address of areaIs string is in $a0
syscall           		# print the string

addi $s2, $0, 15
mult $s2, $s0
mflo $s2		# start position for animals[current]

	add $t0, $0, $0
	LforL3_1:
	add $t1, $t0, $s2
	li $t2,'\n'
	lb $t3, animals($t1)
	beq $t2, $t3, out2
	
	lb $a0, animals($t1)
	addi	$v0, $0, 11		# system call 5 is for reading an integer
	syscall 	
	
	addi $t0, $t0, 1
	slti $t4, $t0, 15
	bne $t4, 0, LforL3_1	

out2:
addi 	$v0, $0, 4  		# system call 4 is for printing a string
la 	$a0, Lyric3_2 		# address of areaIs string is in $a0
syscall           		# print the string

addi $s2, $0, 60
mult $s2, $s0
mflo $s2		# start position for lyrics[current]

	add $t0, $0, $0
	LforL3_2:
	add $t1, $t0, $s2
	lb $a0, lyrics($t1)
	addi	$v0, $0, 11		# system call 5 is for reading an integer
	syscall 
	
	li $t2,'\n'
	lb $t3, lyrics($t1)
	beq $t2, $t3, returnN	
	
	addi $t0, $t0, 1
	slti $t4, $t0, 60
	bne $t4, 0, LforL3_2
#----------------------------------------------------------------#
returnN:
    lw  $s0,  -8($fp)           # Restore $s0
    lw  $s1, -12($fp)           # Restore $s1
    lw  $s2, -16($fp)           # Restore $s2
    lw  $s3, -20($fp)           # Restore $s3
    addi    $sp, $fp, 4     # Restore $sp
    lw      $ra, 0($fp)     # Restore $ra
    lw      $fp, -4($fp)    # Restore $fp
    jr      $ra             # Return from procedure	
