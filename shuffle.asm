.data
#letterArray:	.asciiz "abcdefghi"
.text

#.globl main

shuffle:
	#shuffle scrambles the game letters in memory without changing the position of the central letter

	#5th element is central letter
	la $s0, letterArray
	move $t0, $s0	#move address to temp reg
	move $t1, $s0	#make 2 copies
	
	#6 > 5 > 1 > 7 > 2 > 0 > 8 > 3	> 6	(Order of swapping)
	addi $t0, $t0, 6
	lb $t2, ($t0)	#t2 = element 6
	addi $t1, $t1, 5
	lb $t3, ($t1)	#t3 = element 5, store 5 to be moved
	sb $t2, ($t1)	#element 6 -> place of element 5
	#
	la $t0, letterArray #reset pointer
	addi $t0, $t0, 1
	lb $t2, ($t0)	#t2 = element 1
	sb $t3, ($t0)
	#
	la $t1, letterArray #reset pointer
	addi $t1, $t1, 7
	lb $t3, ($t1)	#t3 = element 7
	sb $t2, ($t1)
	#
	la $t0, letterArray #reset pointer
	addi $t0, $t0, 2
	lb $t2, ($t0)	#t2 = element 2
	sb $t3, ($t0)
	#
	la $t1, letterArray #reset pointer
	addi $t1, $t1, 0
	lb $t3, ($t1)	#t3 = element 0
	sb $t2, ($t1)
	#
	la $t0, letterArray #reset pointer
	addi $t0, $t0, 8
	lb $t2, ($t0)	#t2 = element 8
	sb $t3, ($t0)
	#
	la $t1, letterArray #reset pointer
	addi $t1, $t1, 3
	lb $t3, ($t1)	#t3 = element 3
	sb $t2, ($t1)
	#
	la $t0, letterArray #reset pointer
	addi $t0, $t0, 6
	lb $t2, ($t0)	#t2 = element 6
	sb $t3, ($t0)
	
	#Print for debugging purposes
	#la $a0, letterArray
	#li $v0, 4
	#syscall
	
	j shuffle.return
	
