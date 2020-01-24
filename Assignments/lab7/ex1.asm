.data
  AA:     .space 400  		# int AA[100]
  BB:     .space 400  		# int BB[100]
  CC:     .space 400  		# int CC[100]
  m:      .space 4   		# m is an int whose value is at most 10
                     		# actual size of the above matrices is mxm


space:  .asciiz " "
newline: .asciiz "\n"

.text 

main:
#------- INSERT YOUR CODE HERE for main -------
#
#  Best is to convert the C program line by line
#    into its assembly equivalent.  Carefully review
#    the coding templates near the end of Lecture 8.
#
#
	#  1.  First, read m (the matrices will then be size mxm).
	addi $v0, $0, 5			# system call 5 is for reading an integer
 	syscall 				# integer value read is in $v0	
  	add $8, $0, $v0			# put the value into $8
  	sw $8, m($0)				# save the value in m
  	
  	#  2.  Next, read matrix A
  	add $9, $0, $0		#$9=i
  	ALforI:
  		add $10, $0, $0		#$10=j
  		ALforJ:
  			addi $v0, $0, 5		#scan
  			syscall			#store in $v0
  			add $11, $0, $v0	# value in $11
  			
  			lw $8, m($0)		#load m in $8
  			mult $8, $9		#i*m
  			mflo $12		#$12=i*m
  			add $12, $12, $10	#$12 = i*m+j
  			sll $12, $12, 2		#$12 adjust for 4
  			
  			sw $11, AA($12)		#save the number in AA
  			
  			addi $10, $10, 1	#j++
  			slt $13, $10,$8		#$13 = (j<m)
  			bne $13, $0, ALforJ	#if true, then loop j
  			
  		addi $9, $9, 1		#i++
  		slt $14, $9, $8		#$14 = (i<m)
  		bne $14, $0, ALforI	#if true, loop for i
  	
  	#  2.  Next, read matrix B
  	add $9, $0, $0		#$9=i
  	BLforI:
  		add $10, $0, $0		#$10=j
  		BLforJ:
  			addi $v0, $0, 5		#scan
  			syscall			#store in $v0
  			add $11, $0, $v0	# value in $11
  			
  			lw $8, m($0)		#load m in $8
  			mult $8, $9		#i*m
  			mflo $12		#$12=i*m
  			add $12, $12, $10	#$12 = i*m+j
  			sll $12, $12, 2		#$12 adjust for 4
  			
  			sw $11, BB($12)		#save the number in AA
  			
  			addi $10, $10, 1	#j++
  			slt $13, $10,$8		#$13 = (j<m)
  			bne $13, $0, BLforJ	#if true, then loop j
  			
  		addi $9, $9, 1		#i++
  		slt $14, $9, $8		#$14 = (i<m)
  		bne $14, $0, BLforI	#if true, loop for i
  	
  	#  3.  Compute matrix product.  You will need triple-nested loops for this.
  	lw $8, m($0)		#load m in $8
  	add $9, $0, $0		#$9=i
  	CLforI:
  		add $10, $0, $0		#$10=j
  		CLforJ:
  			add $11, $0, $0		#$11=temp
  			add $12, $0, $0		#$12=k
  			CLforK:
  				mult $8, $9
  				mflo $13	#$13 = i*m
  				add $13, $13, $12 	#$13=i*m+k
  				sll $13, $13, 2		#adjust for 4
  				lw $25, AA($13)		#$25 = AA[tempA]
  				
  				mult $8, $12
  				mflo $14	#$13 = k*m
  				add $14, $14, $10 	#$13=k*m+j
  				sll $14, $14, 2		#adjust for 4
  				lw $26, BB($14)		#$26 = BB[tempB]
  				
  				mult $25, $26	#AA*BB
  				mflo $27	#lower in $27
  				add $11, $27, $11
  				
  				addi $12, $12, 1	#k++
  				slt $15, $12,$8		#$15 = (k<m)
  				bne $15, $0, CLforK	#if true, then loop k
  			
  			mult $8, $9
  			mflo $24	#$24 = i*m
  			add $24, $24, $10	#$24 = i*m+j
  			sll $24, $24, 2		#adjust for 4
  			sw $11, CC($24)		#store temp in CC[tempC]
  			
  			addi $10, $10, 1	#j++
  			slt $15, $10,$8		#$15 = (j<m)
  			bne $15, $0, CLforJ	#if true, then loop j
  		
  		addi $9, $9, 1	#i++
  		slt $15, $9,$8		#$15 = (i<m)
  		bne $15, $0, CLforI	#if true, then loop i
  	
  	#  4.  Print the result, one row per line, with one (or more) space(s) between
  	#      values within a row
  	lw $8, m($0)	#load m to $8
  	add $9, $0, $0		#$9=i
  	PLforI:	
  		add $10, $0, $0		#10=j
  		PLforJ:
  			mult $8, $9
  			mflo $11	#$11 = i*m
  			add $11, $11, $10	#$11 = i*m+j
  			sll $11, $11, 2		#adjust for 4
  			lw $12, CC($11)		#$12 = CC
  			
  			addi 	$v0, $0, 1  	# system call 1 is for printing an integer
  			add 	$a0, $0, $12 	# bring the area value from $10 into $a0
  			syscall 
  			
  			addi 	$v0, $0, 4  	# system call 4 is for printing a string
  			la 	$a0, space	# address of space string is in $a0
  			syscall 
  			
  			addi $10, $10, 1	#j++
  			slt $13, $10,$8		#$13 = (j<m)
  			bne $13, $0, PLforJ	#if true, then loop j
  			
  		addi 	$v0, $0, 4  			# system call 4 is for printing a string
  		la 	$a0, newline 			# address of areaIs string is in $a0
  		syscall           			# print the string
  		
  	addi $9, $9, 1	#i++
  	slt $14, $9,$8		#$15 = (i<m)
  	bne $14, $0, PLforI	#if true, then loop i


#------------ END CODE ---------------
exit:                     # this is code to terminate the program -- don't mess with this!
  addi $v0, $0, 10      	# system call code 10 for exit
  syscall               	# exit the program
  
#------- If you decide to make other functions, place their code here -------
#
#  You do not have to use helper methods, but you may if you would like to.
#  If you do use them, be sure to do all the proper stack management.
#  For this exercise though, it is easy enough to write all your code
#  within main.
#
#------------ END CODE ---------------