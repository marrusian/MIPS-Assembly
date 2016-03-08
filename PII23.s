#II.23) (5 puncte)
# Program care determina elementele distincte dintr-un vector de word si
#  le pune intr-un nou vector. Vectorul sursa va fi dat sub forma unei
#  variabile initializata la declarare cu un sir de word-uri, iar lungimea
#  lui printr-o variabila initializata de asemenea la declarare. Pentru
#  vectorul rezultat se va declara o variabila .space (urmata de suficienti
#  bytes neinitializati).
#  Ex: 4, 2, 1, 2, 2, 1, 3 --> 4, 2, 1, 3

					.data
warr:				.word 4 2 1 2 2 1 3
lgth:				.word 7
lgthuq:				.word 0
uqwarr:				.space 100					
done:				.asciiz "Noul vector este: "
blank:				.asciiz " "

					.text
					
					.globl main
					.ent main
main:

# ----
# Construct new vector	
					la $t0,warr
					la $t1,uqwarr
					lw $t2,lgth					# index
					li $t7,0					# $t7 = size(uqwarr)
					
					subu $sp,$sp,8
uniqueCopy:			beqz $t2,endUC		
					sw $t1,($sp)
					sw $t7,4($sp)
					
					la $t1,uqwarr
					lw $t3,($t0)				# $t3 = warr[i]
					
	search:			beqz $t7,endSearch			# while(n && uqwarr[i]!=warr[j])
					lw $t4,($t1)				# $t4 = uqwarr[j]
					beq $t3,$t4,endSearch
					addiu $t1,$t1,4
					sub $t7,$t7,1
					j search
	endSearch:
	
					lw $t1,($sp)
					move $t8,$t7
					lw $t7,4($sp)
	if01:			bnez $t8,endif01
					lw $t8,($t0)
					sw $t8,($t1)
					addiu $t1,$t1,4
					addiu $t7,$t7,1
	endif01:
	
					addiu $t0,$t0,4
					sub $t2,$t2,1
					j uniqueCopy
endUC:
					addu $sp,$sp,8
					sw $t7,lgthuq

# ----
# Announce results
					la $a0,done
					li $v0,4
					syscall
					
					la $t0,uqwarr
					lw $t1,lgthuq
					
showElem:			beqz $t1,endSE
					lw $a0,($t0)
					li $v0,1
					syscall
					addiu $t0,$t0,4
					sub $t1,$t1,1
					la $a0,blank
					li $v0,4
					syscall
					j showElem
endSE:					
# ----
# Exit
					li $v0,10
					syscall
					.end main