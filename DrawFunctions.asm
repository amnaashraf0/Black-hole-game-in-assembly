# Draw circle
# Draws a 10 pixel diameter circle centered around x and y inputs
# Circle pixels will be hardcoded because radius will never change (5)
# input - $a0 - x coordinate (0-63)
# input - $a1 - y coordinate (0-63)
# input - $a2 - color index
# return - none
drawCircle:
	addi $sp, $sp, -12	# Make room on stack
	sw $ra, 0($sp)		# Store original return address value
	sw $a0, 4($sp)		# Store original x coord value
	sw $a1, 8($sp)		# Store original y coord value
	
	# Draw top line
	addi $a0, $a0, -2 	# Set x coordinate
	addi $a1, $a1, -4	# Set y coordinate
	li $a3, 5		# Set line length (5)
	jal drawHorizontalLine # Draw line
	
	# Draw bottom line
	addi $a1, $a1, 8	# Set y coordinate
	jal drawHorizontalLine	# Draw line
	
	#Draw left line
	addi $a0, $a0, -2	# Set x coordinate
	addi $a1, $a1, -6	# Set y coordinate
	jal drawVerticalLine	# Draw line
	
	# Draw right line
	addi $a0, $a0, 8	# Set x coordinate
	jal drawVerticalLine	# Draw line
	
	#Draw corners
	addi $a0, $a0, -1	# x cord for top right
	addi $a1, $a1, -1	# y cord for top right
	jal drawPixel		# Draw
	addi $a0, $a0, -6	# x cord for top left
	jal drawPixel		# Draw
	addi $a1, $a1, 6	# y cord for bottom left
	jal drawPixel		# Draw
	addi $a0, $a0, 6	# x cord for bottom right
	jal drawPixel		# Draw

	lw $ra, 0($sp)		# Restore return address
	lw $a0, 4($sp)		# Restore x coord
	lw $a1, 8($sp)		# Restore y coord
	addi $sp, $sp, 12	# Free memory
	
	jr $ra			# Return to caller
	
# Draw one
# Draws the number one given a center (x,y) coordinate
# input - $a0 - x coordinate (0-63)
# input - $a1 - y coordinate (0-63)
# input - $a2 - color index
# return - none
drawOne:
	addi $sp, $sp, -12	# Make room on stack
	sw $ra, 0($sp)		# Store original return address value
	sw $a0, 4($sp)		# Store original x coord value
	sw $a1, 8($sp)		# Store original y coord value
	
	# Draw vertical part
	addi $a1, $a1, -2	# Set y coordinate
	li $a3, 5		# Set length of line
	jal drawVerticalLine	# Draw line
	
	# Draw horizontal part
	addi $a0, $a0, -1	# Set x coordinate
	addi $a1, $a1, 4	# Set y coordinate
	li $a3, 3		# Set length (3)
	jal drawHorizontalLine	# Draw line
	
	# Draw corner detail
	addi $a1, $a1, -3	# Set y coordinate
	jal drawPixel		# Draw pixel
	
	lw $ra, 0($sp)		# Restore return address
	lw $a0, 4($sp)		# Restore x coord
	lw $a1, 8($sp)		# Restore y coord
	addi $sp, $sp, 12	# Free memory
	
	jr $ra			# Return to caller
	
# Draw two
# Draws the number two given a center (x,y) coordinate
# input - $a0 - x coordinate (0-63)
# input - $a1 - y coordinate (0-63)
# input - $a2 - color index
# return - none
drawTwo:
	addi $sp, $sp, -12	# Make room on stack
	sw $ra, 0($sp)		# Store original return address value
	sw $a0, 4($sp)		# Store original x coord value
	sw $a1, 8($sp)		# Store original y coord value
	
	# Draw middle horizontal line
	addi $a0, $a0, -1	# Set x coordinate
	li $a3, 3		# Set line length (3)
	jal drawHorizontalLine	# Draw line
	
	# Draw top horizontal line
	addi $a1, $a1, -2	# Set y coordinate
	jal drawHorizontalLine	# Draw line
	
	# Draw bottom horizontal line
	addi $a1, $a1, 4	# Set y coordinate
	jal drawHorizontalLine	# Draw line
	
	# Draw connecting pixels to form "2"
	addi $a1, $a1, -1	# Set y coordinate
	jal drawPixel		# Draw pixel
	addi $a1, $a1, -2	# Set y coordinate
	addi $a0, $a0, 2	# Set x coordinate
	jal drawPixel		# Draw pixel
	
	lw $ra, 0($sp)		# Restore return address
	lw $a0, 4($sp)		# Restore x coord
	lw $a1, 8($sp)		# Restore y coord
	addi $sp, $sp, 12	# Free memory
	
	jr $ra			# Return to caller
	
# Draw three
# Draws the number three given a center (x,y) coordinate
# input - $a0 - x coordinate (0-63)
# input - $a1 - y coordinate (0-63)
# input - $a2 - color index
# return - none
drawThree:
	addi $sp, $sp, -12	# Make room on stack
	sw $ra, 0($sp)		# Store original return address value
	sw $a0, 4($sp)		# Store original x coord value
	sw $a1, 8($sp)		# Store original y coord value
	
	# Draw middle horizontal line
	addi $a0, $a0, -1	# Set x coordinate
	li $a3, 3		# Set line length (3)
	jal drawHorizontalLine	# Draw line
	
	# Draw top horizontal line
	addi $a1, $a1, -2	# Set y coordinate
	jal drawHorizontalLine	# Draw line
	
	# Draw bottom horizontal line
	addi $a1, $a1, 4	# Set y coordinate
	jal drawHorizontalLine	# Draw line
	
	# Draw connecting pixels to form "3"
	addi $a1, $a1, -1	# Set y coordinate
	addi $a0, $a0, 2	# Set x coordinate
	jal drawPixel		# Draw pixel
	addi $a1, $a1, -2	# Set y coordinate
	jal drawPixel		# Draw pixel
	
	lw $ra, 0($sp)		# Restore return address
	lw $a0, 4($sp)		# Restore x coord
	lw $a1, 8($sp)		# Restore y coord
	addi $sp, $sp, 12	# Free memory
	
	jr $ra			# Return to caller
	
# Draw four
# Draws the number four given a center (x,y) coordinate
# input - $a0 - x coordinate (0-63)
# input - $a1 - y coordinate (0-63)
# input - $a2 - color index
# return - none
drawFour:
	addi $sp, $sp, -12	# Make room on stack
	sw $ra, 0($sp)		# Store original return address value
	sw $a0, 4($sp)		# Store original x coord value
	sw $a1, 8($sp)		# Store original y coord value
	
	# Draw middle horizontal line
	addi $a0, $a0, -1	# Set x coordinate
	li $a3, 3		# Set line length (3)
	jal drawHorizontalLine	# Draw line
	
	# Draw left vertical line
	addi $a1, $a1, -2	# Set y coordinate
	li $a3, 2		# Set line length (2)
	jal drawVerticalLine	# Draw line
	
	# Draw right vertical line
	addi $a0, $a0, 2	# Set x coordinate
	li $a3, 5		# Set line length (5)
	jal drawVerticalLine	# Draw line
	
	lw $ra, 0($sp)		# Restore return address
	lw $a0, 4($sp)		# Restore x coord
	lw $a1, 8($sp)		# Restore y coord
	addi $sp, $sp, 12	# Free memory
	
	jr $ra			# Return to caller
	
# Draw five
# Draws the number five given a center (x,y) coordinate
# input - $a0 - x coordinate (0-63)
# input - $a1 - y coordinate (0-63)
# input - $a2 - color index
# return - none
drawFive:
	addi $sp, $sp, -12	# Make room on stack
	sw $ra, 0($sp)		# Store original return address value
	sw $a0, 4($sp)		# Store original x coord value
	sw $a1, 8($sp)		# Store original y coord value
	
	# Draw middle horizontal line
	addi $a0, $a0, -1	# Set x coordinate
	li $a3, 3		# Set line length (3)
	jal drawHorizontalLine	# Draw line
	
	# Draw top horizontal line
	addi $a1, $a1, -2	# Set y coordinate
	jal drawHorizontalLine	# Draw line
	
	# Draw bottom horizontal line
	addi $a1, $a1, 4	# Set y coordinate
	jal drawHorizontalLine	# Draw line
	
	# Draw connecting pixels to form "5"
	addi $a1, $a1, -1	# Set y coordinate
	addi $a0, $a0, 2	# Set x coordinate
	jal drawPixel		# Draw pixel
	addi $a1, $a1, -2	# Set y coordinate
	addi $a0, $a0, -2	# Set x coordinate
	jal drawPixel		# Draw pixel
	
	lw $ra, 0($sp)		# Restore return address
	lw $a0, 4($sp)		# Restore x coord
	lw $a1, 8($sp)		# Restore y coord
	addi $sp, $sp, 12	# Free memory
	
	jr $ra			# Return to caller
	
# Draw six
# Draws the number six given a center (x,y) coordinate
# input - $a0 - x coordinate (0-63)
# input - $a1 - y coordinate (0-63)
# input - $a2 - color index
# return - none
drawSix:
	addi $sp, $sp, -12	# Make room on stack
	sw $ra, 0($sp)		# Store original return address value
	sw $a0, 4($sp)		# Store original x coord value
	sw $a1, 8($sp)		# Store original y coord value
	
	# Draw middle horizontal line
	addi $a0, $a0, -1	# Set x coordinate
	li $a3, 3		# Set line length (3)
	jal drawHorizontalLine	# Draw line
	
	# Draw top horizontal line
	addi $a1, $a1, -2	# Set y coordinate
	jal drawHorizontalLine	# Draw line
	
	# Draw bottom horizontal line
	addi $a1, $a1, 4	# Set y coordinate
	jal drawHorizontalLine	# Draw line
	
	# Draw connecting pixels to form "6"
	addi $a1, $a1, -1	# Set y coordinate
	jal drawPixel		# Draw pixel
	addi $a1, $a1, -2	# Set y coordinate
	jal drawPixel		# Draw pixel
	addi $a0, $a0, 2	# Set x coordinate
	addi $a1, $a1, 2	# Set y coordinate
	jal drawPixel		# Draw pixel
	
	lw $ra, 0($sp)		# Restore return address
	lw $a0, 4($sp)		# Restore x coord
	lw $a1, 8($sp)		# Restore y coord
	addi $sp, $sp, 12	# Free memory
	
	jr $ra			# Return to caller
	
# Draw seven
# Draws the number seven given a center (x,y) coordinate
# input - $a0 - x coordinate (0-63)
# input - $a1 - y coordinate (0-63)
# input - $a2 - color index
# return - none
drawSeven:
	addi $sp, $sp, -12	# Make room on stack
	sw $ra, 0($sp)		# Store original return address value
	sw $a0, 4($sp)		# Store original x coord value
	sw $a1, 8($sp)		# Store original y coord value
	
	# Draw horizontal line
	addi $a0, $a0, -1	# Set x coordinate
	addi $a1, $a1, -2	# Set y coordinate
	li $a3, 3		# Set line length (3)
	jal drawHorizontalLine	# Draw line
	
	# Draw vertical line
	addi $a0, $a0, 2	# Set x coordinate
	li $a3, 5		# Set line length (5)
	jal drawVerticalLine	# Draw line
	
	lw $ra, 0($sp)		# Restore return address
	lw $a0, 4($sp)		# Restore x coord
	lw $a1, 8($sp)		# Restore y coord
	addi $sp, $sp, 12	# Free memory
	
	jr $ra			# Return to caller
	
# Draw eight
# Draws the number eight given a center (x,y) coordinate
# input - $a0 - x coordinate (0-63)
# input - $a1 - y coordinate (0-63)
# input - $a2 - color index
# return - none
drawEight:
	addi $sp, $sp, -12	# Make room on stack
	sw $ra, 0($sp)		# Store original return address value
	sw $a0, 4($sp)		# Store original x coord value
	sw $a1, 8($sp)		# Store original y coord value
	
	# Draw left vertical line
	addi $a0, $a0, -1	# Set x coordinate
	addi $a1, $a1, -2	# Set y coordinate
	li $a3, 5		# Set line length (5)
	jal drawVerticalLine	# Draw line
	
	# Draw right vertical line
	addi $a0, $a0, 2	# Set x coordinate
	jal drawVerticalLine	# Draw line
	
	# Draw connecting pixels to form "8"
	addi $a0, $a0, -1	# Set x coordinate
	jal drawPixel		# Draw pixel
	addi $a1, $a1, 2	# Set y coordinate
	jal drawPixel		# Draw pixel
	addi $a1, $a1, 2	# Set y coordinate
	jal drawPixel		# Draw pixel
	
	lw $ra, 0($sp)		# Restore return address
	lw $a0, 4($sp)		# Restore x coord
	lw $a1, 8($sp)		# Restore y coord
	addi $sp, $sp, 12	# Free memory
	
	jr $ra			# Return to caller
	
# Draw nine
# Draws the number nine given a center (x,y) coordinate
# input - $a0 - x coordinate (0-63)
# input - $a1 - y coordinate (0-63)
# input - $a2 - color index
# return - none
drawNine:
	addi $sp, $sp, -12	# Make room on stack
	sw $ra, 0($sp)		# Store original return address value
	sw $a0, 4($sp)		# Store original x coord value
	sw $a1, 8($sp)		# Store original y coord value
	
	# Draw middle horizontal line
	addi $a0, $a0, -1	# Set x coordinate
	li $a3, 3		# Set line length (3)
	jal drawHorizontalLine	# Draw line
	
	# Draw top horizontal line
	addi $a1, $a1, -2	# Set y coordinate
	jal drawHorizontalLine	# Draw line
	
	# Draw vertical line
	addi $a0, $a0, 2	# Set x coordinate
	li $a3, 5		# Set line length (5)
	jal drawVerticalLine	# Draw line
	
	# Draw connecting pixel to form "9"
	addi $a0, $a0, -2	# Set x coordinate
	addi $a1, $a1, 1	# Set y coordinate
	jal drawPixel		# Draw pixel
	
	lw $ra, 0($sp)		# Restore return address
	lw $a0, 4($sp)		# Restore x coord
	lw $a1, 8($sp)		# Restore y coord
	addi $sp, $sp, 12	# Free memory
	
	jr $ra			# Return to caller
	
# Draw ten
# Draws the number ten given a center (x,y) coordinate
# input - $a0 - x coordinate (0-63)
# input - $a1 - y coordinate (0-63)
# input - $a2 - color index
# return - none
drawTen:
	addi $sp, $sp, -12	# Make room on stack
	sw $ra, 0($sp)		# Store original return address value
	sw $a0, 4($sp)		# Store original x coord value
	sw $a1, 8($sp)		# Store original y coord value
	
	# Draw vertical line that will be the one
	addi $a0, $a0, -2	# Set x coordinate
	addi $a1, $a1, -1	# Set y coordinate
	li $a3, 3		# Set line length (3)
	jal drawVerticalLine	# Draw line
	
	# Draw left vertical line of the zero
	addi $a0, $a0, 2	# Set x coordinate
	jal drawVerticalLine	# Draw line
	
	# Draw right vertical line of the zero
	addi $a0, $a0, 2	# Set x coordinate
	jal drawVerticalLine	# Draw line
	
	# Draw connecting pixels to finish the "0"
	addi $a0, $a0, -1	# Set x coordinate
	jal drawPixel		# Draw pixel
	addi $a1, $a1, 2	# Set y coordinate
	jal drawPixel		# Draw pixel
	
	lw $ra, 0($sp)		# Restore return address
	lw $a0, 4($sp)		# Restore x coord
	lw $a1, 8($sp)		# Restore y coord
	addi $sp, $sp, 12	# Free memory
	
	jr $ra			# Return to caller	
	
	
#--- Draw letter functions ---
# Manually drawing each letter by adjusting coordinates/line length and drawing horizontal/vertical lines
# Function header is the same for all letters, only the letter changes
	
# Draw A
# Draws the letter A using the (x,y) coordinates as the top left corner of the letter
# input - $a0 - x coordinate (0-63)
# input - $a1 - y coordinate (0-63)
# input - $a2 - color index
# return - none
drawA:
	addi $sp, $sp, -16	# Make room on stack
	sw $ra, 0($sp)		# Store original return address value
	sw $a0, 4($sp)		# Store original x coord value
	sw $a1, 8($sp)		# Store original y coord value
	sw $s0, 12($sp)		# Store original $s0
	move $s0, $a2		# Copy color value to $s0
	
	li $a2, 1		# Set color to black for border
	
	# Draw vertical lines
	li $a3, 11		# Set line length to 11
	jal drawVerticalLine	# Draw line
	addi $a0, $a0, 7	# Set x coordinate
	jal drawVerticalLine	# Draw line
	addi $a0, $a0, -5	# Set x coordinate
	addi $a1, $a1, 6	# Set y coordinate
	li $a3, 5		# Set line length to 5
	jal drawVerticalLine	# Draw line
	addi $a0, $a0, 3	# Set x coordinate
	jal drawVerticalLine	# Draw line
	
	# Draw horizontal lines
	addi $a0, $a0, -4	# Set coordinates
	addi $a1, $a1, -6
	li $a3, 6		# Line length of 6
	jal drawHorizontalLine
	addi $a0, $a0, 1	# Set coordinates
	addi $a1, $a1, 2
	li $a3, 4		# Line length of 4
	jal drawHorizontalLine
	addi $a1, $a1, 1	# Set coordinates
	jal drawHorizontalLine
	addi $a0, $a0, 1	# Set coordinates
	addi $a1, $a1, 3
	li $a3, 2		# Line length of 2
	jal drawHorizontalLine
	
	# Draw connecting pixels
	addi $a0, $a0, -2	# Set coordinates
	addi $a1, $a1, 4
	jal drawPixel
	addi $a0, $a0, 5	# Set coordinates
	jal drawPixel
	
	# Fill in the letter
	move $a2, $s0		# Restore original color
	addi $a1, $a1, -9	# Set coordinates
	li $a3, 9		# Line length
	jal drawVerticalLine
	addi $a0, $a0, -5	# Set coordinates
	jal drawVerticalLine
	li $a3, 5		# Set line length
	jal drawHorizontalLine
	addi $a1, $a1, 3	# Set coordinates
	jal drawHorizontalLine
	addi $a1, $a1, 1
	jal drawHorizontalLine
	
	
	lw $ra, 0($sp)		# Restore return address
	lw $a0, 4($sp)		# Restore x coord
	lw $a1, 8($sp)		# Restore y coord
	lw $s0, 12($sp)
	addi $sp, $sp, 16	# Free memory
	
	jr $ra			# Return to caller
	
drawC:
	addi $sp, $sp, -16	# Make room on stack
	sw $ra, 0($sp)		# Store original return address value
	sw $a0, 4($sp)		# Store original x coord value
	sw $a1, 8($sp)		# Store original y coord value
	sw $s0, 12($sp)		# Store original $s0
	move $s0, $a2		# Copy color value to $s0
	
	li $a2, 1		# Set color to black for border
	
	# Draw lines
	li $a3, 8		# Set line length
	jal drawHorizontalLine
	li $a3, 11		# Set line length
	jal drawVerticalLine
	addi $a0, $a0, 7	# Set coordinates
	li $a3, 3		# Set line length
	jal drawVerticalLine
	addi $a0, $a0, -5	# Set coordinates
	addi $a1, $a1, 2
	li $a3, 5		# Set line length
	jal drawHorizontalLine
	li $a3, 7		# Set line length
	jal drawVerticalLine
	addi $a1, $a1, 6	# Set coordinates
	li $a3, 6		# Set line length
	jal drawHorizontalLine
	addi $a0, $a0, -1	# Set coordinates
	addi $a1, $a1, 2
	li $a3, 7		# Set line length
	jal drawHorizontalLine
	
	# Draw connecting pixel
	addi $a0, $a0, 6	# Set coordinates
	addi $a1, $a1 -1
	jal drawPixel
	
	# Fill letter
	move $a2, $s0		# Restore color
	addi $a1, $a1, -8	# Set coordinates
	addi $a0, $a0, -6
	li $a3, 6		# Set line length
	jal drawHorizontalLine
	li $a3, 9		# Set line length
	jal drawVerticalLine
	addi $a1, $a1, 8	# Set coordinate
	li $a3, 6		# Set line length
	jal drawHorizontalLine
	
	
	lw $ra, 0($sp)		# Restore return address
	lw $a0, 4($sp)		# Restore x coord
	lw $a1, 8($sp)		# Restore y coord
	lw $s0, 12($sp)
	addi $sp, $sp, 16	# Free memory
	
	jr $ra			# Return to caller
	
drawE:
	addi $sp, $sp, -16	# Make room on stack
	sw $ra, 0($sp)		# Store original return address value
	sw $a0, 4($sp)		# Store original x coord value
	sw $a1, 8($sp)		# Store original y coord value
	sw $s0, 12($sp)		# Store original $s0
	move $s0, $a2		# Copy color value to $s0
	
	li $a2, 1		# Set color to black for border
	
	# Draw lines
	li $a3, 8		# Set line length
	jal drawHorizontalLine
	li $a3, 11		# Set line length
	jal drawVerticalLine
	addi $a0, $a0, 2	# Set coordinates
	addi $a1, $a1, 2
	li $a3, 6		# Set line length
	jal drawHorizontalLine
	li $a3, 3
	jal drawVerticalLine
	addi $a1, $a1, 2
	li $a3, 6
	jal drawHorizontalLine
	addi $a1, $a1, 2
	jal drawHorizontalLine
	li $a3, 3
	jal drawVerticalLine
	addi $a1, $a1, 2
	li $a3, 6
	jal drawHorizontalLine
	addi $a0, $a0, -1
	addi $a1, $a1, 2
	li $a3, 7
	jal drawHorizontalLine
	
	# Draw connecting pixels
	addi $a0, $a0, 6
	addi $a1, $a1, -1
	jal drawPixel
	addi $a1, $a1, -4
	jal drawPixel
	addi $a1, $a1, -4
	jal drawPixel
	
	# Fill
	move $a2, $s0		# Restore original color
	addi $a0, $a0, -6
	li $a3, 6
	jal drawHorizontalLine
	li $a3, 9
	jal drawVerticalLine
	addi $a0, $a0, 1
	addi $a1, $a1, 4
	li $a3, 5
	jal drawHorizontalLine
	addi $a1, $a1, 4
	jal drawHorizontalLine
	
	
	lw $ra, 0($sp)		# Restore return address
	lw $a0, 4($sp)		# Restore x coord
	lw $a1, 8($sp)		# Restore y coord
	lw $s0, 12($sp)
	addi $sp, $sp, 16	# Free memory
	
	jr $ra			# Return to caller

drawI:
	addi $sp, $sp, -16	# Make room on stack
	sw $ra, 0($sp)		# Store original return address value
	sw $a0, 4($sp)		# Store original x coord value
	sw $a1, 8($sp)		# Store original y coord value
	sw $s0, 12($sp)		# Store original $s0
	move $s0, $a2		# Copy color value to $s0
	
	li $a2, 1		# Set color to black for border
	
	# Draw lines
	li $a3, 8
	jal drawHorizontalLine
	li $a3, 3
	jal drawVerticalLine
	addi $a1, $a1, 2
	jal drawHorizontalLine
	addi $a0, $a0, 5
	jal drawHorizontalLine
	li $a3, 7
	jal drawVerticalLine
	addi $a0, $a0, -3
	jal drawVerticalLine
	addi $a0, $a0, -2
	addi $a1, $a1, 6
	li $a3, 3
	jal drawHorizontalLine
	jal drawVerticalLine
	addi $a0, $a0, 5
	jal drawHorizontalLine
	addi $a0, $a0, 2
	jal drawVerticalLine
	addi $a0, $a0, -6
	addi $a1, $a1, 2
	li $a3, 6
	jal drawHorizontalLine
	
	# Draw connecting pixel
	addi $a0, $a0, 6
	addi $a1, $a1, -9
	jal drawPixel
	
	# Fill 
	move $a2, $s0		# Restore original color
	addi $a0, $a0, -6
	li $a3, 6
	jal drawHorizontalLine
	addi $a1, $a1, 8
	jal drawHorizontalLine
	addi $a0, $a0, 2
	addi $a1, $a1, -7
	li $a3, 7
	jal drawVerticalLine
	addi $a0, $a0, 1
	jal drawVerticalLine
	
	
	
	lw $ra, 0($sp)		# Restore return address
	lw $a0, 4($sp)		# Restore x coord
	lw $a1, 8($sp)		# Restore y coord
	lw $s0, 12($sp)
	addi $sp, $sp, 16	# Free memory
	
	jr $ra			# Return to caller
	
drawN:
	addi $sp, $sp, -16	# Make room on stack
	sw $ra, 0($sp)		# Store original return address value
	sw $a0, 4($sp)		# Store original x coord value
	sw $a1, 8($sp)		# Store original y coord value
	sw $s0, 12($sp)		# Store original $s0
	move $s0, $a2		# Copy color value to $s0
	
	li $a2, 1		# Set color to black for border
	
	# Draw lines
	li $a3, 11
	jal drawVerticalLine
	li $a3, 3
	jal drawHorizontalLine
	addi $a0, $a0, 5
	jal drawHorizontalLine
	li $a3, 5
	jal drawVerticalLine
	addi $a0, $a0, 2
	li $a3, 11
	jal drawVerticalLine
	addi $a0, $a0, -5
	addi $a1, $a1, 6
	li $a3, 5
	jal drawVerticalLine
	li $a3, 2
	jal drawHorizontalLine
	addi $a1, $a1, -5
	jal drawVerticalLine
	addi $a0, $a0, 3
	addi $a1, $a1, 7
	li $a3, 3
	jal drawVerticalLine
	
	# Draw connecting pixels
	addi $a0, $a0, -1
	addi $a1, $a1, -1
	jal drawPixel
	addi $a0, $a0, -1
	addi $a1, $a1, -4
	li $a3, 2
	jal drawVerticalLine
	addi $a1, $a1, 1
	jal drawHorizontalLine
	addi $a0, $a0, 3
	addi $a1, $a1, 6
	jal drawPixel
	addi $a0, $a0, -5
	jal drawPixel
	
	# Fill 
	move $a2, $s0		# Restore original color
	addi $a1, $a1, -9
	li $a3, 9
	jal drawVerticalLine
	addi $a0, $a0, 1
	addi $a1, $a1, 2
	li $a3, 3
	jal drawVerticalLine
	addi $a1, $a1, 2
	li $a3, 5
	jal drawHorizontalLine
	addi $a0, $a0, 2
	addi $a1, $a1, 1
	li $a3, 3
	jal drawHorizontalLine
	addi $a0, $a0, 2
	addi $a1, $a1, -5
	li $a3, 9
	jal drawVerticalLine
	addi $a0, $a0, -1
	addi $a1, $a1, 6
	jal drawPixel

	
	lw $ra, 0($sp)		# Restore return address
	lw $a0, 4($sp)		# Restore x coord
	lw $a1, 8($sp)		# Restore y coord
	lw $s0, 12($sp)
	addi $sp, $sp, 16	# Free memory
	
	jr $ra			# Return to caller

drawM:
	addi $sp, $sp, -16	# Make room on stack
	sw $ra, 0($sp)		# Store original return address value
	sw $a0, 4($sp)		# Store original x coord value
	sw $a1, 8($sp)		# Store original y coord value
	sw $s0, 12($sp)		# Store original $s0
	move $s0, $a2		# Copy color value to $s0
	
	li $a2, 1		# Set color to black for border
	
	# Draw lines
	li $a3, 11
	jal drawVerticalLine
	li $a3, 3
	jal drawHorizontalLine
	addi $a0, $a0, 5
	jal drawHorizontalLine
	addi $a0, $a0, 2
	li $a3, 11
	jal drawVerticalLine
	addi $a0, $a0, -6
	addi $a1, $a1, 10
	li $a3, 2
	jal drawHorizontalLine
	addi $a0, $a0, 1
	addi $a1, $a1, -6
	li $a3, 6
	jal drawVerticalLine
	addi $a0, $a0, 3
	li $a3, 7
	jal drawVerticalLine
	
	# Connecting pixels
	addi $a0, $a0, -3
	addi $a1, $a1, -3
	jal drawPixel
	addi $a0, $a0, 1
	addi $a1, $a1, 1
	li $a3, 2
	jal drawHorizontalLine
	addi $a1, $a1, 4
	jal drawHorizontalLine
	addi $a0, $a0, 3
	addi $a1, $a1, 4
	jal drawPixel
	addi $a0, $a0, -1
	addi $a1, $a1, -9
	jal drawPixel
	
	# Fill 
	move $a2, $s0		# Restore original color
	addi $a0, $a0, 1
	li $a3, 9
	jal drawVerticalLine
	addi $a0, $a0, -5
	jal drawVerticalLine
	addi $a0, $a0, 1
	addi $a1, $a1, 1
	li $a3, 2
	jal drawVerticalLine
	addi $a0, $a0, 1
	addi $a1, $a1, 1
	li $a3, 3
	jal drawVerticalLine
	addi $a0, $a0, 1
	jal drawVerticalLine
	addi $a0, $a0, 1
	addi $a1, $a1, -1
	li $a3, 2
	jal drawVerticalLine

	
	lw $ra, 0($sp)		# Restore return address
	lw $a0, 4($sp)		# Restore x coord
	lw $a1, 8($sp)		# Restore y coord
	lw $s0, 12($sp)
	addi $sp, $sp, 16	# Free memory
	
	jr $ra			# Return to caller
	
drawO:
	addi $sp, $sp, -16	# Make room on stack
	sw $ra, 0($sp)		# Store original return address value
	sw $a0, 4($sp)		# Store original x coord value
	sw $a1, 8($sp)		# Store original y coord value
	sw $s0, 12($sp)		# Store original $s0
	move $s0, $a2		# Copy color value to $s0
	
	li $a2, 1		# Set color to black for border
	
	# Draw lines
	li $a3, 11
	jal drawVerticalLine
	li $a3, 8
	jal drawHorizontalLine
	addi $a1, $a1, 10
	jal drawHorizontalLine
	addi $a0, $a0, 7
	addi $a1, $a1, -9
	li $a3, 9
	jal drawVerticalLine
	addi $a0, $a0, -5
	addi $a1, $a1, 1
	li $a3, 4
	jal drawHorizontalLine
	li $a3, 7
	jal drawVerticalLine
	addi $a0, $a0, 3
	jal drawVerticalLine
	addi $a0, $a0, -2
	addi $a1, $a1, 6
	li $a3, 2
	jal drawHorizontalLine
	
	# Fill 
	move $a2, $s0		# Restore original color
	addi $a0, $a0, -2
	addi $a1, $a1, -7
	li $a3, 6
	jal drawHorizontalLine
	li $a3, 9
	jal drawVerticalLine
	addi $a1, $a1, 8
	li $a3, 6
	jal drawHorizontalLine
	addi $a0, $a0, 5
	addi $a1, $a1, -7
	li $a3, 7
	jal drawVerticalLine
	
	
	lw $ra, 0($sp)		# Restore return address
	lw $a0, 4($sp)		# Restore x coord
	lw $a1, 8($sp)		# Restore y coord
	lw $s0, 12($sp)
	addi $sp, $sp, 16	# Free memory
	
	jr $ra			# Return to caller
	
drawP:
	addi $sp, $sp, -16	# Make room on stack
	sw $ra, 0($sp)		# Store original return address value
	sw $a0, 4($sp)		# Store original x coord value
	sw $a1, 8($sp)		# Store original y coord value
	sw $s0, 12($sp)		# Store original $s0
	move $s0, $a2		# Copy color value to $s0
	
	li $a2, 1		# Set color to black for border
	
	# Draw lines
	li $a3, 11
	jal drawVerticalLine
	li $a3, 8
	jal drawHorizontalLine
	addi $a0, $a0, 7
	li $a3, 6
	jal drawVerticalLine
	addi $a0, $a0, -5
	addi $a1, $a1, 5
	jal drawHorizontalLine
	jal drawVerticalLine
	addi $a1, $a1, -3
	li $a3, 4
	jal drawHorizontalLine
	addi $a1, $a1, 1
	jal drawHorizontalLine
	addi $a0, $a0, -1
	addi $a1, $a1, 7
	jal drawPixel
	
	# Fill 
	move $a2, $s0		# Restore original color
	addi $a1, $a1, -9
	li $a3, 9
	jal drawVerticalLine
	li $a3, 6
	jal drawHorizontalLine
	addi $a1, $a1, 3
	jal drawHorizontalLine
	addi $a1, $a1, -3
	addi $a0, $a0, 5
	li $a3, 4
	jal drawVerticalLine
	
	
	lw $ra, 0($sp)		# Restore return address
	lw $a0, 4($sp)		# Restore x coord
	lw $a1, 8($sp)		# Restore y coord
	lw $s0, 12($sp)
	addi $sp, $sp, 16	# Free memory
	
	jr $ra			# Return to caller
	
drawR:
	addi $sp, $sp, -16	# Make room on stack
	sw $ra, 0($sp)		# Store original return address value
	sw $a0, 4($sp)		# Store original x coord value
	sw $a1, 8($sp)		# Store original y coord value
	sw $s0, 12($sp)		# Store original $s0
	move $s0, $a2		# Copy color value to $s0
	
	li $a2, 1		# Set color to black for border
	
	# Draw lines
	li $a3, 11
	jal drawVerticalLine
	li $a3, 7
	jal drawHorizontalLine
	addi $a0, $a0, 7
	addi $a1, $a1, 1
	li $a3, 4
	jal drawVerticalLine
	addi $a0, $a0, -5
	addi $a1, $a1, 1
	jal drawHorizontalLine
	addi $a1, $a1, 1
	jal drawHorizontalLine
	addi $a1, $a1, 3
	li $a3, 5
	jal drawVerticalLine
	li $a3, 2
	jal drawHorizontalLine
	addi $a1, $a1, 1
	li $a3, 3
	jal drawHorizontalLine
	addi $a0, $a0, 3
	addi $a1, $a1, 1
	jal drawVerticalLine
	addi $a1, $a1, 2
	jal drawHorizontalLine
	addi $a0, $a0, 2
	addi $a1, $a1, -3
	jal drawVerticalLine
	addi $a0, $a0, -2
	addi $a1, $a1, -2
	li $a3, 2
	jal drawHorizontalLine
	addi $a0, $a0, 1
	addi $a1, $a1, 1
	jal drawPixel
	addi $a0, $a0, -5
	addi $a1, $a1, 4
	jal drawPixel
	
	
	# Fill 
	move $a2, $s0		# Restore original color
	addi $a1, $a1, -9
	li $a3, 9
	jal drawVerticalLine
	li $a3, 6
	jal drawHorizontalLine
	addi $a0, $a0, 5
	li $a3, 4
	jal drawVerticalLine
	addi $a0, $a0, -5
	addi $a1, $a1, 3
	li $a3, 5
	jal drawHorizontalLine
	addi $a1, $a1, 1
	li $a3, 4
	jal drawHorizontalLine
	addi $a0, $a0, 3
	addi $a1, $a1, 1
	li $a3, 2
	jal drawHorizontalLine
	addi $a0, $a0, 1
	jal drawVerticalLine
	addi $a1, $a1, 1
	jal drawHorizontalLine
	addi $a0, $a0, 1
	li $a3, 3
	jal drawVerticalLine
	
	
	lw $ra, 0($sp)		# Restore return address
	lw $a0, 4($sp)		# Restore x coord
	lw $a1, 8($sp)		# Restore y coord
	lw $s0, 12($sp)
	addi $sp, $sp, 16	# Free memory
	
	jr $ra			# Return to caller
	
drawS:
	addi $sp, $sp, -16	# Make room on stack
	sw $ra, 0($sp)		# Store original return address value
	sw $a0, 4($sp)		# Store original x coord value
	sw $a1, 8($sp)		# Store original y coord value
	sw $s0, 12($sp)		# Store original $s0
	move $s0, $a2		# Copy color value to $s0
	
	li $a2, 1		# Set color to black for border
	
	# Draw lines
	li $a3, 8
	jal drawHorizontalLine
	li $a3, 7
	jal drawVerticalLine
	addi $a0, $a0, 2
	addi $a1, $a1, 2
	li $a3, 6
	jal drawHorizontalLine
	li $a3, 3
	jal drawVerticalLine
	addi $a1, $a1, 2
	li $a3, 6
	jal drawHorizontalLine
	addi $a0, $a0, -2
	addi $a1, $a1, 2
	li $a3, 6
	jal drawHorizontalLine
	addi $a1, $a1, 2
	jal drawHorizontalLine
	li $a3, 3
	jal drawVerticalLine
	addi $a1, $a1, 2
	li $a3, 8
	jal drawHorizontalLine
	addi $a0, $a0, 7
	addi $a1, $a1, -9
	jal drawPixel
	addi $a1, $a1, 4
	li $a3, 5
	jal drawVerticalLine
	addi $a0, $a0, -2
	addi $a1, $a1, 2
	jal drawPixel
	
	# Fill 
	move $a2, $s0		# Restore original color
	addi $a0, $a0, -4
	addi $a1, $a1, -6
	li $a3, 6
	jal drawHorizontalLine
	li $a3, 5
	jal drawVerticalLine
	addi $a1, $a1, 4
	li $a3, 6
	jal drawHorizontalLine
	addi $a0, $a0, 5
	li $a3, 5
	jal drawVerticalLine
	addi $a0, $a0, -5
	addi $a1, $a1, 4
	jal drawHorizontalLine
	
	
	lw $ra, 0($sp)		# Restore return address
	lw $a0, 4($sp)		# Restore x coord
	lw $a1, 8($sp)		# Restore y coord
	lw $s0, 12($sp)
	addi $sp, $sp, 16	# Free memory
	
	jr $ra			# Return to caller
	
drawT:
	addi $sp, $sp, -16	# Make room on stack
	sw $ra, 0($sp)		# Store original return address value
	sw $a0, 4($sp)		# Store original x coord value
	sw $a1, 8($sp)		# Store original y coord value
	sw $s0, 12($sp)		# Store original $s0
	move $s0, $a2		# Copy color value to $s0
	
	li $a2, 1		# Set color to black for border
	
	# Draw lines
	li $a3, 8
	jal drawHorizontalLine
	li $a3, 4
	jal drawVerticalLine
	addi $a0, $a0, 7
	jal drawVerticalLine
	addi $a0, $a0, -7
	addi $a1, $a1, 3
	li $a3, 3
	jal drawHorizontalLine
	addi $a0, $a0, 5
	jal drawHorizontalLine
	addi $a0, $a0, -3
	li $a3, 8
	jal drawVerticalLine
	addi $a0, $a0, 3
	jal drawVerticalLine
	addi $a0, $a0, -2
	addi $a1, $a1, 7
	li $a3, 2
	jal drawHorizontalLine
	
	# Fill 
	move $a2, $s0		# Restore original color
	addi $a0, $a0, -2
	addi $a1, $a1, -9
	li $a3, 6
	jal drawHorizontalLine
	addi $a1, $a1, 1
	jal drawHorizontalLine
	addi $a0, $a0, 2
	li $a3, 8
	jal drawVerticalLine
	addi $a0, $a0, 1
	jal drawVerticalLine
	
	
	lw $ra, 0($sp)		# Restore return address
	lw $a0, 4($sp)		# Restore x coord
	lw $a1, 8($sp)		# Restore y coord
	lw $s0, 12($sp)
	addi $sp, $sp, 16	# Free memory
	
	jr $ra			# Return to caller
	
drawU:
	addi $sp, $sp, -16	# Make room on stack
	sw $ra, 0($sp)		# Store original return address value
	sw $a0, 4($sp)		# Store original x coord value
	sw $a1, 8($sp)		# Store original y coord value
	sw $s0, 12($sp)		# Store original $s0
	move $s0, $a2		# Copy color value to $s0
	
	li $a2, 1		# Set color to black for border
	
	# Draw lines
	li $a3, 11
	jal drawVerticalLine
	li $a3, 3
	jal drawHorizontalLine
	addi $a1, $a1, 10
	li $a3, 8
	jal drawHorizontalLine
	addi $a0, $a0, 2
	addi $a1, $a1, -9
	li $a3, 8
	jal drawVerticalLine
	addi $a1, $a1, 7
	li $a3, 4
	jal drawHorizontalLine
	addi $a0, $a0, 3
	addi $a1, $a1, -8
	li $a3, 8
	jal drawVerticalLine
	li $a3, 3
	jal drawHorizontalLine
	addi $a0, $a0, 2
	li $a3, 10
	jal drawVerticalLine
	
	# Fill 
	move $a2, $s0		# Restore original color
	addi $a0, $a0, -6
	addi $a1, $a1, 1
	li $a3, 9
	jal drawVerticalLine
	addi $a0, $a0, 5
	jal drawVerticalLine
	addi $a0, $a0, -5
	addi $a1, $a1, 8
	li $a3, 5
	jal drawHorizontalLine
	
	
	lw $ra, 0($sp)		# Restore return address
	lw $a0, 4($sp)		# Restore x coord
	lw $a1, 8($sp)		# Restore y coord
	lw $s0, 12($sp)
	addi $sp, $sp, 16	# Free memory
	
	jr $ra			# Return to caller
	
drawW:
	addi $sp, $sp, -16	# Make room on stack
	sw $ra, 0($sp)		# Store original return address value
	sw $a0, 4($sp)		# Store original x coord value
	sw $a1, 8($sp)		# Store original y coord value
	sw $s0, 12($sp)		# Store original $s0
	move $s0, $a2		# Copy color value to $s0
	
	li $a2, 1		# Set color to black for border
	
	# Draw lines
	li $a3, 11
	jal drawVerticalLine
	li $a3, 3
	jal drawHorizontalLine
	addi $a0, $a0, 4
	jal drawHorizontalLine
	addi $a0, $a0, 4
	jal drawHorizontalLine
	addi $a0, $a0, -6
	li $a3, 8
	jal drawVerticalLine
	addi $a0, $a0, 2
	jal drawVerticalLine
	addi $a0, $a0, 2
	jal drawVerticalLine
	addi $a0, $a0, 2
	jal drawVerticalLine
	addi $a0, $a0, 2
	li $a3, 11
	jal drawVerticalLine
	addi $a0, $a0, -9
	addi $a1, $a1, 10
	li $a3, 4
	jal drawHorizontalLine
	addi $a0, $a0, 5
	jal drawHorizontalLine
	addi $a0, $a0, -2
	addi $a1, $a1, -1
	li $a3, 3
	jal drawHorizontalLine
	addi $a0, $a0, -1
	addi $a1, $a1, -2
	jal drawPixel
	addi $a0, $a0, 4
	jal drawPixel
	
	# Fill 
	move $a2, $s0		# Restore original color
	addi $a0, $a0, -6
	addi $a1, $a1, -6
	li $a3, 9
	jal drawVerticalLine
	addi $a0, $a0, 4
	li $a3, 8
	jal drawVerticalLine
	addi $a0, $a0, 4
	li $a3, 9
	jal drawVerticalLine
	addi $a0, $a0, -7
	addi $a1, $a1, 7
	li $a3, 7
	jal drawHorizontalLine
	addi $a1, $a1, 1
	li $a3, 2
	jal drawHorizontalLine
	addi $a0, $a0, 5
	jal drawHorizontalLine
	
	
	lw $ra, 0($sp)		# Restore return address
	lw $a0, 4($sp)		# Restore x coord
	lw $a1, 8($sp)		# Restore y coord
	lw $s0, 12($sp)
	addi $sp, $sp, 16	# Free memory
	
	jr $ra			# Return to caller
	
drawY:
	addi $sp, $sp, -16	# Make room on stack
	sw $ra, 0($sp)		# Store original return address value
	sw $a0, 4($sp)		# Store original x coord value
	sw $a1, 8($sp)		# Store original y coord value
	sw $s0, 12($sp)		# Store original $s0
	move $s0, $a2		# Copy color value to $s0
	
	li $a2, 1		# Set color to black for border
	
	# Draw lines
	li $a3, 7
	jal drawVerticalLine
	addi $a0, $a0, 7
	jal drawVerticalLine
	addi $a0, $a0, -6
	li $a3, 2
	jal drawHorizontalLine
	addi $a0, $a0, 4
	jal drawHorizontalLine
	addi $a0, $a0, -3
	li $a3, 5
	jal drawVerticalLine
	addi $a0, $a0, 3
	jal drawVerticalLine
	addi $a0, $a0, -3
	addi $a1, $a1, 4
	li $a3, 4
	jal drawHorizontalLine
	addi $a1, $a1, 6
	jal drawHorizontalLine
	addi $a1, $a1, -4
	jal drawVerticalLine
	addi $a0, $a0, 3
	jal drawVerticalLine
	addi $a0, $a0, 1
	jal drawPixel
	addi $a0, $a0, -5
	jal drawPixel
	
	
	# Fill 
	move $a2, $s0		# Restore original color
	addi $a1, $a1, -5
	li $a3, 5
	jal drawVerticalLine
	addi $a0, $a0, 5
	jal drawVerticalLine
	addi $a0, $a0, -5
	addi $a1, $a1, 4
	jal drawHorizontalLine
	addi $a0, $a0, 2
	jal drawVerticalLine
	addi $a0, $a0, 1
	jal drawVerticalLine
	
	
	lw $ra, 0($sp)		# Restore return address
	lw $a0, 4($sp)		# Restore x coord
	lw $a1, 8($sp)		# Restore y coord
	lw $s0, 12($sp)
	addi $sp, $sp, 16	# Free memory
	
	jr $ra			# Return to caller
	
drawL:
	addi $sp, $sp, -16	# Make room on stack
	sw $ra, 0($sp)		# Store original return address value
	sw $a0, 4($sp)		# Store original x coord value
	sw $a1, 8($sp)		# Store original y coord value
	sw $s0, 12($sp)		# Store original $s0
	move $s0, $a2		# Copy color value to $s0
	
	li $a2, 1		# Set color to black for border
	
	# Draw lines
	li $a3, 11
	jal drawVerticalLine
	li $a3, 3
	jal drawHorizontalLine
	addi $a0, $a0, 2
	li $a3, 9
	jal drawVerticalLine
	addi $a0, $a0, -2
	addi $a1, $a1, 10
	li $a3, 8
	jal drawHorizontalLine
	addi $a0, $a0, 2
	addi $a1, $a1, -2
	li $a3, 6
	jal drawHorizontalLine
	addi $a0, $a0, 5
	li $a3, 2
	jal drawVerticalLine
	
	# Fill 
	move $a2, $s0		# Restore original color
	addi $a0, $a0, -6
	addi $a1, $a1, -7
	li $a3, 9
	jal drawVerticalLine
	addi $a1, $a1, 8
	li $a3, 6
	jal drawHorizontalLine
	
	
	lw $ra, 0($sp)		# Restore return address
	lw $a0, 4($sp)		# Restore x coord
	lw $a1, 8($sp)		# Restore y coord
	lw $s0, 12($sp)
	addi $sp, $sp, 16	# Free memory
	
	jr $ra			# Return to caller
	