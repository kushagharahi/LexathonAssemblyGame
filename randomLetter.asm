.data
letterArray:	.space 10
vowels:	.byte 97, 101, 105, 111, 117, 0
consonants: .byte 98, 99, 100, 102, 103, 104, 106, 107, 108, 109, 110, 112, 113, 114, 115, 116, 118, 119, 120, 121, 122, 0
commonConsonants: .byte 116, 110, 115, 104, 114, 0 #Common consonants: t, n, s, h, r
uncommonConsonants: .byte 107, 106, 120, 113, 122, 0 #Uncommon consonants: k, j, x, q, z
.text
#.globl main

startRandom:
	la $s1, letterArray	#save address of array in memory to s1
	la $s2, letterArray
				#Removed this from loop to only do it once. Will add to s1 in the loop for position
	jal randomizeLetter
	
	la $s2, letterArray	#load address of array to s2
	jal checkLetters	#see if the array needs to be adjusted based on number of vowels & consonants
	
exit.random:
	#li $v0, 4
	#la $a0, letterArray
	#syscall

	#li $v0, 10
	#syscall
	
	j return.startRandom

############################################################################################

randomizeLetter:

	li $v0, 42	#randomize
	li $a1, 26	#cap 26 for letters 26 because exclusive. would get 25, but not 26. 25 = Z
	syscall
	
	move $t0, $a0	#store random value in t0
	addi $t0, $t0, 97	#add 97 to int value for lowercase ASCII value
	
	#Debug: Print out value of random letter
	#sw $t0, ($a0)
	#li $v0, 4
     	#syscall

	#Check if empty. If empty, store letter
	lb $t1, ($s2)		#load first byte position from letterArray to t1.
	beqz $t1, store.letter 	#stores letter if array is already empty.
	
store.letter:
	#sb $t0, $t3($s1)	#I essentially want to add to the array depending on the position. like array[i], t3 being i
	sb $t0, ($s1)
	addi $s1, $s1, 1 	#increase t3 by 1. t3 will hold the counter/tally for position in array
	
	la $s2, letterArray	#only need to fill array with 9 letters. store address of letterArray in s2 to test
	lb $t2, 8($s2)		#load value of the 9th position of letterArray in t2
	beqz $t2, randomizeLetter	#if the 9th letter is null, then add another letter, branch to beginning of loop
	
	jr $ra			#else, means the array has 9 letters. go back to main
	
############################################################################################
#Functions to check letters types in array & adjusts if necessary

checkLetters:
	#check number of vowels & consonants
	
	lb $t0, ($s2)
	jal checkType	#marks if vowel or consonant
	addi $s2, $s2, 1 #increase to next of array
	
	lb $t0, ($s2)
	beqz $t0, adjustArray 	#if at the end of the array, branch to the next step, which involves adjusting letters in array
	
	#reset count of vowels & consonants
	#move $s6, $0
	#move $s7, $0
	j checkLetters		#else check next letter

checkType:
	#will be a vowel if value is 97, 101, 105, 111, 117 (aeiou)
	li $t7, 97
	beq $t0, $t7, isVowel
	li $t7, 101
	beq $t0, $t7, isVowel
	li $t7, 105
	beq $t0, $t7, isVowel
	li $t7, 111
	beq $t0, $t7, isVowel
	li $t7, 117
	beq $t0, $t7, isVowel
	
	#else, is consonant
	addi $s7, $s7, 1	#adds 1 to s7 since consonant. s7 has the count of consonants. 
	jr $ra
isVowel:
	addi $s6, $s6, 1	#adds 1 to s6 since vowel. s6 has vowel count.
	jr $ra
############################################################################################

adjustArray:	#adjusting array just sees the count of vowels and consonants. If there are too many vowels or too few
		#then replace with consonants, if necessary
		
		#functions below always jumps back to adjustArray to check again if it's necessary to adjust the array
		#after updating the count of vowels and consonants until list is completely balanced
	
	#Remember that...
	#s7 holds consonant count, s6 vowel count
	li $t7, 5
	bge $s7, $t7, checkLessThan7 #if consonant count >= 5, then need to check if less than 7. Need at least 3 vowels in array list
	
	#else: means too many vowels
	la $s2, letterArray
	la $s3, consonants
	j replaceConsonantWithVowel

replaceConsonantWithVowel:
	#find a vowel in list
	
	jal randomInArray	#get random letter in array to replace, after testing
	add $s2, $s2, $t5
	
	lb $t0, ($s2)
	
	#will be a vowel if value is 97, 101, 105, 111, 117 (aeiou)
	li $t7, 97
	beq $t0, $t7, replaceWithConsonant
	li $t7, 101
	beq $t0, $t7, replaceWithConsonant
	li $t7, 105
	beq $t0, $t7, replaceWithConsonant
	li $t7, 111
	beq $t0, $t7, replaceWithConsonant
	li $t7, 117
	beq $t0, $t7, replaceWithConsonant
	
	#else: means that letter wasn't vowel. check next
	#addi $s2, $s2, 1	#increase position of array (s2) by 1
	
	#by random:
	sub $s2, $s2, $t5	#subtract by random int position of letter array, to normalize position to beginning
	j replaceConsonantWithVowel	#to try again
	
replaceWithConsonant:
	#randomize for consonant
	li $v0, 42
	li $a1, 22	#cap at 22. So last possible is 21. (0-21 possible)
	syscall
	
	#add consonant in place
	add $s3, $a0, $s3 #add random number with the current place in consonant array. will determine which consonant picked
	lb $t7, ($s3)	#load that consonant in t7
	sb $t7, ($s2)	#store that consonant the place of the vowel
	
	#subtract 1 from vowel count, add to consonant count
	addi $s6, $s6, -1
	addi $s7, $s7, 1
	
	j adjustArray
	
checkLessThan7:
	li $t7, 7
	blt $s7, $t7, listComplete #if consonant count < 7, then it is in the ideal range of 5-6 consonants
	
	#else: too many consonants, replace a consonant with vowel
	la $s2, letterArray
	la $s3, vowels #loads address of consonant array into s3
	
	#check for consonant to replace
	lb $t0, ($s2)	#load first bytes from letter array and consonant array (to check)
	lb $t6, ($s3)
loop.consonantCheck: # ^^^^^ Flows from above ^^^^^
	
	jal randomInArray #t5 holds random place (add to place in mem for position)
	add $s2, $s2, $t5
	lb $t0, ($s2)	#put byte of new random position from array(s2) to t0
	
	li $t7, 97
	beq $t0, $t7, restart.loop.consonantCheck	#means that letter is a vowel, so find a different random letter: looking for consonant
	li $t7, 101
	beq $t0, $t7, restart.loop.consonantCheck
	li $t7, 105
	beq $t0, $t7, restart.loop.consonantCheck
	li $t7, 111
	beq $t0, $t7, restart.loop.consonantCheck
	li $t7, 117
	beq $t0, $t7, restart.loop.consonantCheck
	
	#was consonant if passed those checks
	j replaceWithVowel
	
restart.loop.consonantCheck:
	sub $s2, $s2, $t5	#reset position to beginning of array, "taking back" t5
	j loop.consonantCheck	#go to beginning of loop

replaceWithVowel:	#end goal is to get here to break the loops
	#replace the current consonant in position of s2 with a random vowel
	
	li $v0, 42	#syscall for random int with range
	li $a1, 5	#cap at 5. So last possible is 4. (0-4 possible)
	syscall
	
	la $t6, vowels
	add $t6, $t6, $a0	#add random position with place in memory to get which vowel will be added.
	lb $t0, ($t6)		#takes byte from vowel array and puts it into t0.
	sb $t0, ($s2)		#replaces the position of letter Array (s2) with the random vowel
	
	#add 1 to vowel count, subtract to consonant count
	addi $s6, $s6, 1
	addi $s7, $s7, -1
	
	j adjustArray
		
listComplete:
	la $s1, letterArray
	j countUncommons	#jumps to countUncommons. List is complete
############################################################################################

randomInArray:	#gets a random position in letter array

	li $v0, 42	#syscall for random int with range
	li $a1, 9	#cap at 9. So last possible is 8. (0-8 possible)
	syscall
	
	move $t5, $a0
	
	jr $ra
	
############################################################################################
#Making the list better by replacing least common letters with more common ones
#Goal:	Only have one uncommon letter.

#Specifically consonants
#Common consonants: t, n, s, h, r
#Uncommon consonants: k, j, x, q, z

#First, see how many uncommons are in the list by looping through the letters
#tally based on which letters are there. = totalUncommons
#If already only one, FINISH. END. You're done! :)

countUncommons:
	#s1 holds address of array, will store in t0. $t7 will hold tally
	move $t7, $0
	move $t0, $s1
	la $t1, uncommonConsonants
	li $t6, 10	#for comparison reasons
	
countUncommons.letterloop:
	lb $t2, ($t0) #get letter to check in t2
	beqz $t2, countUncommons.endloop	#will equal ' ', so end of array
	beq $t2, $t6, countUncommons.endloop	#will equal \n, so end of array
countUncommons.ucloop:
	lb $t3, ($t1) #get uncommon consonant to compare with
	beqz $t3, countUncommons.nextletter	#will equal '\0', so end of array
	beq $t3, $t6, countUncommons.nextletter	#will equal \n, so end of array
	beq $t2, $t3, uncommonMatch
	#else: no match
	addi $t1, $t1, 1	#advance to next uncommon consonant to compare with
	j countUncommons.ucloop 
countUncommons.nextletter:
	addi $t0, $t0, 1	#go to next letter of array to check
	la $t1, uncommonConsonants #reset the uncommonConsonants array to be pointing at the beginning position
	j countUncommons.letterloop
countUncommons.endloop:
	#if there are no uncommons, leave
	beqz $t7, exit.Uncommons
	la $t0, letterArray		#reset position to beginning of array
	la $t1, uncommonConsonants	#reset position to beginning of array
	j swapUncommons
	
uncommonMatch:
	addi $t7, $t7, 1	#incrememt count of uncommon letters
	addi $t0, $t0, 1	#go to next letter of array to check
	j countUncommons.letterloop
	
swapUncommons:
#LOOP:
	la $t0, letterArray
	li $t6, 1 #to know when to stop , only one uncommon in list
	beqz $t7, exit.Uncommons
	beq $t7, $t6, exit.Uncommons #means that there's one uncommon letter in list, so exit
	
	jal randomInArray #$t5 will have random place in letter array
	add $t0, $t0, $t5	#adjust position in array to random place
	 
	#check if uncommon
	lb $t2, ($t0)	#put the consonant we are checking in $t2
	li $t4, 107
	beq $t2, $t4, swap	#is uncommon, so swap
	li $t4, 106
	beq $t2, $t4, swap	#is uncommon, so swap
	li $t4, 120
	beq $t2, $t4, swap	#is uncommon, so swap
	li $t4, 113
	beq $t2, $t4, swap	#is uncommon, so swap
	li $t4, 122
	beq $t2, $t4, swap	#is uncommon, so swap
	
	#else, wasn't uncommon
	sub $t0, $t0, $t5	#take away the random position in array. Resets to beginning
	j swapUncommons
	
swap:
	la $s4, commonConsonants
	
	li $v0, 42	#syscall for random int with range
	li $a1, 5	#cap at 6. So last possible is 4. (0-4 possible)
	syscall
	move $t5, $a0
	
	add $s4, $s4, $t5 #adjust to random position of commonConsonants array
	lb $t3, ($s4)	#put common consonant into $t3
	sb $t3, ($t0)	#store into the place of letter array that we were swapping
	
	addi $t7, $t7, -1	#decrement the uncommmon count
	j swapUncommons

exit.Uncommons:
	j exit.random	#exit
