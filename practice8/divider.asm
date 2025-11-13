.data
.eqv N, 5

ArrayA: .word 10, -20, 7, -8, -8
ArrayB: .word 2, -5, 3, 0, -1
ArrayC: .space 20

.text
.globl main

main:
	addi t0, x0, 0
	addi t1, x0, 20 
	addi t2, x0, 40 
	addi t3, x0, 0
	addi t4, x0, N
	addi a3, x0, 1

loop:
	beq t3, t4, done
	lw a0, 0(t0)
	lw a1, 0(t1) 

	slt t5, a0, x0 
	slt t6, a1, x0
	add s1, t5, t6 
	addi t5, x0, 0 
	beq s1, a3, sign_one
	jal x0, sign_done
sign_one:
	addi t5, x0, 1 
sign_done:
	slt s1, a0, x0
	beq s1, x0, a0_pos
	sub a0, x0, a0
a0_pos:
	slt s1, a1, x0
	beq s1, x0, a1_pos
	sub a1, x0, a1
a1_pos:
	addi a2, x0, 0
	beq a1, x0, apply_sign

DivLoop:
	slt s1, a0, a1
	beq s1, x0, ge_case 
	jal x0, apply_sign
ge_case:
	sub a0, a0, a1
	addi a2, a2, 1
	jal x0, DivLoop

apply_sign:
	beq t5, x0, store_q 
	sub a2, x0, a2
store_q:
	sw a2, 0(t2)

	addi t0, t0, 4
	addi t1, t1, 4
	addi t2, t2, 4
	addi t3, t3, 1
	jal x0, loop

done:
	jal x0, done