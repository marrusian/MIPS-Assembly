#4. Program care cauta un numar x intr-un vector de numere si pune in y
#  valoarea 1/0 dupa cum x apare/nu apare in vector.
				.data
array:			.word 5 55 12 93 -24 94 -10 42 -44
x:				.word 0
n:				.word 0
promptlgth:		.asciiz "Introduceti lungimea vectorului: "
promptelem:		.asciiz "Introduceti elementul de cautat: "
done:			.asciiz "Element gasit pe pozitia: "
notd:			.asciiz "Elementul nu a fost gasit."
				
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
				move $t0,$v0
# ----
# Prompt X
				li $v0,4
				la $a0,promptelem
				syscall
				li $v0,5
				syscall
				sw $v0,x
				move $t1,$v0				# $t1 = X
# ----
# Look-up X
				la $t2,array				# arr[0]
while:			beqz $t0,endw				# while(n && arr[i]!=X)
				lw $t5,($t2)
				beq $t1,$t5,endw
				addu $t2,$t2,4
				sub $t0,$t0,1
				j while
endw:				

# ----
# Announce Results
if01:			beqz $t0,else01
				li $v0,4
				la $a0,done
				syscall
				li $v0,1
				lw $t1,n
				sub $a0,$t1,$t0
				syscall
				j endif01
else01:			li $v0,4
				la $a0,notd
				syscall
endif01:
# ----
# Exit
				li $v0,10
				syscall
				.end main