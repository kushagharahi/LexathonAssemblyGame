#Zachary Sarwar Computer Arch. Project
#wordBox

#.include "randomLetter.asm"

.data	
grid_squares: 						#grid seperators
	.asciiz " | "
	
boundaries: 						#top and bottom boundary
	.asciiz  " -------------\n"
	
new_row:						#creates a new row
	.asciiz    " |\n"

options_menu1:
	.asciiz	"\n\nCommands:\t"
	
options_menu2:
	.asciiz "Enter $ to shuffle the box, and & to reprint it.\n"
	
options_menu3:
	.asciiz "\t\tEnter ! to quit.\n\n"
	
	.text
wordbox:
	
	li $v0, 4
	la $a0, options_menu1
	syscall
	
	li $v0, 4
	la $a0, options_menu2
	syscall
	
	li $v0, 4
	la $a0, options_menu3
	syscall
	
	

	la      $s0, letterArray          # load adress of letters into $s0 so we can print
        move    $s1, $zero            # $s1 is the current row
        move    $s2, $zero            # $s2 is the current column
	
    				      # Print of grid first
	la      $a0, boundaries       # Load the address boundary into $a0 to print
        li      $v0, 4                # load print string syscall number into #$v0
        syscall                       #syscall command

	

print_grid:
	la      $a0, grid_squares      # Load adress of grid_squares into $a0
        li      $v0, 4                # Load syscall for print string into $v0
        syscall                       

   					
   					# Print the char in the current cell
	lb   $a0, ($s0)            	# Load the address of the number to print
        li      $v0, 11             	# Load print_int syscall number in $v0
        syscall                      	# syscall command

        addi    $s0, $s0, 1       	   # Point to the next grid cell
	addi    $s2, $s2, 4        	   # Increment the column counter by 4

        blt     $s2, 12, print_grid 	   # Iterate the loop until the row is completed, (12 for 3 grid squares)
    

    					
 	la      $a0, new_row          	#load adress for new row into $a0 
        li      $v0, 4                	# Load syscall for print string into $v0
        syscall                       	#syscall command

	move    $s2, $zero            # Reset the column counter
        addi    $s1, $s1, 4           # Increment the row counter by 4

   					 
    	blt     $s1,12, print_grid     # Restart the loop until the table is completed
    	
    	la $a0, boundaries
    	li      $v0, 4                # Load syscall for print string into $v0
	syscall                       # syscall command
	
	#end
	j return.wordbox


