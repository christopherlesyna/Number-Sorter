######################
#                    #
# Project Submission #
#                    #
######################

# Partner1: Keshav Choudhary, (A98123008)
# Partner2: Christopher Lesyna, (A10455271)

# Linked list structure
# int data 4 bytes
# node next_address 4 bytes

	.data
printIntro:	.asciiz "The linked list contains:\n"
printSorted:	.asciiz "The sorted linked list contains:\n"
printNL:	.asciiz "\n"
printComma:	.asciiz ", "
arrLen:		.word 500
randnums:	.word 3859,-4698,2684,3580,-107,4685,2850,-2449,-850,-1513,-2140,105,2233,-2255,-4245,2723,4385,-4781,1573,2270,3205,2186,-3573,-4601,-3505,2872,3146,4352,-3905,117,-3086,2223,323,-578,-1371,1228,-585,3545,848,-2233,672,1070,-551,2185,540,-2147,3327,-2468,-1561,4438,146,-4290,-3697,2505,-1186,3404,2836,2229,-3906,3931,-2162,4472,-2467,-301,-46,1628,4990,-2767,-4455,741,-2150,-291,-371,2066,-4070,-3566,-4225,3741,-1629,-4965,643,-2242,-3023,1547,-232,3631,988,-3355,-2687,3596,-1731,1559,3179,3211,-1577,-194,1671,-2274,3655,4451,1322,-3859,-3260,-1541,3965,-1357,-125,3344,-1702,1550,4705,2725,45,569,-1192,-4556,1392,-2905,3719,2989,3775,3113,3894,3698,-4001,3399,-4575,-412,1496,1488,-3,-2256,2242,-3827,-3535,-2522,2837,-3307,-2331,-2763,4856,3323,-4800,646,1505,4187,-4171,4142,693,4669,-3651,-811,-3186,-4490,3600,3045,-1797,-4572,-1617,3526,-1744,1903,4634,-2280,-582,1586,2787,-577,1382,3537,3886,1956,-620,-1354,2237,1787,4546,-3845,-2873,-1088,2101,4266,-2527,1995,3105,-2350,-2009,-4175,-1033,3710,-1355,-1208,-3800,-1142,-964,3603,-1383,-2622,-314,-4221,2203,553,-3585,3100,-1399,2588,678,-195,1262,-2534,-4298,-2759,-448,4708,414,4627,-1304,-4573,-4881,4181,-4279,2012,4711,2137,2329,2828,-1125,2214,-166,883,1649,4519,-3457,294,4509,2569,-4022,2888,-2342,2348,3657,2679,3581,3570,1919,4868,-4985,4343,1466,214,-849,1027,4047,-460,3345,855,31,375,2566,-3337,-1989,1146,708,-1239,-3117,-3220,-3083,3817,1964,4139,2201,-407,2692,-1464,-4887,-799,-355,3591,-3423,-67,-3839,1622,-4733,383,-1414,1740,-3761,4154,-1704,4398,1355,-4219,658,4790,-3878,-4422,-3606,3062,-2250,-4841,3799,-2976,602,761,-4849,819,1295,-2700,-3514,-3681,-4707,-131,-4738,4663,3801,849,-2896,-573,3883,4100,1709,-3075,-509,-1499,-4793,-4260,-1290,-36,4875,-2380,2002,1521,-2604,-4867,-2710,4857,-2835,2838,-498,4226,-239,3732,4169,928,3060,4344,4821,4439,-4033,4,-4528,1857,-4866,2834,-2407,-1537,-3042,-1062,3094,-4874,2287,2083,-4503,-116,1170,86,3216,4567,-745,-863,-3680,3670,-2206,-333,3348,4814,1017,357,-2792,1345,577,845,4444,3625,-2703,3840,498,-433,4683,4935,-1569,-3901,-1263,-2236,-4606,-4844,-4603,4516,3663,4297,-2744,-3746,-2926,-2367,-1039,2527,4102,3666,-1473,-4128,-2794,-2807,-8,2366,-1990,-2311,1940,2150,4499,-3286,-2287,1548,-3892,2084,2498,1873,1503,-3804,3171,2108,1088,-2292,3137,-3214,-2851,-4695,996,-2770,3731,1095,1714,1743,2668,2259,3662,-1416,810,4832,-127,-3842,4355,-3812,801,1432,-3109,-570,814,-2559,4568,-2563,3954,2533,-218,922,-1103,293,-4535,3676,1657,1315,-3545,2621,2113,2475,-3247,4964,-3469,3333,-918,-2469,-1246,2429,-4675,3789,-640,-3135,797,-4116,506,1400,-2750,-3174,22,3193,3358,40,1103,-1830,574,1752

	.globl main
	.globl root
	.globl push
	.globl mergeSort
	.globl mergeUp
	.globl splitHalf
	.globl printList
	.globl importList

	.text
############
#   main   #
############

main:

	# (your code here)
	la $a0, randnums # grab array starting memory address 
	
	la $t1, arrLen	# grab the array length from memory
	lw $a1, 0($t1)
	
	#addi $a1, $zero, 20 # load the first 20 elements for testing
	
	addi $sp, $sp, -4 # shift stack register and push 
	sw $ra, 0($sp)	  # $ra onto it

	jal importList # import the list from the given array

	addu $s7, $v0, $0 #save linked list head
	
	la $a0, printIntro # print out preamble to printList
	addiu $v0, $zero, 4
	syscall 

	addu $a0, $s7, $0 # restore $a0 to linked list header
			  # before calling printList

	jal printList

	addu $a0, $s7, $0 # no guarantees printList didn't affect
			  # $a0, so reload from saved point
	jal mergeSort
	
	addu $s7, $v0, $0 #save the new linked list head 
	
	la $a0, printSorted # print out preamble to sorted printList
	addiu $v0, $zero, 4
	syscall 

	addu $a0, $s7, $0 # restore $a0 to linked list header
			  # before calling printList

	jal printList
	
	lw $ra, 0($sp)	  # pop the stack to restore $ra 
	addi $sp, $sp, 4  # increment stack pointer to release memory for reuse
	
	# return to caller
	jr 	$ra


#################
#   root_node   #
#################   THIS IS DONE.  DO NOT TOUCH.  

root:
	# (Establishes the original node of the linked list)
	# $a0 holds the value to store
	# use sbrk to find the next free part of heap 
	# $v0 returns the new head of the linked list
# $t1 is the address of the allocated memory for root.  
# Data first, address second in node. 

	addu $t0, $a0, $0  #store the value of the node into a temporary register since a0 is used in syscall
    
	li $v0, 9 #sets up sbrk function for syscall
	li $a0, 8 #allocates 8 bytes of memory, 32 bits for int value, 32 bits for address
	syscall #executes memory allocation
	move $a0, $t0 #restores the value (first element of array) 
	sw $a0, 0($v0) #put integer into first part of our node
	sw $0, 4($v0)  #store NULL into the second half of the node. 
	# return to caller
	jr 	$ra

#################
#   push_node   #
#################  THIS IS DONE.  DO NOT TOUCH.  

push:
	# Pushes a new node on to the top of the linked list
	# use sbrk to find the next free part of heap 
	# $a0 holds the value to store
	# $a1 holds the head of the linked list
	# $v0 holds the new head of the linked list
           
	add $t2, $a0, $zero  #store a0, first value into a temporary, because SBRK needs a0. 
	add $t3, $v0, $zero  #store v0, address of last created node, into temp because SBRK needs v0

	li $v0, 9  #syscall sbrk protocol
	li $a0, 8  #32 bits for int, 32 bits for address.  
	syscall

	add $a0, $t2, $zero #restore $a0 to value to be placed in node, SBRK is done.  

	sw $a0, 0($v0)  #Store new value in $a0 into newly created memory at $v0.  
	sw $a1, 4($v0)  #Store address of previous node, into second half of memory v0.  

	# return to caller
	jr 	$ra


#################
#  Merge_Sort   #
#################

mergeSort:

	# Break linked list into fragments recursively and then
	# reassemble nodes into sequentially increasing linked list
	# This sort must maintain stability
	# $a0 holds the address of the top of the linked list
	# $v0 holds the header of the sorted merge

	beq $a0, $zero, NULLHEAD #checking if(head==null)          #STEP 1
	lw $t0, 4($a0) #store head-->next into temporary, $t0.     #STEP 1
	beq $t0, $zero, NULLHEAD #checking if(head--next==null)	   #STEP 1

		#PUSH for the $ra
		addi $sp, $sp, -4 # shift stack register and push 
		sw $ra, 0($sp)	  # $ra onto stack so it is not overwritten when mergeSort is called recursively.

	#PUSH for the $a0 head address on first list
	addi $sp, $sp, -4 # shift stack register and push 
	sw $a0, 0($sp)	  # $a0 onto stack, which is head address of linked list made by splithalf so it is not overwritten when mergeSort is called recursiv

	jal splitHalf  # Step 2

	#PUSH for the $v0 head address on first list
	addi $sp, $sp, -4 # shift stack register and push 
	sw $v0, 0($sp)	  # $v0, THE RESULT FROM SPLITHALF onto stack, which is head address of first sublist made by splithalf so it is not overwritten when mergeSort is called recursively.
	#PUSH for the $v1 head address on second sublist
	addi $sp, $sp, -4 # shift stack register and push 
	sw $v1, 0($sp)	  # $v1, THE RESULT FROM SPLITHALF onto stack, which is head address of second sublist made by splithalf so it is not overwritten when mergeSort is called recursively.
	
	add $a0, $v0, $zero # update a0 for the splithalf function with head of first sublist.

##################################################################
	jal mergeSort  # mergeSort on first sublist, Step 3

	RETURNFROMFIRSTMERGESORT:  
	#PULL for $v1
	lw $v1, 0($sp)	  # pop the stack to restore $v1
	addi $sp, $sp, 4  # increment stack pointer to release memory for reuse

	#addi $sp, $sp, 4 # increment stack pointer to release unneeded v0.  

	#PUSH for the $v0 head address on first list, will be overwritten on recursive mergeSort.
	#addi $sp, $sp, -4 # shift stack register and push 
	sw $v0, 0($sp)	  #store new v0, result from the first mergesort over the old v0.  
	
	add $a0, $v1, $zero  #update a0 for the splitHalf function with the head of the second sublist. 
	jal mergeSort  # mergeSort on second sublist, Step 4

	RETURNFROMSECONDMERGESORT:
	add $a1, $v0, $zero #store address of second mergesort into a1 for mergeup.   This is the result from the upper mergeSort.  

	#PULL for $v0
	lw $a0, 0($sp)	  # pop the stack to restore $v0 into a0 for the mergeup
	addi $sp, $sp, 4  # increment stack pointer to release memory for reuse	

	

		
	
####################################################################
	
	
	

	jal mergeUp # Step 4, merge the two sublists up

	addi $sp, $sp, 4 # increment stack pointer to release unneeded v0.  

	

		#PULL for $RA
		lw $ra, 0($sp)	  # pop the stack to restore $ra
		addi $sp, $sp, 4  # increment stack pointer to release memory for reuse
	

	#v0 will contain the head of the linked list as per mergeUp.  	

	j JUMPOVERNULLHEAD

	NULLHEAD: add $v0, $zero, $a0 #Return head if head = null or head-->next = null

	JUMPOVERNULLHEAD:

	# return to caller
	jr 	$ra

###################
#     mergeUp     #
###################

mergeUp:
	# Merges the two sublists into a single sorted list
	# $a0 contains head address of rst sub-list (A)
	# $a1 contains head address of second sub-list (B)
	# $v0 returns the head address of the combined list


	addi $sp, $sp, -4 # shift stack register and push 
	sw $ra, 0($sp)	  # store return address $ra onto stack

	beq $a0, $zero, RETURNB # if(A=NULL) return B  #STEP 1
	beq $a1, $zero, RETURNA # if(B=NULL) returb A  #STEP 2

	lw $t6, 0($a0) #store A->Data into temporary registers
	lw $t7, 0($a1) #store B->Data into temporary registers

	beq $t6, $t7, A_LTEQ_B #3.5 3, if(A->data <= B->data)
	slt $t5, $t6, $t7

		bne $t5, $zero, A_LTEQ_B
			add $v0, $a1, $zero #return head = B in case if(Bdata < Adata), STEP 4
			#PUSH for the $v0 head address on first list
			addi $sp, $sp, -4 # shift stack register and push 
			sw $v0, 0($sp)	  # store $v0 onto stack, which is head address of combined list from previous mergeuup.  This will be overwritten.	
				#PUSH for the $a1 head address on second list
				addi $sp, $sp, -4 # shift stack register and push 
				sw $a1, 0($sp)	  # store $a1 onto stack, which is head address of second sublist made 
			lw $a1, 4($a1) #load B-Next into a1 for next mergeup.
			jal mergeUp #step 3.5 4b  head->next = mergeUp(A->next, B)
				#PULL for $a1
				lw $a1, 0($sp)	  # pop the stack to restore $a1
				addi $sp, $sp, 4  # increment stack pointer to release memory for reuse	
			sw $v0, 4($a1) #finish step 3.5 4B, head->next = mergeU(A, B->Next)
			#PULL for $v0
			lw $v0, 0($sp)	  # pop the stack to restore $v0
			addi $sp, $sp, 4  # increment stack pointer to release memory for reuse
		j OUT

		A_LTEQ_B:  #STEP 3
			add $v0, $a0, $zero #return head = A in case that Bdata > Adata, STEP 3
			#PUSH for the $v0 head address on first list
			addi $sp, $sp, -4 # shift stack register and push 
			sw $v0, 0($sp)	  # $v0 onto stack, which is head address of combined list from previous mergeuup.  This will be overwritten.  
				#PUSH for the $a0 head address on first list
				addi $sp, $sp, -4 # shift stack register and push 
				sw $a0, 0($sp)	  # $a0 onto stack, which is head address of first sublist made 
			lw $a0, 4($a0) #store A-Next into a0 for next mergeup.  
			jal mergeUp # step, 3.5 3B  head->next = mergeUp(A-Next, B)
				#PULL for $a0
				lw $a0, 0($sp)	  # pop the stack to restore $a0
				addi $sp, $sp, 4  # increment stack pointer to release memory for reuse	
			sw $v0, 4($a0) #finish step 3.5 3B
			#PULL for $v0
			lw $v0, 0($sp)	  # pop the stack to restore $v0
			addi $sp, $sp, 4  # increment stack pointer to release memory for reuse
		j OUT		

	OUT:
		

	j RETURNFROMMERGEUP


	RETURNB: 
	add $v0, $a1, $zero #return the head address of second sub-list (B)  Step 1
	j RETURNFROMMERGEUP

	RETURNA:
	add $v0, $a0, $zero #return the head address of first sub-list (A)  Step 2
	j RETURNFROMMERGEUP

	RETURNFROMMERGEUP:

	lw $ra, 0($sp)	  # pop the stack to restore $ra 
	addi $sp, $sp, 4  # increment stack pointer to release memory for reuse	

	# return to caller
	jr 	$ra


#############
# splitHalf #
#############  THIS IS DONE, DO NOT TOUCH.  

splitHalf:

	# Splits a linked list into two equal halves by 
	# advancing through the linked list at two different
	# speeds (fast and slow).
	# $a0 contains head address linked list
	# $v0 returns the head address of rst sub-list
	# $v1 returns the head address of second sub-list

	add $v0, $a0, $zero  #set the head to be returned
	add $v1, $zero, $zero  #set null to be returned (overwritten later if not null protocol)
	
	beq $a0, $zero, NULLHEADSPLITHALF #checking if(head==null)
	lw $t2, 4($a0) #store head-->next into temporary, $t2.
	beq $t2, $zero, NULLHEAD #checking if(head--next==null)	

	add $t2, $a0, $zero #slow register stored in t2, step 2
	lw $t3, 4($a0) #put fast address into t3.  Completes step 3.  
	

	loop: beq $t3, $zero, TAILFOUNDLONG  #This will jump out of the loop once it finds a null in fast
	lw $t3, 4($t3) #Complete step 4a, fast = fast->next
		beq $t3, $zero, innernull  #if fast != null
		lw $t3, 4($t3) #put fast address into t3.  Completes step 4bi. fast = fast-next
		lw $t2, 4($t2) #put slow address into t2, completes step 4bii.  slow = slow-next
		innernull:  #the fast loop hits a null.
	j loop

	TAILFOUNDLONG:

	lw $v1, 4($t2) # return head address of second sublist
	sw $zero, 4($t2) # null terminate slow->next in the first sublist.  

	NULLHEADSPLITHALF: 
	# return to caller
	jr $ra


################
#  print_list  #
################

printList:

	# Prints the data in list from head to tail
	# $a0 contains head address of list

	addu $t0, $a0, $zero 	# since $a0 is used for syscalls, 
				# move pointer to temp register

printloop:

	beq $t0, $zero, printDone  # jump out once end of list found
	lw $t1, 4($t0)		   # grab next pointer and store in $t1
	lw $a0, 0($t0)		   # grab value at present node
	addiu $v0, $zero, 1	   # prepare to print integer
	syscall
	
	la $a0, printComma	   # load comma and print string
	addiu $v0, $zero, 4
	syscall
	
	addu $t0, $t1, $zero	   # move next pointer into $t0 for next loop
	j printloop

printDone:
	la $a0, printNL		# load newling character and print
	addiu $v0, $zero, 4
	syscall

	# return to caller
	jr 	$ra

#################
#  import_list  #
#################  We think this is done, we need to check it

importList:
	
	# $a0 holds array address
	# $a1 holds array length
	# $v0 returns header to linked list

	addi $sp, $sp, -4 # shift stack register and push 
	sw $ra, 0($sp)	  # $ra onto it

	addi $sp, $sp, -4 # shift stack register and push 
	sw $a0, 0($sp)	  # $a0 onto it

	beq $0, $a0, ERRORNULL  #put null in $v0, since array address in $a0 is NULL
	beq $0, $a1, ERRORNULL

	add $t5, $a0, $zero #store the address of the array into temporary.
	lw $a0, 0($a0) #take the first value from list and put it in $a0 for root, which overwrites.  
	jal root  #Call the Root function to establish first node.

	addu $a0, $t5, $0  #puts address of the initial value back into a0

	addu $a0, $a0, 4 #i = i+1, increment address to point to next element of data array
	addu $s0, $a1, $0 #put a1 size into a saved register, as a1 is needed elsewhere.  
	addi $s0, $s0, -1  #decrement size counter by 1.  
	add $t4, $a1, $zero #push needs a1 to hold head of linked list, but inporlist needs a1 to hold size.  

#loop, while size>0

IMPORTDATA:
	beq $0, $s0, IMPORTDONE  #When value a1 becomes zero, jump to ZERO
	addu $t0, $a0 $0 #a0 temporarily stores address of the node
	lw $a0, 0($a0) # push needs a0 to contain the value to be placed in node
	add $a1, $v0, $zero #puts address of head of list into a1 for push.

	jal push

	add $a0, $t0, $zero # restores the address of the array of element we're currently on.
	addu $a0, $a0, 4 #i = i+1, increment address to point to next element of data array
 	addi $s0, $s0, -1  #decrement size of array counter
	j IMPORTDATA  #jump back to loop, where comparison occurs.
	#$v0 will be the head of the linked list. 
	lw $a1, 0($t4)  #restore $a1, put length of array back into a1

	IMPORTDONE:

	j RETURN

ERRORNULL:
addu $v0, $0, $0  #protocol if $a0 contains NULL or $a1 contains 0

RETURN:
lw $a0, 0($sp)	  # pop the stack to restore $a0
addi $sp, $sp, 4  # increment stack pointer to release memory for reuse
lw $ra, 0($sp)	  # pop the stack to restore $ra
addi $sp, $sp, 4  # increment stack pointer to release memory for reuse

	# return to caller
	jr $ra

# Register Map
# 

# Main uses 
# $t1 contains ArrLen, the address of the array length.  
# $a0 contains starting address of the array.  

# Importlist uses
	# $a0 holds array address
	# $a1 holds array length
	# $v0 returns header to linked list
	# $s0 holds array length, which will be decremented
	# $t4 Temporarily holds a1, the array length, because push needs a1 to hold head of linked list.  
	# $t5 Temproraryily holds $a0, the address of the array into t0.  

# Root uses
# $t0 to TEMPORARILY hold $a0, the VALUE of the first element of array for syscall. Overwrite possible.  
# $v0 points to the address of the last node created.  

# Push uses
# $t2 for temporary value of a0, the value to store, Temporary use only during Push.

# Printlist uses
# 


#Splithalf uses
# $t2 is for slow
# $t3 is for fast

#Mergeup uses
# $t6 for A->Data
# $t7 for B->Data
