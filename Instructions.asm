#Code for main menu of the Lexathon game

.data
border: "*****************************************"
mainMenu.title: .asciiz "\n*\tWelcome to Lexathon\t\t*\n" 
mainMenu.option0: .asciiz "\n*\tPress 0 to begin game\t\t*\n"
mainMenu.option1: .asciiz "*\tPress 1 to see instructions\t*\n"
gamePrompt: .asciiz "\n\nLOADING GAME. PLEASE WAIT.\n"
error:   .asciiz "Please enter either a 0 or 1\n"
user.input: .asciiz "\nInput: "
instructionList: .asciiz  "\nLexathon is a free 9 letter word jumble puzzle game. From a block of 9 letters, find as many English words as possible of \n4 or more letters that contain a central letter. There is always a 9 letter word to find amongst the scrambled letters.\nFor every correct word, the user is rewarded 10 points per letter. Good luck! \n\n"
menuReturn: .asciiz "Press 0 to begin game, press 1 to return to main menu\n\n"

.text
printInstructions:
li $t1, 0                 #prints the main menu
li $t2, 1

#The next few chunks of code formats the menu screen
li $v0, 4
la $a0, border
syscall

li $v0, 4
la $a0, mainMenu.title
syscall

li $v0, 4
la $a0, border
syscall

li $v0, 4
la $a0, mainMenu.option0
syscall

li $v0, 4
la $a0, mainMenu.option1
syscall

li $v0, 4
la $a0, border
syscall
#End of formatting menu

li $v0, 4
la $a0, user.input
syscall

li $v0, 5                 #stores user input
syscall

add $t0, $0, $v0                  
beq $t0, $t1, startGame           #compares user input
beq $t0, $t2, instructionSet
bgt $t0, $t2, errorMessage
bltz $t0, errorMessage

instructionSet:                   #prints the instruction set
li $v0, 4
la $a0, instructionList
syscall

jal goBack

startGame:                        #prompts the user that the game will begin
li $v0, 4
la $a0, gamePrompt
syscall
j endloop

errorMessage:                     #Tells user that either a 1 or 0 must be entered
li $v0, 4
la $a0, error
syscall
j printInstructions

goBack:                            #Tells user to either begin the game or return to the menu
li $t1, 0
li $t2, 1
li $v0, 4
la $a0, menuReturn
syscall

li $v0, 4
la $a0, user.input
syscall

li $v0, 5
syscall

add $t0, $0, $v0                        
beq $t0, $t1, startGame            #Compares the user input to see if correct key was pressed
beq $t0, $t2, main
bgt $t0, $t2, instructionError
bltz $t0, instructionError

instructionError:                  #Tells user that the incorrect key was pressed
li $v0, 4
la $a0, error
syscall
jal goBack

endloop:                           #Exits the program
j instructionsReturn
