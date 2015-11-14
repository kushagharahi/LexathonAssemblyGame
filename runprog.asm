.include "macros.asm"
.include "importing.asm"
.include "randomLetter.asm"
.include "shuffle.asm"
.include "testlib.asm"
.include "newGame.asm"
.include "wordbox.asm"
.include "resetRegisters.asm"
.include "input.asm"
.include "Instructions.asm"


.data
wordsFound:
	.align 2
	.space 50000
dictionary:
	.space 500000
dictionaryArray:
	.align	2
	.space 368000
gameDict:
	.align 2
	.space 50000
gameArray:
	.align  2
	.space 2000
lengthOfList:
	.word 0
wordInBox:
	.align	0
	.space 10
correctWordsPointerArray:
	.align	2
	.space 10000
totalPossibleWords:
	.word 0
filename:
	.asciiz "wordbank.txt"
	
dummyString:	#holds 9 random letters
	.asciiz "abandoned"
compare:
	.asciiz "00000000000000000000000000"
library:
	.asciiz "00000000000000000000000000"
.text
.globl main

main:

j importFile		#fills the string dictionary with the word file.
importReturn:

j fillDictionaryArray	#fills the pointers in this array
arrayReturn:

j printInstructions	#prints opening message
instructionsReturn:

j newGame
return.newGame:
	
	
exit:
	li $v0, 10
	syscall
