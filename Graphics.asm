# Inputs: $a0 - x cord, $a1, y cord, $a2 - chosen color, $a3 - length of line
# Bit map configuration : unit width/height: 8, display width/heght: 512, base address: heap
		
# Calculate Address
# Converts an (x, y) coordinate to a memory address
# input - $a0 - x coordinate (0-63)
# input - $a1 - y coordinate (0-63)
# return - $v0 - memory address
calculateAddress:
	la $v0, displayAddress	# Load pointer address to "displayAddress"
	lw $v0, 0($v0)		# Load pointer value of "displayAddress" (0x10040000)
	
	# Memory address = base display address + 4x + (4y * 64)
	sll $t2, $a0, 2 	# $t2 = x * 4
	sll $t3, $a1, 8		# t3 = y * 256 = 4y * 64
	add $v0, $v0, $t2 	# Add x offset to base address
	add $v0, $v0, $t3	# Add y offset to base address
	
	jr $ra			# Return to caller

# Get color
# Gets color based on index from ColorTable
# input - $a2 - color index
# return - $v1 - actual color value	
getColor:
	addi $sp, $sp, -4 	# Make room on stack
	sw $a2, 0($sp)		# Store original $a2 value on stack
	
	la $t0, ColorTable	# load ColorTable address
	sll $a2, $a2, 2 	# Multiply $a2 by 4 to get memory address offset
	add $t0, $t0, $a2	# Add offset to ColorTable address
	lw $v1 0($t0)		# Load color value into $v1
	
	lw $a2, 0($sp)		# Restore original $a2 value
	addi $sp, $sp, 4	# Free stack memory
	
	jr $ra			# Jump back to caller
	
# Draw pixel
# Draws a pixel given (x,y) coordinates
# input - $a0 - x coordinate (0-63)
# input - $a1 - y coordinate (0-63)
# input - $a2 - color index
# return - none
drawPixel:
	addi $sp, $sp, -4	# Make room on stack
	sw $ra, 0($sp)		# Store original return address on stack
	
	jal calculateAddress	# Calculate memory address to manipulate
	jal getColor		# Get chosen color's hex value
	sw $v1 0($v0)		# Draw the colored pixel at given address
	
	lw $ra, 0($sp)		# Restore original return address
	addi $sp, $sp, 4	# Free stack memory
	
	jr $ra			# Return to caller

# Draw horizontal line
# Draws a horizontal line left to right given starting (x,y) coords
# input - $a0 - x coordinate (0-63)
# input - $a1 - y coordinate (0-63)
# input - $a2 - color index
# input - $a3 - length of line (1-64)
# return - none
drawHorizontalLine:
	addi $sp, $sp, -12 	# Make space in stack
	sw $ra 0($sp)		# Store original return address
	sw $a0 4($sp)		# Store original $a0
	sw $a3 8($sp)		# Store original $a3
	
	# Loop (line length) # of times and draw next pixel
	horizontalLineLoop:
		jal drawPixel			# Draw pixel at current position
		addi $a3, $a3, -1		# Reduce counter by 1
		addi $a0, $a0, 1		# Move to next x pixel
		bnez $a3, horizontalLineLoop 	# Loop again if not done drawing line
		
	lw $ra 0($sp)		# Restore return address
	lw $a0 4($sp)		# Restore $a0
	lw $a3 8($sp)		# Retore $a3
	addi $sp, $sp, 12	# Free stack memory
	jr $ra			# Return to caller
		
# Draw vertical line
# Draws a vertical line top to bottom given starting (x,y) coords
# input - $a0 - x coordinate (0-63)
# input - $a1 - y coordinate (0-63)
# input - $a2 - color index
# input - $a3 - length of line (1-64)
# return - none
drawVerticalLine:
	addi $sp, $sp, -12 	# Make space in stack
	sw $ra 0($sp)		# Store original return address
	sw $a1 4($sp)		# Store original $a1
	sw $a3 8($sp)		# Store original $a3
	
	# Loop (line length) # of times and draw next pixel
	verticalLineLoop:
		jal drawPixel			# Draw pixel at current position
		addi $a3, $a3, -1		# Reduce counter by 1
		addi $a1, $a1, 1		# Move to next y pixel
		bnez $a3, verticalLineLoop 	# Loop again if not done drawing line
		
	lw $ra 0($sp)		# Restore return address
	lw $a1 4($sp)		# Restore $a0
	lw $a3 8($sp)		# Retore $a3
	addi $sp, $sp, 12	# Free stack memory
	jr $ra			# Return to caller	
	


# Fill background
# Fills the background of the bitmap with a specified color
# input - $a2 - color index
# return - none
fillBackground:
	addi $sp, $sp, -12	# Make room in stack
	sw $ra, 0($sp)		# Store original return address in stack
	sw $a0, 4($sp)		# Store original x coord in stack
	sw $a1, 8($sp)		# Store original y coord in stack
	
	li $a1, 0 		# y = 0 to start from first row
	
	# Loop through and color all pixels
	outerLoop1:
		# Outer loop body
		bgt $a1, 63, exitLoop1		# If y > 63, exit loop because finished iterating through bitmap
		li $a0, 0			# x = 0 to start from beginning of row
		
		innerLoop1:
			# Inner loop body
			jal drawPixel			# Draw pixel at current index
			addi $a0, $a0, 1		# Increment x coordinate by 1
			
			bgt $a0, 63, incrementY		# If x > 63, means end of row reached. Move to next row by incrementing y
			j innerLoop1			# If x < 63, color next pixel in row
			
			incrementY:			
				addi $a1, $a1, 1	# Incrememnt y coordinate
				j outerLoop1		# Repeat outerloop
			
	exitLoop1:
		lw $ra, 0($sp)		# Load original return address
		lw $a0, 4($sp)		# Load original x coord
		lw $a1, 8($sp)		# Loard original y coord
		addi $sp, $sp, 12	# Free stack memory
	
	jr $ra	# Jump back to caller
	
# Draw board
# Draws the pyramid of circles for board setup
# input - xCircleCenters - array of the x coordinates of the centers of the circles
# input - yCircleCenters - array of the y coordinates of the centers of the circles
# input - $a2 - color index
# return - none
drawBoard:
	addi $sp, $sp, -16	 	# Make space on stack
	sw $ra, 0($sp)		 	# Store original return address
	sw $s0, 4($sp)		 	# Store original $s0
	sw $s1, 8($sp)		 	# Store original s1
	sw $s2, 12($sp)		 	# Store original s2
	
	la $s0, xCircleCenters	 	# Load array address
	la $s1, yCircleCenters	 	# Load array address
	li $s2, 21		 	# Counter for how many circles remaining to draw
	
	Loop2:
		lw $a0, 0($s0)	 	# Load x coordinate from array
		lw $a1, 0($s1)	 	# Load y coordinate from array
		jal drawCircle	 	# Draw circle
		addi $s0, $s0, 4 	# Move x array pointer to next value
		addi $s1, $s1, 4 	# Move y array pointer to next value
		addi $s2, $s2, -1 	# Reduce circle counter by one 
		bne $s2, $zero, Loop2 	# Loop again if there are circles remaining to draw
	
	lw $ra, 0($sp)		# Restore return address
	lw $s0, 4($sp)		# Restore $s0
	lw $s1, 8($sp)		# Restore $s1
	lw $s2, 12($sp)		# Restore $s2
	
	addi $sp, $sp, 16	# Free stack memory
	jr $ra			# Return to caller
	
# Draw number on circle
# Given a player's chosen circle, draw the current number in that circle
# input - $a0 - x coordinate (0-63)
# input - $a1 - y coordinate (0-63)
# input - $a2 - color index
# input - $s1 - current number (1-10)
# input - $s2 - chosen index (0-20)
# return - none
drawNumberOnCircle:
	addi $sp, $sp, -4	# Make room on stack
	sw $ra, 0($sp)		# Store original return address
	
	la $t0, xCircleCenters	# Load array address
	la $t1, yCircleCenters	# Load array address
	
	# Get the correct (x,y) coordinate based on player's chosen circle
	move $t3, $s2		# Copy chosen circle index to $t3
	sll $t3, $t3, 2		# Multiply index by 4 to get address offset
	add $t0, $t0, $t3	# Add offset
	add $t1, $t1, $t3	# Add offset
	lw $a0, 0($t0)		# Store x coordinate
	lw $a1, 0($t1)		# Store y coordinate
	
	# Draw the correct number
	li $t4, 1		# Load 1
	bne $s1, $t4, skip1	# If current number doesn't equal 1, skip drawing one
	jal drawOne		# If it is equal, draw one

	skip1:			# Repeat for all numbers
	li $t4, 2
	bne $s1, $t4, skip2
	jal drawTwo
	
	skip2:
	li $t4, 3
	bne $s1, $t4, skip3
	jal drawThree
	
	skip3:	 
	li $t4, 4
	bne $s1, $t4, skip4
	jal drawFour
	
	skip4:	
	li $t4, 5
	bne $s1, $t4, skip5
	jal drawFive
	
	skip5:	
	li $t4, 6
	bne $s1, $t4, skip6
	jal drawSix
	
	skip6:	
	li $t4, 7
	bne $s1, $t4, skip7
	jal drawSeven
	
	skip7:	 
	li $t4, 8
	bne $s1, $t4, skip8
	jal drawEight
			
	skip8: 
	li $t4, 9
	bne $s1, $t4, skip9
	jal drawNine
	
	skip9:
	li $t4, 10
	bne $s1, $t4, skip10
	jal drawTen	
	
	skip10:
	lw $ra 0($sp)		# Restore original return address
	addi $sp, $sp, 4	# Free stack memory
	jr $ra			# Return to caller
	
# Draw player winner
# Draw "YOU WIN" on the screen
# input - none
# return - none
drawPlayerWinner:
	addi $sp, $sp, -12	# Create space in stack
	sw $ra, 0($sp)		# Store original return address
	sw $a0, 4($sp)		# Store original $a0
	sw $a1, 8($sp)		# Store original $a1
	
	li $a0, 16
	li $a1, 18
	
	# Draw "YOU"
	jal drawY
	
	addi $a0, $a0, 10
	jal drawO
	
	addi $a0, $a0, 10
	jal drawU
	
	# Draw "WIN"
	addi $a1, $a1, 14
	li $a0, 16
	jal drawW
	
	addi $a0, $a0, 13
	jal drawI
	
	addi $a0, $a0, 10
	jal drawN	
	
			
	lw $ra, 0($sp)		# Restore $ra
	lw $a0, 4($sp)		# Restore $a0
	lw $a1, 8($sp)		# Restore $a1
	addi $sp, $sp, 12	# Free memory
	
	jr $ra			# Return to caller
	
# Draw player lose
# Draw "YOU LOSE" on the screen
# input - none
# return - none
drawPlayerLose:
	addi $sp, $sp, -12	# Create space in stack
	sw $ra, 0($sp)		# Store original return address
	sw $a0, 4($sp)		# Store original $a0
	sw $a1, 8($sp)		# Store original $a1
	
	li $a0, 16
	li $a1, 18
	
	# Draw "YOU"
	jal drawY
	
	addi $a0, $a0, 10
	jal drawO
	
	addi $a0, $a0, 10
	jal drawU
	
	# Draw "LOSE"
	addi $a1, $a1, 14
	li $a0, 12
	jal drawL
	
	addi $a0, $a0, 10
	jal drawO
	
	addi $a0, $a0, 10
	jal drawS	
	
	addi $a0, $a0, 10
	jal drawE
				
	lw $ra, 0($sp)		# Restore $ra
	lw $a0, 4($sp)		# Restore $a0
	lw $a1, 8($sp)		# Restore $a1
	addi $sp, $sp, 12	# Free memory
	
	jr $ra			# Return to caller
	
		


	
	
	