				.data
num:			.word 0
prim:			.byte 0
sqnum:			.word 0
isprime:		.asciiz " is prime\n"
notprime:		.asciiz " is not prime\n"

ITERATIONS = 20
				.text
				
				.globl main
				.ent main
main:

# ----
# Read integer
				li $v0,5
				syscall
				sw $v0,num

# ----
# Check if "num" is prime	

				lw $a0,num
				jal isPrime
				move $v1,$v0

# ----
# Announce the result
				li $v0,1
				lw $a0,num
				syscall
				li $v0,4
 if02:			beqz $v1,else02
				la $a0,isprime
				syscall
				j endif02
 else02:		la $a0,notprime
				syscall	
 endif02:
				li $v0,10
				syscall
				.end main
				
# -------------------------------------------------
				.globl isPrime
				.ent isPrime
# Checks if a number is prime

# ----
# Arguments
#	$a0 - number to be checked
# Returns
#	$v0 - 1 if num is prime
#		- 0 otherwise		
# -------------------------------------------------
isPrime:		
				subu $sp,$sp,4
				sw $ra,($sp)
				jal nSqrt			# Get sqrt(num)
				move $t0,$v0		# $t0 = sqrt(num)
				
				li $t1,2			# $t1 = divisors <= sqrt(num)
				li $v0,1
checkPrime:		bgt $t1,$t0,endPrime	
				rem $t2,$a0,$t1
 if01:			bnez $t2,endif01
				li $v0,0
				j endPrime
 endif01: 
 				addi $t1,$t1,1
				j checkPrime
endPrime:		
				lw $ra,($sp)
				addu $sp,$sp,4
				jr $ra
				.end isPrime		

# -------------------------------------------------
				.globl nSqrt
				.ent nSqrt
# Compute the sqrt using Newton's method.
#	x = N
#	Xn+1 = (Xn + N/Xn)/2

# ----
# Arguments
#	$a0 - N

# Returns
#	$v0 - (int)sqrt(N)
# -------------------------------------------------
nSqrt:
				move $v0,$a0		# $v0 = N
				li $t0,0			# index
CompSQRT:
				div $t1,$a0,$v0
				addu $v0,$t1,$v0
				div $v0,$v0,2
				
				addi $t0,$t0,1
				blt $t0,ITERATIONS,CompSQRT
				
				jr $ra
				.end nSqrt
			