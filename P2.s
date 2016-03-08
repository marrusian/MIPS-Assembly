#3. Program care calculeaza suma elementelor unui vector de numere.
				.data
array:			.space 100
n:				.word 0
sum:			.word 0				
promptlgth:		.asciiz "Introduceti lungimea vectorului: "
promptelem:		.asciiz "Introduceti elementele: \n"	
done:			.asciiz "Suma elementelor este: "
				.text
				
				.globl main
				.ent main
main:
# ----
# Prompt Length
				li $v0,4
				la $a0,promptlgth
				syscall
				li $v0,5
				syscall
				sw $v0,n
# ----
# Prompt Elements
				li $v0,4
				la $a0,promptelem
				syscall
# ----
# Fill Array && Sum
				lw $t0,n			# index
				la $t1,array		# arr[0]
				li $t2,0			# sum
fillArray:
				li $v0,5
				syscall
				add $t2,$t2,$v0
				sw $v0,($t1)
				addu $t1,$t1,4
				sub $t0,$t0,1
				bnez $t0,fillArray
				
				sw $t2,sum
# ----
# Announce Sum
				li $v0,4
				la $a0,done
				syscall
				li $v0,1
				lw $a0,sum
				syscall
# ---
# Exit
				li $v0,10
				syscall
				.end main