importFile:
	li $v0, 13		#open connection to file
	la $a0, filename
	li $a1, 0
	li $a2, 0
	syscall
	
	move $s0, $v0		#save file descripter
	
	li $v0, 14		#read from file
	move $a0, $s0
	la $a1, dictionary
	li $a2, 180000
	syscall
	
	li $v0, 16		#close file connection
	move $a0, $s0
	syscall
	
j importReturn

###########################################################################################

fillDictionaryArray:
	la $a0, dictionary	#scanner
	la $a1, dictionaryArray	#loading array
	sw $a0, ($a1)		#loading first word
	xor $v0, $v0, $v0	#reset register just in case
	addi $v0, $v0, 1	#setting array length to 1
	addi $a1, $a1, 4	#moving pointer to first word
fillDictionaryArrayLoop:
	lb $t0, ($a0)		#loads byte from dictionary
	beq $t0, 0, fillDictionaryArrayReturn #return if it hits a null character (0)
	bne $t0, 10, fillSkipped #go other way if failed.
	sb $zero, ($a0)		#replaces the new line with null
	add $a0, $a0, 1		#Advances the scanner
	sw $a0, ($a1)		#Store scanner pos as pointer in dictionaryArray
	addi $a1, $a1, 4		#Move the dictionaryArray point over to next storing location
	addi $v1, $v1, 1		#add 1 to the number of words.
j fillDictionaryArrayLoop

fillSkipped:
	add $a0, $a0, 1		#Advances the scanner
j fillDictionaryArrayLoop

fillDictionaryArrayReturn:
	sw $v1, lengthOfList
j arrayReturn
#array filled
