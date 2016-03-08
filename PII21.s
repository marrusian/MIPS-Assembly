#II.21) (2 puncte)
# Program care calculeaza produsul scalar a doi vector de bytes (vectorii sunt
#  dati sub forma a doua variabile initializate la declarare cu cate un sir
#  de bytes, iar lungimea lor printr-o variabila initializata de asemenea la
#  declarare).

					.data
barr1:				.byte 2 5 -2 -10 55 -56 88
barr2:				.byte 10 -59 82 11 33 24 6
					.align 4
lgth:				.word 7
dotprod:			.word 0
done:				.asciiz "Produsul scalar dintre cei doi vectori este: "			
		
					.text
					
					.globl main
					.ent main
main:

# ----
# Compute Dot Product
					la $t0,barr1
					la $t1,barr2
					lw $t2,lgth					# index
					li $t3,0					# Result
					
dotProduct:			beqz $t2,endDP
					lb $t4,($t0)
					lb $t5,($t1)
					mul $t4,$t4,$t5
					add $t3,$t3,$t4
					addiu $t0,$t0,1
					addiu $t1,$t1,1
					sub $t2,$t2,1
					j dotProduct
endDP:				
					sw $t3,dotprod

# ----
# Announce Result
					la $a0,done
					li $v0,4
					syscall
					lw $a0,dotprod
					li $v0,1
					syscall

# ----
# Exit					
					li $v0,10
					syscall
					.end main