# Inputs: $a0 - x cord, $a1, y cord, $a2 - chosen color, $a3 - length of line 
# Bit map configuration : unit width/height: 8, display width/heght: 512, base address: heap
# $s0 = counter for circles remaining
# $s1 - current number 
# $s2 - chosen index (both player and computer use this one at a time)
# $s3 - black hole index
# $v0 - memory address / player score
# $v1 - actual color value / computer score


#################################################
#  IMPORTANT: SET UP BITMAP TOOL                #
#  UNIT WIDTH IN PIXELS: 8                      #
#  UNIT HEIGHT IN PIXELS: 8                     #
#  DISPLAY WIDTH IN PIXELS: 512                 # 
#  DISPLAY HEIGHT IN PIXELS: 512                #
#  BASE ADDRESS FOR DISPLAY: 0X10040000 (HEAP)  #
#################################################

.data
 	ColorTable: 			  # Table to track colors (in hex code)
	 	.word 0xFFFFFF		  # [0] White 
	 	.word 0x000000		  # [1] Black
	 	.word 0x87D5FF		  # [2] Blue
	 	.word 0XE60E35		  # [3] Red
	displayAddress: .word 0x10040000 # Base display address (heap)
	
	
	# x coordinates of the center of circles on the board
	# Index 0 = top circle, index 20 = bottom right circle 
	xCircleCenters:	
		.word 31, 26, 36, 21, 31, 41, 16, 26, 36, 46, 11, 21, 31, 41, 51, 6, 16, 26, 36, 46, 56
	# y coordinates of the center of circles on the  
	yCircleCenters:	
		.word 7, 17, 17, 27, 27, 27, 37, 37, 37, 37, 47, 47, 47, 47, 47, 57, 57, 57, 57, 57, 57
	
	# The value each circle holds. Circles correlate to index
	# All circles begin as black holes until they are overriden during the game
	# 0 = black hole
	circleValues: 	
		.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	# What team a circle is
	# 0 = unclaimed, 1 = player, 2 = computer
	circleTeams:
		.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	
	# Stores the width of a layer the circle is on
	# Ex. Circle 0 is on layer 1 (width of 1). Circle 7 is on layer 4 (width 4)
	layerWidth:
		.word 1, 2, 2, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 6
	# Where a circle is positioned in the pyramid
	# 0 = top of pyramid, 1 = left, 2 = center, 3 = right, 4 = left corner, 5 = right corner, 6 = bottom
	pyramidPosition:
		.word 0, 1, 3, 1, 2, 3, 1, 2, 2, 3, 1, 2, 2, 2, 3, 4, 6, 6, 6, 6, 5
		
	prompt: .asciiz "Choose a circle (1-21, top to bottom, left to right): "
	
		
.text

j main				# Execute main before included files to correctly setup arguments

# main.asm contains functions for handling player/computer turn
.include "SysCalls.asm"		# Include this file in all programs
.include "Graphics.asm"		# Contains functions for managing graphics
.include "DrawFunctions.asm"	# Contains functions for hardcoded drawings (circle, numbers)
.include "HandleWinner.asm"	# Functions for logic of finding winner

main:
	# Board setup
	li $a2, 0		# Current color based on ColorTable (0, white)
	jal fillBackground	# Change background to chosen color
	
	li $a2, 1		# Set color to black 
	jal drawBoard		# Draw all circles to setup board
	
	# Initialize variables
	la $s0, 20		# Counter for how many circles remaining
	li $s1, 1		# Current number to be placed
	
	# Game logic
	gameLoop:
		li $a2, 2		# Set color to blue
		jal playerTurn		# Process player turn
		li $a2, 3		# Set color to red
		jal computerTurn 	# Process computer turn
		addi $s1, $s1, 1 	# Both players have taken their turn, move to next number
		addi $s0, $s0, -2 	# Reduce available circles by 2
		bnez $s0, gameLoop 	# If circles remain, game continues
		
	# End of game
	jal calculateScores		# Store player score in $v0, computer in $v1
	
	blt $v0, $v1, playerWin		# If player's score is less than computer's score, draw "You win" on the board
	li $a2, 3			# Set color to red
	jal drawPlayerLose		# If player loses, draw "You lose" on the board
	j finishGame			# Exit program
	
	playerWin:			# Draw "You win"
		li $a2, 2		# Set color to blue
		jal drawPlayerWinner	# Proc draw function
		j finishGame		# Exit program
	
	
	finishGame:			# Exit gracefully
		li $v0, SysExit
		syscall
	
# Player turn
# Prompt player what circle they want to place current number in, update relevant arrays, draw the current number in circle
# input - circleValues
# input - circleTeams
# input - $a2 - chosen color
# return - $s2 - chosen index
playerTurn:
	addi $sp, $sp, -8 	# Make room on stack
	sw $ra, 0($sp)		# Store original return address
	sw $v0, 4($sp)		# Store original $v0
	
	
	askPlayer:
		# Prompt user for circle choice
		li $v0, SysPrintString	# Load print string call
		la $a0, prompt		# Load prompt arguement
		syscall			# Execute
	
		# Save user choice
		li $v0, SysReadInt	# Load read int call
		syscall			# Execute 
		move $s2, $v0		# Save user choice in $s2
		addi $s2, $s2, -1	# Subtract by 1 to refrence correct index
		move $t1, $s2		# Copy value to $t1
	
		# Check if input is valid
		blt $s2, $zero, askPlayer	# If index < 0, repeat prompt
		li $t0, 20			# Set comparison
		bgt $s2, $t0, askPlayer		# If index > 20, repeat prompt
		
		la $t0, circleValues		# Load circleValues to check if circle is already occupied
		sll $t1, $t1, 2			# Multiply user choice by 4 to get address offset
		add $t0, $t0, $t1		# Add address offset
		lw $t3, 0($t0)			# load circleValues[input] into $t3
		beqz $t3, continueSaving	# Continue to save value if value is 0 (empty circle)
		j askPlayer			# Repeat prompt if circle not empty

	
	# If input valid, continue saving/updating values
	continueSaving:
		# Update value array
		sw $s1 0($t0)		# Store current number in circle
	
		# Update team array
		li $t2, 1		# Load team value (1 = player)
		la $t0 circleTeams	# Load circle teams address
		add $t0, $t0, $t1	# Add address offset  
		sw $t2, 0($t0)		# Store team value
	
		# Draw current number at chosen circle
		jal drawNumberOnCircle	
		
	lw $ra 0($sp)		# Restore return address
	lw $v0 4($sp)		# Restore original $v0
	addi $sp, $sp, 8	# Free memory
	jr $ra			# Return to caller
	
# Computer turn
# Choose a random unoccupied circle to place current number, update relevant arrays, draw current number
# input - circleValues
# input - circleTeams
# input - $a2 - chosen color
# return - $s2 - chosen index
computerTurn:
	addi $sp, $sp -16	# Make room on stack
	sw $ra, 0($sp)		# Store original return address
	sw $a0, 4($sp)		# Store original x coordinate
	sw $a1, 8($sp)		# Store original y coordinate
	sw $v0, 12($sp)		# Store original $v0
		
	# Choose a random circle
	la $v0, SysRandIntRange	# Load random integer range service
	li $a1, 21		# Set range from 0 - 20
	
	# Check if circle is occupied
	whileCircleOccupied:
		syscall			# Get circle index
		la $t0, circleValues	# Load circle values address
		sll $t3, $a0, 2		# Multiply index by 4 to get offset
		add $t0, $t0, $t3	# Add offset
		lw $t4 0($t0)		# $t4 = circleValues[chosen index]
		bnez $t4, whileCircleOccupied # If circle occupied (value != 0), choose new index
		move $s2, $a0		# Save index in $s2
		
	
	# Update value array using already edited memory address
	sw $s1, 0($t0)		# Store current number in circle
	
	# Update team array
	li $t2 2		# Load team (2 = computer)
	la $t0 circleTeams	# Load circle teams address
	add $t0, $t0, $t3	# Add previously calculated address offset
	sw $t2, 0($t0)		# Store team value
	
	# Draw current number at chosen circle
	jal drawNumberOnCircle	
	
	lw $ra, 0($sp)		# Restore original return address
	lw $a0, 4($sp)		# Restore original x coordinate
	lw $a1, 8($sp)		# Restore original y coordinate
	lw $v0, 12($sp)		# Restore original $v0
	addi $sp, $sp, 16	# Free stack memory
	jr $ra			# Return to caller



	
