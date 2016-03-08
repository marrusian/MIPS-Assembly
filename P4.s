#5. Program care sorteaza un vector de numere.
				.data
array:			.space 100
n:				.word 0
promptlg:		.asciiz "Introduceti lungimea vectorului: "
promptelem:		.asciiz "Introduceti elementele vectorului: \n"		
done:			.asciiz "Vectorul sortat este: "		
				.text
				
				.globl main
				.ent main
main:
# ----
# Prompt Length
				li $v0,4
				la $a0,promptlg
				syscall
				li $v0,5
				syscall
				sw $v0,n
# ----
# Prompt Elements
				li $v0,4
				la $a0,promptelem
				syscall
				
				lw $t0,n				# index
				la $t1,array			# arr[0]
fillArray:		li $v0,5
				syscall
				sw $v0,($t1)				
				addu $t1,$t1,4
				sub $t0,$t0,1
				bnez $t0,fillArray
				
# ----
# Bubble Sort (Optimized)			
				lw $t1,array			# arr[0]
				li $t2,0				# flag
while:			bnez $t2,endw
				li $t2,0
				lw $t0,n
 while01:		beqz $t0,endw01
  if01:			
  endif01:
				addu $t1,$t1,4
				j while01
 endw01:
				j while
endw:
				
# ----
# Exit
				li $v0,10
				syscall
				.end main