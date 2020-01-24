.data
maze:		.space 625
wasHere:	.space 625
correctPath:	.space 625
dot:		.asciiz "."

.text 0x3000
main:
ori     $sp, $0, 0x3000     # Initialize stack pointer to the top word below .text
                            # The first value on stack will actually go at 0x2ffc
                            #   because $sp is decremented first.
addi    $fp, $sp, -4        # Set $fp to the start of main's stack frame
#----------------------------------------------------------------#
addi	$v0, $0, 5		# system call 5 is for reading an integer
syscall 			# integer value read is in $v0
add	$s0, $0, $v0		# $s0 = width
add $t8, $s0, $0

addi	$v0, $0, 5		# system call 5 is for reading an integer
syscall 			# integer value read is in $v0
add	$s1, $0, $v0		# $s1 = height
add $t9, $0, $0
#----------------------------------------------------------------#
mult $s1, $s0
mflo $s2			# width*height
#----------------------------------------------------------------#
	addi $t1, $s0, 2
	add $t0, $0, $0
	LforIn:
	
	addi	$v0, $0, 8		# system call 5 is for reading an integer
	la $a0, maze($t0)
	add $a1, $0, $t1
	syscall
	
	add $t0, $t0, $s0
	slt $t2, $t0, $s2
	bne $t2, 0, LforIn
#----------------------------------------------------------------#
	add $t0, $0, $0		# $t0, increase by width, <width*height
	add $t1, $0, $0		# $t0, increase height, <height
	LforInH:
		add $t2, $0, $0		#$t2, increase by 1, <width
		LforInW:
		add $t3, $t0, $t2	# calculate the position
		
		add $t4, $0, $0
		sb $t4, wasHere($t3)	# wasHere[y][x] = false;
		sb $t4, correctPath($t3)	# correctPath[y][x]= false;
		
		
		lb $t3, maze($t3)	# maze[y][x]=tempchar;
		
		li $t4, 'S'
		bne $t3, $t4, notStart	# if(tempchar=='S'){
		add $s3, $t2, $0	# startX=$s3;
		add $s4, $t1, $0	# startY=$s4;
		
		notStart:
		li $t4, 'F'
		bne $t3, $t4, notFinish	# if(tempchar=='F'){
		add $s5, $t2, $0	#endX=$s5;
		add $s6, $t1, $0	#endY=$s6;
		
		notFinish:
		addi $t2, $t2, 1
		slt $t3, $t2, $s0	# <width
		bne $t3, 0, LforInW
		
	
	
	addi $t1, $t1, 1
	add $t0, $t0, $s0
	slt $t3, $t1, $s1	# <height
	bne $t3, $0, LforInH

#----------------------------------------------------------------#
add $a0, $s3, $0
add $a1, $s4, $0
add $a2, $s5, $0
add $a3, $s6, $0
jal recursiveSolve
add $s7, $v0, $0
#----------------------------------------------------------------#	
	add $t0, $0, $0		# increase by width
	add $t1, $0, $0		# increase by 1
	LforOutP1:
		add $t2, $0, $0
		LforOutP2:
		add $t3, $t0, $t2	# calculate the position
		lb $t4, correctPath($t3)
		bne $t4, 1, PrintWall
			li $t6, 'S'
			lb $t5, maze($t3)
			beq $t5, $t6, PrintPath
				addi 	$v0, $0, 4  		# system call 4 is for printing a string
				la 	$a0, dot		# address of areaIs string is in $a0
				syscall           		# print the string
				j PrintOut
			PrintPath:
				addi $v0, $0, 11
				lb $a0, maze($t3)
				syscall
				j PrintOut
		PrintWall:
		addi $v0, $0, 11
		lb $a0, maze($t3)
		syscall	
		
		PrintOut:
		addi $t2, $t2, 1
		slt $t3, $t2, $s0
		bne $t3, 0, LforOutP2
		
	li $a0, '\n'
	addi $v0, $0, 11
	syscall	
	
	addi $t1, $t1, 1
	add $t0, $t0, $s0
	slt $t3, $t1, $s1	# <height
	bne $t3, $0, LforOutP1
#----------------------------------------------------------------#	
#----------------------------------------------------------------#
end: 
ori   $v0, $0, 10     # system call 10 for exit
syscall               # we are out of here.
#----------------------------------------------------------------#		
#----------------------------------------------------------------#
recursiveSolve:
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
    addi    $sp, $sp, -28      # e.g., $s0, $s1, $s2, $s3, $s4, $s5, $6
    sw      $s0, 24($sp)        # Save $s0
    sw      $s1, 20($sp)         # Save $s1
    sw      $s2, 16($sp)         # Save $s2
    sw      $s3, 12($sp)         # Save $s3
    sw      $s4, 8($sp)         # Save $s2
    sw      $s5, 4($sp)         # Save $s5
    sw      $s6, 0($sp)         # Save $s5

                                # From now on:
                                #    -8($fp) --> $s0's saved value
                                #   -12($fp) --> $s1's saved value
                                #   -16($fp) --> $s2's saved value
                                #   -20($fp) --> $s3's saved value
#----------------------------------------------------------------#
add $s4, $t8, $0	# width
add $s5, $t9, $0	# height
add $s0, $a0, $0	# i
add $s1, $a1, $0	# j
add $s2, $a2, $0	# endX
add $s3, $a3, $0	# endY

#----------------------------------------------------------------#
bne $s0, $s2, continueLoop
bne $s1, $s3, continueLoop	# if(i==endX&&j==endY)
j returnTrue			# return true
#----------------------------------------------------------------#
continueLoop:
mult $s1, $s4
mflo $s6
add $s6, $s6, $s0	# $t0 calculate position width*j+i

lb $t1, maze($s6)

#----------------------------------------------------------------#
li $t2, '*'
beq $t2, $t1, returnFalse	# if(maze[j][i]=='*' )return false;
#----------------------------------------------------------------#
lb $t2, wasHere($s6)
beq $t2, 1, returnFalse	# if(wasHere[j][i]==true)return false;
#----------------------------------------------------------------#
addi $t2, $0, 1
sb $t2, wasHere($s6)		# wasHere[j][i]=true;
#----------------------------------------------------------------#
beq $s0, 0, CheckIfNotRE
	addi $a0, $s0, -1
	add $a1, $s1, $0
	add $a2, $s2, $0
	add $a3, $s3, $0
	jal recursiveSolve		# recursiveSolve(i-1, j)
	beq $v0, 0, CheckIfNotRE	# if(recursiveSolve(i-1, j))
		addi $t2, $0, 1
		sb $t2, correctPath($s6)	# correctPath[j][i]=true;//Set that path value to true;
		j returnTrue		# return true;
#----------------------------------------------------------------#		
CheckIfNotRE:
addi $t0, $s4, -1
beq $t0, $s0, CheckIfNotTE
	addi $a0, $s0, 1
	add $a1, $s1, $0
	add $a2, $s2, $0
	add $a3, $s3, $0		
	jal recursiveSolve		# recursiveSolve(i+1,j)
	beq $v0, 0, CheckIfNotTE
		addi $t2, $0, 1
		sb $t2, correctPath($s6)	# correctPath[j][i]=true;//Set that path value to true;
		j returnTrue		# return true;
#----------------------------------------------------------------#	
CheckIfNotTE:
beq $s1, 0, CheckIfNotBE
	add $a0, $s0, $0
	addi $a1, $s1, -1
	add $a2, $s2, $0
	add $a3, $s3, $0		
	jal recursiveSolve		# recursiveSolve(i,j-1)
	beq $v0, 0, CheckIfNotBE
		addi $t2, $0, 1
		sb $t2, correctPath($s6)	# correctPath[j][i]=true;//Set that path value to true;
		j returnTrue		# return true;
#----------------------------------------------------------------#	
CheckIfNotBE:
addi $t0, $s5, -1
beq $t0, $s1, returnFalse	
	add $a0, $s0, $0
	addi $a1, $s1, 1
	add $a2, $s2, $0
	add $a3, $s3, $0		
	jal recursiveSolve		# recursiveSolve(i,j-1)	
	beq $v0, 0, returnFalse
		addi $t2, $0, 1
		sb $t2, correctPath($s6)	# correctPath[j][i]=true;//Set that path value to true;
		j returnTrue		# return true;
#----------------------------------------------------------------#
returnTrue:
addi $v0, $0, 1
j return
returnFalse:
add $v0, $0, $0
j return
#----------------------------------------------------------------#
return:
    lw  $s0,  -8($fp)           # Restore $s0
    lw  $s1, -12($fp)           # Restore $s1
    lw  $s2, -16($fp)           # Restore $s2
    lw  $s3, -20($fp)           # Restore $s3
    lw  $s4, -24($fp)           # Restore $s1
    lw  $s5, -28($fp)           # Restore $s2
    lw  $s6, -32($fp)           # Restore $s3
    addi    $sp, $fp, 4     # Restore $sp
    lw      $ra, 0($fp)     # Restore $ra
    lw      $fp, -4($fp)    # Restore $fp
    jr      $ra             # Return from procedure	