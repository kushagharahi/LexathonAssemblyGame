#temp game lib builder
testLibManip:
	la $s0, letterArray	#loading string of 9 letters
	la $s7, compare		#loading string for letter count
	li $t9, 0		#initalizing correct word counter
	la $t3, gameDict	#loading game dictionary array

	compareWordLoop:
		lb $s1, ($s0)			#loading byte from 9 letters
		beq $s1, 'a', increasea		#if a
		beq $s1, 'b', increaseb		#if b
		beq $s1, 'c', increasec		#if c
		beq $s1, 'd', increased		#if d
		beq $s1, 'e', increasee		#if e
		beq $s1, 'f', increasef		#if f
		beq $s1, 'g', increaseg		#if g
		beq $s1, 'h', increaseh		#if h
		beq $s1, 'i', increasei		#if i
		beq $s1, 'j', increasej		#if j
		beq $s1, 'k', increasek		#if k
		beq $s1, 'l', increasel		#if l
		beq $s1, 'm', increasem		#if m
		beq $s1, 'n', increasen		#if n
		beq $s1, 'o', increaseo		#if o
		beq $s1, 'p', increasep		#if p
		beq $s1, 'q', increaseq		#if q
		beq $s1, 'r', increaser		#if r
		beq $s1, 's', increases		#if s
		beq $s1, 't', increaset		#if t
		beq $s1, 'u', increaseu		#if u
		beq $s1, 'v', increasev		#if v
		beq $s1, 'w', increasew		#if w
		beq $s1, 'x', increasex		#if x
		beq $s1, 'y', increasey		#if y
		beq $s1, 'z', increasez		#if z
		blt $s1, 'a', next		#if NAL
		bgt $s1, 'z', next		#if NAL
	j compareWordLoop			#redundancy

#############################################################################################################################################################
#############################################################################################################################################################

	next:					#begin library word
		xor $t1, $t1, $t1		#resetting register, just in case
		li $t1, 0			#storing 0
		la $t0, dictionaryArray		#loading full dictionary
		la $s7, library			#loading string for letter count
		get_WordArray ($s0, $t0, $t1)	#loading from library in $t0, the $s0'th entry, into $s6
		addi $s5, $s0, 0
		
	libLoop:				#loop for building letter count for library word
		lb $s1, ($s0)			#loading letter from word from dictionary
		beq $s1, 'a', increasea2	#if a
		beq $s1, 'b', increaseb2	#if b
		beq $s1, 'c', increasec2	#if c
		beq $s1, 'd', increased2	#if d
		beq $s1, 'e', increasee2	#if e
		beq $s1, 'f', increasef2	#if f
		beq $s1, 'g', increaseg2	#if g
		beq $s1, 'h', increaseh2	#if h
		beq $s1, 'i', increasei2	#if i
		beq $s1, 'j', increasej2	#if j
		beq $s1, 'k', increasek2	#if k
		beq $s1, 'l', increasel2	#if l
		beq $s1, 'm', increasem2	#if m
		beq $s1, 'n', increasen2	#if n
		beq $s1, 'o', increaseo2	#if o
		beq $s1, 'p', increasep2	#if p
		beq $s1, 'q', increaseq2	#if q
		beq $s1, 'r', increaser2	#if r
		beq $s1, 's', increases2	#if s
		beq $s1, 't', increaset2	#if t
		beq $s1, 'u', increaseu2	#if u
		beq $s1, 'v', increasev2	#if v
		beq $s1, 'w', increasew2	#if w
		beq $s1, 'x', increasex2	#if x
		beq $s1, 'y', increasey2	#if y
		beq $s1, 'z', increasez2	#if y
		blt $s1, 'a', compareW		#if NAL
		bgt $s1, 'z', compareW		#if NAL
	j libLoop				#redundancy

increasea:			#increase a from 9 letter string loop
	lb $s6, 0($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 0($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j compareWordLoop		#return to letter count loop

increaseb:			#increase b from 9 letter string loop
	lb $s6, 1($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 1($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j compareWordLoop		#return to letter count loop

increasec:			#increase c from 9 letter string loop
	lb $s6, 2($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 2($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j compareWordLoop		#return to letter count loop

increased:			#increase d from 9 letter string loop
	lb $s6, 3($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 3($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j compareWordLoop		#return to letter count loop

increasee:			#increase e from 9 letter string loop
	lb $s6, 4($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 4($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j compareWordLoop		#return to letter count loop

increasef:			#increase f from 9 letter string loop
	lb $s6, 5($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 5($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j compareWordLoop		#return to letter count loop

increaseg:			#increase g from 9 letter string loop
	lb $s6, 6($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 6($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j compareWordLoop		#return to letter count loop

increaseh:			#increase h from 9 letter string loop
	lb $s6, 7($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 7($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j compareWordLoop		#return to letter count loop

increasei:			#increase i from 9 letter string loop
	lb $s6, 8($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 8($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j compareWordLoop		#return to letter count loop

increasej:			#increase j from 9 letter string loop
	lb $s6, 9($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 9($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j compareWordLoop		#return to letter count loop

increasek:			#increase k from 9 letter string loop
	lb $s6, 10($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 10($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j compareWordLoop		#return to letter count loop

increasel:			#increase l from 9 letter string loop
	lb $s6, 11($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 11($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j compareWordLoop		#return to letter count loop

increasem:			#increase m from 9 letter string loop
	lb $s6, 12($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 12($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j compareWordLoop		#return to letter count loop

increasen:			#increase n from 9 letter string loop
	lb $s6, 13($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 13($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j compareWordLoop		#return to letter count loop

increaseo:			#increase o from 9 letter string loop
	lb $s6, 14($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 14($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j compareWordLoop		#return to letter count loop

increasep:			#increase p from 9 letter string loop
	lb $s6, 15($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 15($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j compareWordLoop		#return to letter count loop

increaseq:			#increase q from 9 letter string loop
	lb $s6, 16($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 16($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j compareWordLoop		#return to letter count loop

increaser:			#increase r from 9 letter string loop
	lb $s6, 17($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 17($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j compareWordLoop		#return to letter count loop

increases:			#increase s from 9 letter string loop
	lb $s6, 18($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 18($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j compareWordLoop		#return to letter count loop

increaset:			#increase t from 9 letter string loop
	lb $s6, 19($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 19($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j compareWordLoop		#return to letter count loop

increaseu:			#increase u from 9 letter string loop
	lb $s6, 20($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 20($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j compareWordLoop		#return to letter count loop

increasev:			#increase v from 9 letter string loop
	lb $s6, 21($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 21($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j compareWordLoop		#return to letter count loop

increasew:			#increase w from 9 letter string loop
	lb $s6, 22($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 22($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j compareWordLoop		#return to letter count loop

increasex:			#increase x from 9 letter string loop
	lb $s6, 23($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 23($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j compareWordLoop		#return to letter count loop

increasey:			#increase y from 9 letter string loop
	lb $s6, 24($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 24($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j compareWordLoop		#return to letter count loop

increasez:			#increase z from 9 letter string loop
	lb $s6, 25($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 25($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j compareWordLoop		#return to letter count loop

#############################################################################################################################################################
#############################################################################################################################################################

compareW:			#compare two letter counters
	la $s2, compare		#load counter from 9 letter string
	la $s1, library		#load counter from library word
	lb $t0, ($s2)		#load letter count from 9 letter
	lb $t2, ($s1)		#load letter count from library letter
	li $t4, 0
compareLoop:			#loop to compare letters
	bge $t0, $t2, nextL	#next letter if check passes
	blt $t0, $t2, resetLibrary
j resetLibrary			#else move on to next word
	
nextW:
	addi $t1, $t1, 1
	la $t0, dictionaryArray		#loading full dictionary
	get_WordArray ($s0, $t0, $t1)	#loading from library in $t0, the $s0'th entry, into $s6
	xor $s5, $s5, $s5
	addi $s5, $s0, 0
	blt $s0, 97, printCorrect	#if NAL was loaded from the library, return to the main
	
j libLoop

nextL:				#return the next letter in compare loop
	addi $s1, $s1, 1	#increase string buffer in 9 letter counter
	addi $s2, $s2, 1	#increase string buffer in library loop counter
	addi $t4, $t4, 1	#increment loop counter
	lb $t0, ($s2)		#load letter count from 9 letter
	lb $t2, ($s1)		#load letter count from library letter
	ble $t4, 26, compareLoop#if loop counter less than 26, continue loop
j finalCheck			#word is correct

finalCheck:			#compare two letter counters
	la $t0, dictionaryArray		#loading full dictionary
	get_WordArray ($s0, $t0, $t1)	#loading from library in $t0, the $s0'th entry, into $s6
	la $s1, letterArray		#loading string
	lb $t2, 4($s1)		#loading central letter for comparison
	lb $t0, ($s0)		#load letters from dictionary word letter
checkLoop:			#loop to compare letters
	beq $t0, $t2, correct	#next letter if check passes
	bge $t0, 97, nextLF	#else move on to next letter
j resetLibrary			#redundancy4

nextLF:
	addi $t4, $t4, 1
	addi $s0, $s0, 1	#increase string buffer in library loop counter
	lb $t0, ($s0)		#load letter count from 9 letter
	beqz $s0, resetLibrary	#if loop counter less than 26, continue loop
j checkLoop

correct:
	sw $s5, ($t3)		#storing correct word into game library
	
	addi $t3, $t3, 4
	addi $t9, $t9, 1
j resetLibrary

resetLibrary:
	la $t0, library		#loading library letter counter
	li $t2, 48		#loading '0'
	li $t4, 0		#setting letter counter
resetLoop:			#looping to reset library letter count
	sb $t2, ($t0)		#storing '0', overriding current value
	addi $t0, $t0, 1	#increasing string buffer to next value
	addi $t4, $t4, 1
	ble $t4, 25, resetLoop
j nextW

printCorrect:
	la $s0, lengthOfList
	sw $t9, ($s0)
j testManipReturn

#############################################################################################################################################################
#############################################################################################################################################################

increasea2:			#increase a from library word loop
	lb $s6, 0($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 0($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j libLoop			#return to library count loop

increaseb2:			#increase b from library word loop
	lb $s6, 1($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 1($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j libLoop			#return to library count loop

increasec2:			#increase c from library word loop
	lb $s6, 2($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 2($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j libLoop			#return to library count loop

increased2:			#increase d from library word loop
	lb $s6, 3($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 3($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j libLoop			#return to library count loop

increasee2:			#increase e from library word loop
	lb $s6, 4($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 4($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j libLoop			#return to library count loop

increasef2:			#increase f from library word loop
	lb $s6, 5($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 5($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j libLoop			#return to library count loop

increaseg2:			#increase g from library word loop
	lb $s6, 6($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 6($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j libLoop			#return to library count loop

increaseh2:			#increase h from library word loop
	lb $s6, 7($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 7($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j libLoop			#return to library count loop

increasei2:			#increase i from library word loop
	lb $s6, 8($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 8($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j libLoop			#return to library count loop

increasej2:			#increase j from library word loop
	lb $s6, 9($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 9($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j libLoop			#return to library count loop

increasek2:			#increase k from library word loop
	lb $s6, 10($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 10($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j libLoop			#return to library count loop

increasel2:			#increase l from library word loop
	lb $s6, 11($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 11($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j libLoop			#return to library count loop

increasem2:			#increase m from library word loop
	lb $s6, 12($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 12($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j libLoop			#return to library count loop

increasen2:			#increase n from library word loop
	lb $s6, 13($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 13($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j libLoop			#return to library count loop

increaseo2:			#increase o from library word loop
	lb $s6, 14($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 14($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j libLoop			#return to library count loop

increasep2:			#increase p from library word loop
	lb $s6, 15($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 15($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j libLoop			#return to library count loop

increaseq2:			#increase s from library word loop
	lb $s6, 16($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 16($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j libLoop			#return to library count loop

increaser2:			#increase r from library word loop
	lb $s6, 17($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 17($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j libLoop			#return to library count loop

increases2:			#increase s from library word loop
	lb $s6, 18($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 18($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j libLoop			#return to library count loop

increaset2:			#increase t from library word loop
	lb $s6, 19($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 19($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j libLoop			#return to library count loop

increaseu2:			#increase u from library word loop
	lb $s6, 20($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 20($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j libLoop			#return to library count loop

increasev2:			#increase v from library word loop
	lb $s6, 21($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 21($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j libLoop			#return to library count loop

increasew2:			#increase w from library word loop
	lb $s6, 22($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 22($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j libLoop			#return to library count loop

increasex2:			#increase x from library word loop
	lb $s6, 23($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 23($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j libLoop			#return to library count loop

increasey2:			#increase y from library word loop
	lb $s6, 24($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 24($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j libLoop			#return to library count loop

increasez2:			#increase z from library word loop
	lb $s6, 25($s7)		#loading what's there
	addi $s6, $s6, 1	#increase it
	sb $s6, 25($s7)		#store it
	addi $s0, $s0, 1	#increase string buffer to compare next byte
j libLoop			#return to library count loop
