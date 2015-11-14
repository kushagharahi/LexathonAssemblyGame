.data

userInput:
	.space 10	#make space for the 9 word or less entry
score:
	.word 0 # word = 0 for the score.
numWordsCorrect:
	.byte 0
	
Ask_Input:
	.asciiz "\Input: " #in unused memory store this string with address Ask_Input
	
Tell_Output:
	.asciiz "\You typed in: " #in unused memory store this string with address Tell_Output
error_msg:
	.asciiz "That's not right! Try again! (Make sure you include the central letter)\n"
correct_msg:
	.asciiz "Nice word! Can you find anymore?\n"
winner_msg:
	.asciiz "Congratulations! You won the game! :)\n"
loser_msg:
	.asciiz "You lost the game! :(   Here are the words you had left:\n"
score_newscore_msg:
	.asciiz "\Score: "
score_final_msg:
	.asciiz "\FINAL SCORE: "
possibleWordsNum_msg:
	.asciiz "Total Possible Words:	"
correctWordsNum_msg:
	.asciiz "Correct Words:	"
nLine:
	.asciiz "\n"
tabSpace:
	.asciiz "\t"
filler_string:
	.align 2
	.asciiz "*********"
stringcopy_buffer: .space 10	#allocate space for string copy
	
msg_Match: .asciiz "\nMatch\n"
msg_NotMatch: .asciiz "\nNot a Match"
 

.text
#.globl main

#main:
input:
	la $a0, Ask_Input
	li $v0, 4
	syscall
	
	li $v0, 8
	la $a0, userInput
	la $a1, 10
	syscall
	
	move $s0, $a0 #saves string (address in memory?) to $s0
	
	######################################
	#Test if user input an option function
	######################################
	lb $t0, ($s0)
	li $t1, 36	#36 = $. For shuffle
	beq $t0, $t1, option.shuffle
	#li $t1, 63	#63 = ?. For time remaining
	#beq $t0, $t1, option.timeRemaining
	li $t1, 33	#33 = !. For give up
	beq $t0, $t1, option.giveup
	li $t1, 38	#38 = &. For reprinting word box
	beq $t0, $t1, option.reprintBox
	######################################
	
	
	#not an option function, so it was a word guess
	
	jal makeLower	#Convert string input to all lowercase before comparing
	
	#Set registers to hold place in memory of input string and string in memory
	la $s0, userInput
	la $s1, gameDict	#store address of Possible Word List array
	
	#Compare Function. Will need to loop this to search whole possible words list.*****
	jal checkInputMatchWordlist
	
	
	j return.input
	
############################################################################################
#Compare Functions
############################################################################################

#Pseudocode
	#get address of input word
	#get address of array of possible words
	#get the first word from array
	#get first letters of both input and possible word
	#compare first letter of input with letter from possible word
	#if letter matches,
	#	check next letter for match, while there is a next letter to check
	#		if there is not another letter, means the words MATCH!
	#		exit compare loop 
	#	while match, loop, checking next letter for match
	#	if letter doesn't match, exit to check next word, while there is a next word to check
	#if letter doesn't match,
	#	check next word, while there is a next word to check
	
	##########New compare code##########
checkInputMatchWordlist:
	#clear contents of t0, t1, t2
	move $t0, $0
	move $t1, $0
	move $t2, $0
	
	move $t0, $zero
	move $t8, $zero	#used for tally
	move $t1, $s0	#t1 = userInput		moving addresses to the temporary registers
	move $t2, $s1	#t2 = gameDict
	la $s3, lengthOfList
	la $s4, wordsFound
	li $t9, 97	#put 97 in $t9 for future comparison
	
checkInputMatchWordlist.loop:
	#get first word from array
	lw $t5, ($t2)
	#increase words used from array tally since we just grabbed it
	#word tally = t8
	addi $t8, $t8, 1 #wordsgrabbed++
	
	#get first letters
	lb $t3, ($t1) 	#t3 = letter from input
	lb $t4, ($t5)	#t4 = letter from possible word (from gameDict)
	
	beq $t3, $t4, lettersMatch	#if equal, branch to lettersMatch for further checking
	#else, non match, so check next word
	addi $t2, $t2, 4 #shift place in memory to point to next word in gameDict?
	#check if there is another word to compare
	#How to do this?????
	lw $t7, ($s3)	#load size of array for comparision ($s3 holds the address of lengthOfArray)
	beq $t7, $t8, reachedEndOfArray	#if the tally of words grabbed == total possible words
	j checkInputMatchWordlist.loop	#evaluate next word
	
lettersMatch:
#if letter matches,
	#	check next letter for match, while there is a next letter to check
	#		if there is not another letter, means the words MATCH!
	#		exit compare loop 
	addi $t1, $t1, 1 #shift to next letter of input word
	addi $t5, $t5, 1 #shift to next letter of possible word
	
	#load letters in register
	lb $t3, ($t1) 	#t3 = letter from input
	lb $t4, ($t5)	#t4 = letter from possible word (from gameDict)
	
	#check if there is a next letter for both. If there isn't then...?
	#if there is a next letter in input but still another letter for possible word, then NOT A MATCH.
	#if there is a next letter in possible word but still another letter for input, then NOT A MATCH.
	#if there is not a next letter for both, then MATCH 
	blt $t3, $t9, checkForNextInPossibleword
	#else, there is still another letter in input word. So check the possible word for next letter
	blt $t4, $t9, checkForNextInInput
	
	#else, both have another letter to check if match
	#check if letters match
	beq $t3, $t4, lettersMatch
	#else, not equal, mismatch
	j wordsMismatch
	
checkForNextInPossibleword:
	blt $t4, $t9, wordsMatch
	#else, mismatch
	j wordsMismatch
checkForNextInInput:
	blt $t3, $t9, wordsMatch
	#else, mismatch
	j wordsMismatch
	
wordsMatch:
	#save t2 to s2 (for some reason?)
	move $s2, $t2
	#Increase words found counter
	addi $s7, $s7, 1	#s7 holds word counter
	
	#If the word counter == possible words, go to end game. Player just won
	la $s6, lengthOfList
	lw $s6, ($s6)	#fetch number from length of list for comparison
	beq $s7, $s6, gameOver.winner
	
	#display message saying the word was correct
	la $a0, correct_msg
	li $v0, 4
	syscall
	
	#add to score
	j scoringSystem
	return.scoringSystem:
	
	#Add time
	
	#These next lines of code replaces word in possible word list with a ********** string
	#this will be needed so that the user does not enter the same word twice for points
	#Also, this takes the word matched and stores it in a separate "words found" list
	#la $t2, gameDict #word matched ($t2)
	la $s3, filler_string
	lw $s6, ($s2)	#s6 used for swapping around
	sw $s6, ($s4)	#s4 holds the position of wordsFound
	sw $s3, ($s2)	#stores the filler string in place of the word in possible words list to prevent duplicate words entered
	addi $s4, $s4, 4 #increments to next position of wordsFound list
	
	jr $ra

wordsMismatch:
	#go to next word to check, if there is one
	#check if there is a next word
	#see if word tally == total words possible (lengthOfList)
	lw $t7, ($s3)	#load size of array for comparision ($s3 holds the address of lengthOfArray)
	beq $t7, $t8, reachedEndOfArray	#if the tally of words grabbed == total possible words
	#else, go to next word
	addi $t2, $t2, 4 #shift place in memory to point to next word in gameDict?
	la $t1, userInput	#reset address of user_input to point to first letter
	j checkInputMatchWordlist.loop
reachedEndOfArray:
	#no matches found
	#Display Error message, take next input?
	la $a0, error_msg
	li $v0, 4
	syscall
	
	#take input again
	j input
############################################################################################
#Lower Case Conversion
############################################################################################

makeLower:
	move $t0, $s0
makeLowerLoop:
	lb $t2, ($t0)
	beq $t2, 0, makeLowerReturn	#means end of string was reached
	beq $t2, 10, makeLowerReturn
	bge $t2, 'a', makeLowerIsLower	#means it's already lower case
	sub $t2, $t2, 'A'
	add $t2, $t2, 'a'
	sb $t2, ($t0)
makeLowerIsLower:
	add $t0, $t0, 1 #advance scanner
	j makeLowerLoop
makeLowerReturn:
	jr $ra	

############################################################################################
#Add to the score if successful match
scoringSystem:
sizeOfWord:
	#first find the size of the word to determine how many points are earned
	#search for the null terminator (0 or 10)
	la $s0, userInput	#could be the string in memory or input string. Doesnt matter. Should be a match & identical regardless
	move $t0, $0	#clear t0 for use
	move $t1, $0	#clear t1 for use (string size)
	move $t2, $0	#clear t2 for use (score storage)
	move $t3, $0	#clear t3 for use (score manip)
	li $t7, 10	#10 in ascii is newline
sizeOfWordLoop:
	lb $t0, ($s0)
	beqz $t0, endOfWordLoop	#0 (null) was reached, end
	beq $t0, $t7, endOfWordLoop	#10 (newline) was, end
	addi $s0, $s0, 1 	#else, check next place
	addi $t1, $t1, 1	#increase string size variable
	j sizeOfWordLoop
endOfWordLoop:
	#the word size (t1) is then added to the score
	j addScore
addScore:
	#Scoring system (multiply  word size by 10 t1 x 10 = score to add)
	la $s1, score	#load score from memory
	lw $t2, ($s1)	#put score in t2
	mulu $t3, $t1, $t7	#scoremanip(t3) = wordsize (t1) x 10 (t7 already has value of 10)
	add $t2, $t2, $t3	#score = score + scoremanip (adjusting score)
	sw $t2, ($s1)		#store new score in memory
	
displayNewScore:
	la $a0, score_newscore_msg
	li $v0, 4
	syscall	#prints your score message

	lw $a0, score
	li $v0, 1
	syscall	#prints score
	
	la $a0, nLine
	li $v0, 4
	syscall	#prints newline
	
	j return.scoringSystem


############################################################################################
#Check for options: $: shuffle, ?: time remaining, !: give up
option.shuffle:
	j shuffle	#jumps to shuffle.asm file to shuffle the order of the game letters in memory
	shuffle.return:
	j displayWordbox #display the new wordbox
	
#option.timeRemaining:
	#display time remaining somehow...
	#then take next input:
	j input		#take next input
option.reprintBox:
	j displayWordbox #jump to redisplay wordbox
	
option.giveup:

	#store num words correct in memory
	la $t0, numWordsCorrect
	sb $s7, ($t0)	#s7 holds total words correct in register. We are not putting in memory
	
	j gameOver.loser #jump to loser screen
	
############################################################################################

#exit:
#	li $v0, 10 #loads op code into $v0 to exit program
#	syscall #reads $v0 and exits program
