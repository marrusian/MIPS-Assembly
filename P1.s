# 1. Program care calculeaza maximul a trei numere.
				.data
# S Y M B O L I C - C O N S T A N T S
LENGTH = 3

# R E G U L A R - V A R I A B L E S
array:			.word 0 0 0
max:			.word 0
prompt:			.asciiz "Introduceti 3 numere intregi: "
done:			.asciiz "Elementul maxim este: "				
				
				.text
				.globl main
				.ent main
main:
# ----
# Prompt
				li $v0,4
				la $a0,prompt
				syscall
# ----
# Fill				
				li $t0,LENGTH			# index
				la $t1,array			# arr[0]
fillArray:
				li $v0,5
				syscall
				sw $v0,($t1)
				add $t1,$t1,4
				sub $t0,$t0,1
				bnez $t0,fillArray		
# ----
# Compute Max			
				li $t0,LENGTH			# iterate n times
				la $t1,array			# arr[0]
				lw $t2,array			# MAX
				
getMax:			lw $t4,($t1)
				slt $t3,$t2,$t4	
  if01:			beqz $t3,endif01
				lw $t2,($t1)
  endif01:		addu $t1,$t1,4
				sub $t0,$t0,1
				bnez $t0,getMax	
				
				sw $t2,max
# ----
# Print Max
				li $v0,4
				la $a0,done
				syscall
				li $v0,1
				lw $a0,max
				syscall
# ----
# Exit
				li $v0,10
				syscall
				.end main