.data
reset_string:
	.asciiz "Please wait as we try to get the best game possible for you. :) \n"
.text

newGame:
	j resetRegisters
	return.resetRegisters:

	#Generate letters. Stored in letterArray
	j startRandom		#randomizes letters for new game
	return.startRandom:
	
	j testLibManip	#Make Possible Word List (chris's code)
	testManipReturn:
	
	#if lengthOfList < 10, start over j newGame
	la $t0, lengthOfList
	lw $t0, ($t0)
	ble $t0, 10, newGameReset
	
	j resetRegisters2	#Reset registers again
	return.resetRegisters2:
	
	j initializeScore
	return.initializeScore:
	
	j displayWordbox	#Display the letters
	return.displayWordbox:
	
	j takeInput
	return.takeInput:
	
displayWordbox:	
	#Display Word Box
	j wordbox
	return.wordbox:
	j return.displayWordbox

takeInput:
	j input
	return.input:
	j return.takeInput
	
initializeScore:
	la $s0, score
	sw $0, ($s0)	#initialize score to 0
	j return.initializeScore

gameOver.loser:
	#You lost message
	la $a0, loser_msg
	li $v0, 4
	syscall
	
	la $a0, nLine
	li $v0, 4
	syscall	#prints newline
	
	la $a0, filler_string
	li $v0, 4
	syscall#prints *********, for looks
	la $a0, nLine
	li $v0, 4
	syscall	#prints newline
	
	#print possible words
	la $t0, gameDict
	
	printWordsFoundLoop:
	lw $a0, ($t0)
	#check if filler_string (********)
	beqz $a0, exitWordsFoundLoop
	lb $t3, ($a0)
	la $t2, filler_string
	lb $t2, ($t2)
	beq $t3, $t2, skipWord	#if the word is the filler string, skip it, dont print it
	
	li $v0, 4
	syscall

	la $a0, nLine
	li $v0, 4
	syscall	#print newline
	
	addi $t0, $t0, 4	#increments to next word of words found
	lw $t1, ($t0)
	beqz $t1, exitWordsFoundLoop
	beq $t1, 10, exitWordsFoundLoop
	j printWordsFoundLoop
	
	skipWord:
	addi $t0, $t0, 4	#increments to next word of words found
	j printWordsFoundLoop
	exitWordsFoundLoop:
	
	la $a0, filler_string
	li $v0, 4
	syscall#prints *********, for looks
	la $a0, nLine
	li $v0, 4
	syscall	#prints newline
	la $a0, nLine
	li $v0, 4
	syscall	#prints newline
	
	la $a0, possibleWordsNum_msg
	li $v0, 4
	syscall
	
	la $a0, lengthOfList
	lb $a0, ($a0)
	li $v0, 1
	syscall
	
	#Create tabspace
	la $a0, tabSpace
	li $v0, 4
	syscall
	
	#correctWordsNum_msg
	la $a0, correctWordsNum_msg
	li $v0, 4
	syscall
	
	la $a0, numWordsCorrect
	lb $a0, ($a0)
	li $v0, 1
	syscall
	
	la $a0, nLine
	li $v0, 4
	syscall	#prints newline
	
	#print score
	la $a0, score_final_msg
	li $v0, 4
	syscall#prints final score message
	lw $a0, score
	li $v0, 1
	syscall	#prints score
	la $a0, nLine
	li $v0, 4
	syscall	#prints newline
	
	#exit game
	j exit
	
gameOver.winner:
	#You won! message
	la $a0, winner_msg
	li $v0, 4
	syscall
	
	#print score
	la $a0, score_final_msg
	li $v0, 4
	syscall#prints final score message
	lw $a0, score
	li $v0, 1
	syscall	#prints score
	la $a0, nLine
	li $v0, 4
	syscall	#prints newline
	
	#exit game
	j exit
	
newGameReset:
	la $t0, letterArray
	sb $0, ($t0)
	sb $0, 1($t0)
	sb $0, 2($t0)
	sb $0, 3($t0)
	sb $0, 4($t0)
	sb $0, 5($t0)
	sb $0, 6($t0)
	sb $0, 7($t0)
	sb $0, 8($t0)
	
	la $t0, compare
	li $t1, 48
	sb $t1, ($t0)
	sb $t1, 1($t0)
	sb $t1, 2($t0)
	sb $t1, 3($t0)
	sb $t1, 4($t0)
	sb $t1, 5($t0)
	sb $t1, 6($t0)
	sb $t1, 7($t0)
	sb $t1, 8($t0)
	sb $t1, 9($t0)
	sb $t1, 10($t0)
	sb $t1, 11($t0)
	sb $t1, 12($t0)
	sb $t1, 13($t0)
	sb $t1, 14($t0)
	sb $t1, 15($t0)
	sb $t1, 16($t0)
	sb $t1, 17($t0)
	sb $t1, 18($t0)
	sb $t1, 19($t0)
	sb $t1, 20($t0)
	sb $t1, 21($t0)
	sb $t1, 22($t0)
	sb $t1, 23($t0)
	sb $t1, 24($t0)
	sb $t1, 25($t0)
	
	
	la $a0, reset_string
	li $v0, 4
	syscall
	
	j newGame
