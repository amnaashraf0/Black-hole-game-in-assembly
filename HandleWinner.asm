# Calculate scores
# Calculate the score of both player and computer by manually choosing correct adjacent black hole circles
# input - circleValues - end of game values
# input - circleTeams - end of game values
# input - layerWidth
# input - pyramidPosition
# input - $s3 - black hole index
# return - $v0 - player score
# return - $v1 - computer score
calculateScores:
	addi $sp, $sp, -4		# Make room in stack
	sw $ra 0($sp)			# Store original $ra
	
	li $v0, 0	# Set player sum to 0
	li $v1, 0	# Set computer sum to 0
	
	jal findBlackHole		# Store black hole index in $s3

	# Get relative position of black hole in pyramid
	la $t0, pyramidPosition		# Load pyramidPosition array
	sll $t1, $s3, 2  		# Multiply black hole index by 4 to get array offset
	add $t0, $t0, $t1		# Add array offset
	lw $t2, 0($t0)			# Store pyramid position in $t2

	# Get the correct adjacent circles based on black hole position
	# 0 = top of pyramid, 1 = left, 2 = center, 3 = right, 4 = left corner, 5 = right corner, 6 = bottom
	li $t3, 0
	beq $t2, $t3, topPosition	# For example, if the black hole is at the top, check the bottom two circles
	li $t3, 1
	beq $t2, $t3, leftPosition
	li $t3, 2
	beq $t2, $t3, centerPosition
	li $t3, 3
	beq $t2, $t3, rightPosition
	li $t3, 4
	beq $t2, $t3, leftCornerPosition
	li $t3, 5
	beq $t2, $t3, rightCornerPosition
	li $t3, 6
	beq $t2, $t3, bottomPosition
	
	# Manually choose the correct adjacent circles based on black hole position
	topPosition:			# Bottom left and bottom right
		jal getBottomLeft
		jal getBottomRight
		j exitAdjacent
	leftPosition: 			# Top right, right, bottom right, bottom left
		jal getTopRight
		jal getRight
		jal getBottomRight
		jal getBottomLeft
		j exitAdjacent
	centerPosition: 		# All surrounding circles
		jal getBottomLeft
		jal getBottomRight 
		jal getLeft
		jal getRight
		jal getTopLeft
		jal getTopRight
		j exitAdjacent
	rightPosition:			# Top left, left, bottom left, bottom right
		jal getTopLeft
		jal getLeft
		jal getBottomLeft
		jal getBottomRight
		j exitAdjacent
	leftCornerPosition: 		# Top right, right
		jal getTopRight
		jal getRight
		j exitAdjacent
	rightCornerPosition: 		# Top left, left
		jal getTopLeft
		jal getLeft
		j exitAdjacent
	bottomPosition: 		# Left, top left, top right, right
		jal getLeft
		jal getTopLeft
		jal getTopRight
		jal getRight
		j exitAdjacent
			
	exitAdjacent: 			# Once all adjacent circles have been visited, exit 
		lw $ra 0($sp) 		# Restore original return address
		addi $sp, $sp, 4 	# Free stack memory
		jr $ra 			# Return to caller

# Find black hole
# Find and return the index of the black hole circle
# input - circleValues - end of game values
# return - $s3 - black hole index
findBlackHole:
	la $t0, circleValues	# Load array address
	la $t1, 0		# Current index
	
	# Loop through array until 0 is found
	blackHoleLoop:
		lw $t2 0($t0)			# $t2 = circleValues[i]
		beq $t2, $zero, foundBlackHole	# Check if black hole found
		addi $t1, $t1, 1		# i++
		addi $t0, $t0, 4		# Move address pointer to next value
		j blackHoleLoop
		
	foundBlackHole:
		move $s3, $t1			# Save black hole index
		
	jr $ra					# Return to caller


# Get bottom left
# Calculates the offset to get the bottom left circle from the black hole
# Adds the value of the bottom left circle to correct team (player/computer)
# input - $s3 - black hole index
# return - $v0 - player score after adding circle
# return - $v1 - computer score after adding circle
getBottomLeft:
		# Load necessary arrays
		la $t0, circleValues 	
		la $t1, circleTeams 
		la $t2, layerWidth
		
		# Get layer width of black hole layer
		sll $t3, $s3, 2		# Store black hole index offset
		add $t2, $t2, $t3	# Add offset to layerWidth
		lw $t4, 0($t2)		# Store the width of the layer the black hole is on in $t4
		sll $t4, $t4, 2		# Multiply width by 4 to get width offset
		
		add $t5, $t3, $t4	# Bottom left circle address = black hole offset + layer wdith offset
		
		# Get value of circle
		add $t0, $t0, $t5	# Add calculated offset
		lw $t6 0($t0)		# $t6 = bottom left circle value
		
		# Get team of circle
		add $t1, $t1, $t5	# Add calculated offset
		lw $t7 0($t1)		# $t7 = bottom left team value
		
		# Add points to correct team
		li $t8, 1
		beq $t7, $t8, addToPlayer	# If bottom left circle is player's circle, add circle value to player score ($v0)
		add $v1, $v1, $t6		# If not, add circle value to computer score ($v1)
		jr $ra				# Return to caller
		
		addToPlayer:
			add $v0, $v0, $t6 	# Add circle value to player score ($v0)
			jr $ra 			# Return to caller
	
# Get bottom right
# Calculates the offset to get the bottom right circle from the black hole
# Adds the value of the bottom right circle to correct team (player/computer)
# input - $s3 - black hole index
# return - $v0 - player score after adding circle
# return - $v1 - computer score after adding circle
getBottomRight:
		# Load necessary arrays
		la $t0, circleValues 	
		la $t1, circleTeams 
		la $t2, layerWidth
		
		# Get layer width of black hole layer
		sll $t3, $s3, 2		# Store black hole index offset
		add $t2, $t2, $t3	# Add offset to layerWidth
		lw $t4, 0($t2)		# Store the width of the layer the black hole is on in $t4
		sll $t4, $t4, 2		# Multiply width by 4 to get width offset
		
		# Bottom right circle address = black hole offset + layer wdith offset + 4
		# Aka: bottom right index = black hole index + layer width + 1
		add $t5, $t3, $t4
		addi $t5, $t5, 4
		
		# Get value of circle
		add $t0, $t0, $t5	# Add calculated offset
		lw $t6 0($t0)		# $t6 = bottom right circle value
		
		# Get team of circle
		add $t1, $t1, $t5	# Add calculated offset
		lw $t7 0($t1)		# $t7 = bottom right team value
		
		# Add points to correct team
		li $t8, 1
		beq $t7, $t8, addToPlayer2	# If bottom right circle is player's circle, add circle value to player score ($v0)
		add $v1, $v1, $t6		# If not, add circle value to computer score ($v1)
		jr $ra				# Return to caller
		
		addToPlayer2:
			add $v0, $v0, $t6 	# Add circle value to player score ($v0)
			jr $ra 			# Return to caller
		 
# Get left
# Calculates the offset to get the left circle from the black hole
# Adds the value of the left circle to correct team (player/computer)
# input - $s3 - black hole index
# return - $v0 - player score after adding circle
# return - $v1 - computer score after adding circle
getLeft:
		# Load necessary arrays
		la $t0, circleValues 	
		la $t1, circleTeams 
		la $t2, layerWidth
		
		# Get layer width of black hole layer
		sll $t3, $s3, 2		# Store black hole index offset
		add $t2, $t2, $t3	# Add offset to layerWidth
		lw $t4, 0($t2)		# Store the width of the layer the black hole is on in $t4
		sll $t4, $t4, 2		# Multiply width by 4 to get width offset
		
		# Left circle address = black hole offset - 4
		# Aka: left circle index = black hole index - 1
		addi $t5, $t3, -4

		# Get value of circle
		add $t0, $t0, $t5	# Add calculated offset
		lw $t6 0($t0)		# $t6 = left circle value
		
		# Get team of circle
		add $t1, $t1, $t5	# Add calculated offset
		lw $t7 0($t1)		# $t7 = left circle team value
		
		# Add points to correct team
		li $t8, 1
		beq $t7, $t8, addToPlayer3	# If left circle is player's circle, add circle value to player score ($v0)
		add $v1, $v1, $t6		# If not, add circle value to computer score ($v1)
		jr $ra				# Return to caller
		
		addToPlayer3:
			add $v0, $v0, $t6 	# Add circle value to player score ($v0)
			jr $ra 			# Return to caller
			
			
# Get right
# Calculates the offset to get the right circle from the black hole
# Adds the value of the right circle to correct team (player/computer)
# input - $s3 - black hole index
# return - $v0 - player score after adding circle
# return - $v1 - computer score after adding circle
getRight:
		# Load necessary arrays
		la $t0, circleValues 	
		la $t1, circleTeams 
		la $t2, layerWidth
		
		# Get layer width of black hole layer
		sll $t3, $s3, 2		# Store black hole index offset
		add $t2, $t2, $t3	# Add offset to layerWidth
		lw $t4, 0($t2)		# Store the width of the layer the black hole is on in $t4
		sll $t4, $t4, 2		# Multiply width by 4 to get width offset
		
		# Right circle address = black hole offset + 4
		# Aka: right circle index = black hole index + 1
		addi $t5, $t3, 4

		# Get value of circle
		add $t0, $t0, $t5	# Add calculated offset
		lw $t6 0($t0)		# $t6 = right circle value
		
		# Get team of circle
		add $t1, $t1, $t5	# Add calculated offset
		lw $t7 0($t1)		# $t7 = right circle team value
		
		# Add points to correct team
		li $t8, 1
		beq $t7, $t8, addToPlayer4	# If right circle is player's circle, add circle value to player score ($v0)
		add $v1, $v1, $t6		# If not, add circle value to computer score ($v1)
		jr $ra				# Return to caller
		
		addToPlayer4:
			add $v0, $v0, $t6 	# Add circle value to player score ($v0)
			jr $ra 			# Return to caller
		
# Get top left
# Calculates the offset to get the top left circle from the black hole
# Adds the value of the top left circle to correct team (player/computer)
# input - $s3 - black hole index
# return - $v0 - player score after adding circle
# return - $v1 - computer score after adding circle
getTopLeft:
		# Load necessary arrays
		la $t0, circleValues 	
		la $t1, circleTeams 
		la $t2, layerWidth
		
		# Get layer width of black hole layer
		sll $t3, $s3, 2		# Store black hole index offset
		add $t2, $t2, $t3	# Add offset to layerWidth
		lw $t4, 0($t2)		# Store the width of the layer the black hole is on in $t4
		sll $t4, $t4, 2		# Multiply width by 4 to get width offset
		
		# Top left circle address = black hole offset - layer width offset
		sub $t5, $t3, $t4

		# Get value of circle
		add $t0, $t0, $t5	# Add calculated offset
		lw $t6 0($t0)		# $t6 = top left circle value
		
		# Get team of circle
		add $t1, $t1, $t5	# Add calculated offset
		lw $t7 0($t1)		# $t7 = top left circle team value
		
		# Add points to correct team
		li $t8, 1
		beq $t7, $t8, addToPlayer5	# If top left circle is player's circle, add circle value to player score ($v0)
		add $v1, $v1, $t6		# If not, add circle value to computer score ($v1)
		jr $ra				# Return to caller
		
		addToPlayer5:
			add $v0, $v0, $t6 	# Add circle value to player score ($v0)
			jr $ra 			# Return to caller
				
# Get top right
# Calculates the offset to get the top right circle from the black hole
# Adds the value of the top right circle to correct team (player/computer)
# input - $s3 - black hole index
# return - $v0 - player score after adding circle
# return - $v1 - computer score after adding circle
getTopRight:
		# Load necessary arrays
		la $t0, circleValues 	
		la $t1, circleTeams 
		la $t2, layerWidth
		
		# Get layer width of black hole layer
		sll $t3, $s3, 2		# Store black hole index offset
		add $t2, $t2, $t3	# Add offset to layerWidth
		lw $t4, 0($t2)		# Store the width of the layer the black hole is on in $t4
		sll $t4, $t4, 2		# Multiply width by 4 to get width offset
		
		# Top right circle address = black hole offset - layer width offset + 4
		# Aka: top right circle index = black hole index - layer width + 1
		sub $t5, $t3, $t4
		addi $t5, $t5, 4

		# Get value of circle
		add $t0, $t0, $t5	# Add calculated offset
		lw $t6 0($t0)		# $t6 = top right circle value
		
		# Get team of circle
		add $t1, $t1, $t5	# Add calculated offset
		lw $t7 0($t1)		# $t7 = top right circle team value
		
		# Add points to correct team
		li $t8, 1
		beq $t7, $t8, addToPlayer6	# If top right circle is player's circle, add circle value to player score ($v0)
		add $v1, $v1, $t6		# If not, add circle value to computer score ($v1)
		jr $ra				# Return to caller
		
		addToPlayer6:
			add $v0, $v0, $t6 	# Add circle value to player score ($v0)
			jr $ra 			# Return to caller

